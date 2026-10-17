USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;

USE DATABASE RAW;
USE SCHEMA RAW.PUBLIC;

CREATE OR REPLACE TABLE EXPENSE_CLAIMS
    (
        CLAIM_ID STRING,
        EMPLOYEE_ID STRING,
        CLAIM_DATE DATE,
        EXPENSE_TYPE STRING, -- TRAVEL, FOOD, ACCOMMODATION, ECT..
        CLAIMED_AMOUNT NUMBER,
        CURRENCY STRING,
        APPROVAL_STATUS STRING, -- PENDING, APPROVED, REJECTED
        APPROVER_ID STRING
    )
;

INSERT INTO expense_claims VALUES
('CLM001', 'E001', '2024-04-01', 'Travel', 12000, 'INR', 'Pending', 'MGR001'),
('CLM002', 'E002', '2024-04-02', 'Food', 800, 'INR', 'Approved', 'MGR002'),
('CLM003', 'E001', '2024-04-03', 'Accommodation', 5000, 'INR', 'Rejected', 'MGR001'),
('CLM004', 'E003', '2024-04-04', 'Travel', 9500, 'INR', 'Pending', 'MGR003'),
('CLM005', 'E001', '2024-04-01', 'Travel', 12000, 'INR', 'Pending', 'MGR001'); -- Duplicate claim

update expense_claims
set
claim_id = null where claim_id = 'CLM001';

update expense_claims
set CLAIMED_AMOUNT = -10000
where claim_id = 'CLM004'
;
