{{
  config(
    materialized = 'table',
    schema = 'CLEANING',
    description = 'Final / Cleaning layer for expense claims data'
    )
}}

WITH DQ_CHECK AS (
    SELECT
        CLAIM_ID,
        EMPLOYEE_ID,
        CLAIM_DATE,
        UPPER(EXPENSE_TYPE) AS EXPENSE_TYPE,
        CLAIMED_AMOUNT,
        CURRENCY,
        UPPER(APPROVAL_STATUS) AS APPROVAL_STATUS,
        APPROVER_ID,
        CASE
            WHEN CLAIMED_AMOUNT <= 0 THEN 'FAIL'
            ELSE 'PASS'
        END AS CLAIMED_AMOUNT_negative_or_zero_flag,
        CASE
            WHEN {{ check_null_conditions(['CLAIM_ID', 'EMPLOYEE_ID', 'CLAIM_DATE', 'EXPENSE_TYPE', 'CLAIMED_AMOUNT', 'CURRENCY', 'APPROVAL_STATUS']) }} THEN 'FAIL'
            ELSE 'PASS'
        END AS null_condition_flag
    FROM {{ ref('stg_ranked_claims') }}
)

SELECT 
    *
FROM DQ_CHECK
WHERE CLAIMED_AMOUNT_negative_or_zero_flag = 'PASS'
  AND null_condition_flag = 'PASS'