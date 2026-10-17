{{ config(materialized='view', schema='STAGING') }}

WITH ranked_claims AS (
    SELECT
        *,
        row_number() OVER (PARTITION BY CLAIM_ID ORDER BY CLAIM_DATE DESC) as row_num
    FROM RAW.PUBLIC.EXPENSE_CLAIMS
)

SELECT
    CLAIM_ID,
    EMPLOYEE_ID,
    CLAIM_DATE,
    UPPER(EXPENSE_TYPE) AS EXPENSE_TYPE,
    CLAIMED_AMOUNT,
    CURRENCY,
    UPPER(APPROVAL_STATUS) AS APPROVAL_STATUS,
    APPROVER_ID
FROM ranked_claims
WHERE row_num = 1