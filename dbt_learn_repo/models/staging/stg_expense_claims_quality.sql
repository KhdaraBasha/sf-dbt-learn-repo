with revenue_checks as (
    {{ check_negative_rev(ref('stg_expense_claims'), ['CLAIMED_AMOUNT']) }}
)

{{ check_nulls(
    'revenue_checks',
    ['CLAIM_ID', 'EMPLOYEE_ID', 'CLAIM_DATE', 'EXPENSE_TYPE', 'CLAIMED_AMOUNT', 'CURRENCY', 'APPROVAL_STATUS']
) }}