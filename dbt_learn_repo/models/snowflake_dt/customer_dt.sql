{{
    config(
        materialized='dynamic_table',
        snowflake_warehouse='COMPUTE_WH',
        database='SNOWFLAKE_DT',
        schema='TRANSFORM_DT',
        target_lag= 'DOWNSTREAM'
    )
}}

WITH CUSTOMER_DT AS
(
    SELECT 
        CUST_ID,
        CUST_NAME,
        TOTAL_OUTSTANDING_AMT,
        CRID,
        LOCATION,
        CUST_CREATED_DT
    FROM 
        SNOWFLAKE_DT.PUBLIC.CUSTOMER
    QUALIFY ROW_NUMBER() OVER (PARTITION BY CUST_ID ORDER BY CUST_CREATED_DT DESC) = 1
)
SELECT * 
FROM 
    CUSTOMER_DT
