{{
    config(
        materialized='dynamic_table',
        snowflake_warehouse='COMPUTE_WH',
        database='SNOWFLAKE_DT',
        schema='TRANSFORM_DT',
        target_lag= 'DOWNSTREAM'
    )
}}

WITH ACCESSORY_DT AS
(
    SELECT 
        T1.CUST_ID,
        T1.ACC_ID,
        T1.ACC_CATEGORY,
        T1.ACC_STATUS,
        T2.PRICE
    FROM 
        SNOWFLAKE_DT.PUBLIC.ACCESSORY_ITEM AS T1,
        (
            SELECT 
                CUST_ID,
                ACC_ID,
                MAX(ACC_PRICE) AS PRICE
            FROM SNOWFLAKE_DT.PUBLIC.ACCESSORY_ITEM
            GROUP BY CUST_ID,ACC_ID
        ) T2 
    WHERE 
        T1.CUST_ID = T2.CUST_ID
    AND T1.ACC_ID = T2.ACC_ID
    AND T1.ACC_PRICE = T2.PRICE
)
SELECT *
FROM 
    ACCESSORY_DT