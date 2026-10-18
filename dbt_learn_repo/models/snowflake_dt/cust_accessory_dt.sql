{{
    config(
        materialized='dynamic_table',
        snowflake_warehouse='COMPUTE_WH',
        database='SNOWFLAKE_DT',
        schema='TRANSFORM_DT',
        target_lag= '3 MINUTES'
    )
}}

WITH Cust_Accessory_DT AS
(
    SELECT 
        c.CUST_ID,
        c.CUST_NAME,
        c.CRID,
        c.LOCATION,
        c.CUST_CREATED_DT,
        a.ACC_ID,
        a.ACC_CATEGORY,
        a.ACC_STATUS,
        a.PRICE
    FROM 
        {{ ref('customer_dt') }} AS c,
        {{ ref('accessory_dt') }} AS a
    WHERE 
        c.CUST_ID = a.CUST_ID
)
select *
from 
    Cust_Accessory_DT