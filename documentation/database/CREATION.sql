DROP SCHEMA IF EXISTS PHARMINFORMATION;
CREATE SCHEMA PHARMINFORMATION;
USE PHARMINFORMATION;

-- Check If Any Tables Exists & Drop them

DROP TABLE IF EXISTS INSURANCE;
DROP TABLE IF EXISTS COVERS;
DROP TABLE IF EXISTS PURCHASES;
DROP TABLE IF EXISTS DRUG;
DROP TABLE IF EXISTS SHOT;
DROP TABLE IF EXISTS LIQUID;
DROP TABLE IF EXISTS TABLET;
DROP TABLE IF EXISTS OINTMENT;
DROP TABLE IF EXISTS PRESCRIBES;
DROP TABLE IF EXISTS DOCTOR;
DROP TABLE IF EXISTS CUSTOMER;
DROP TABLE IF EXISTS COMPANY;
DROP TABLE IF EXISTS EMPLOYEE;
DROP TABLE IF EXISTS VERIFIES;
DROP TABLE IF EXISTS BRANCH;
DROP TABLE IF EXISTS PHARMACIST;
DROP TABLE IF EXISTS CASHIER;
DROP TABLE IF EXISTS INTERN;
DROP TABLE IF EXISTS MANAGES;
DROP TABLE IF EXISTS SUPPLIES;
DROP TABLE IF EXISTS DEPENDENT;
DROP TABLE IF EXISTS MANUFACTURER;
DROP TABLE IF EXISTS BUYS;

-- Create Tables & Attributes

CREATE TABLE INSURANCE (
	INSURANCE_ID INT(5) NOT NULL,
    NAME VARCHAR(256) NOT NULL,
    COVER_TYPE VARCHAR(256),
    PHONE_NUMBER VARCHAR(10) NOT NULL,
    CONSTRAINT PK_INSURANCE PRIMARY KEY (INSURANCE_ID)
);

CREATE TABLE COVERS (
	COVERAGE_ID INT(5) NOT NULL,
	INSURANCE_ID INT(5) NOT NULL,
    DRUG_ID INT(7) NOT NULL,
    CONSTRAINT PK_COVERAGE PRIMARY KEY (COVERAGE_ID)
);

CREATE TABLE PURCHASES (
	PURCHASE_ID INT(5) NOT NULL ,
    INSURANCE_ID INT(5) NOT NULL,
    PATIENT_ID INT(5) NOT NULL,
    CONSTRAINT PK_PURCHASE PRIMARY KEY (PURCHASE_ID)
);

CREATE TABLE DRUG (
	DRUG_ID INT(7) NOT NULL,
    NAME VARCHAR(256),
    ISSUE_DATE DATE NOT NULL,
    EXP_DATE DATE NOT NULL,
    MFR_LIC INT NOT NULL, 
    CONSTRAINT PK_DRUG PRIMARY KEY (DRUG_ID)
);

CREATE TABLE SHOT (
	DRUG_ID INT(7) NOT NULL,
	TARGET_DISEASE VARCHAR(256) NOT NULL,
    CONSTRAINT PK_TARGET PRIMARY KEY (TARGET_DISEASE)
);

CREATE TABLE LIQUID (
	DRUG_ID INT(7) NOT NULL,
    VOLUME DECIMAL(4, 1) NOT NULL,
    CONSTRAINT PK_LIQ PRIMARY KEY (DRUG_ID, VOLUME)
);

CREATE TABLE TABLET (
	DRUG_ID INT(7) NOT NULL, 
    QUANTITY INT(3) NOT NULL, 
    CONSTRAINT PK_TAB PRIMARY KEY (DRUG_ID, QUANTITY)
);

CREATE TABLE OINTMENT (
	DRUG_ID INT(7) NOT NULL, 
    WEIGHT INT(3) NOT NULL,
    CONSTRAINT PK_OIT PRIMARY KEY (DRUG_ID, WEIGHT)
);

CREATE TABLE PRESCRIBES (
	PRESCRIPTION_ID INT(5) NOT NULL,
    DOCTOR_ID INT(5) NOT NULL, 
    PATIENT_ID INT(5) NOT NULL, 
    CONSTRAINT PK_PRESC PRIMARY KEY (PRESCRIPTION_ID)
);

CREATE TABLE DOCTOR (
	DOCTOR_ID INT(5) NOT NULL,
    FNAME VARCHAR(256) NOT NULL, 
    MNAME VARCHAR(256),
    LNAME VARCHAR(256),
    PHONE_NUMBER VARCHAR(20) NOT NULL,
    CONSTRAINT PK_DOC PRIMARY KEY (DOCTOR_ID)
);

CREATE TABLE CUSTOMER (
	PATIENT_ID INT(5) NOT NULL, 
    FNAME VARCHAR(256) NOT NULL,
    MNAME VARCHAR(256),
    LNAME VARCHAR(256) NOT NULL,
    SEX CHAR(1) NOT NULL, 
    BIRTH_DATE DATE NOT NULL, 
    PHONE_NUMBER VARCHAR(10),
    CONSTRAINT PK_CUS PRIMARY KEY (PATIENT_ID)
);

CREATE TABLE COMPANY (
	COMPANY_ID INT(5) NOT NULL, 
    NAME VARCHAR(256) NOT NULL, 
    LICENSE_NUM VARCHAR(10) NOT NULL, 
    CONSTRAINT PK_COM PRIMARY KEY (COMPANY_ID)
);

CREATE TABLE VERIFIES (
	VERIFICATION_ID INT(5) NOT NULL,
    DOCTOR_ID INT(5) NOT NULL, 
    COMPANY_ID INT(5) NOT NULL, 
    CONSTRAINT PK_VER PRIMARY KEY (VERIFICATION_ID)
);

CREATE TABLE EMPLOYEE (
	SSN VARCHAR(9) NOT NULL, 
    EMP_ID INT(5) NOT NULL, 
    FNAME VARCHAR(256) NOT NULL,
	MNAME VARCHAR(256),
    LNAME VARCHAR(256), 
    SEX CHAR(1) NOT NULL, 
    BIRTH_DATE DATE, 
    PAY_RATE DECIMAL(10, 2),
    PHONE_NUM VARCHAR(10),
    COMPANY_ID INT(5) NOT NULL, 
    CONSTRAINT PK_EMP PRIMARY KEY (SSN)
);

CREATE TABLE BRANCH (
	BRANCH_ID INT(5) NOT NULL, 
    NAME VARCHAR(256) NOT NULL, 
    PHONE_NUM VARCHAR(10),
    COMPANY_ID INT(5) NOT NULL, 
    EMP_SSN VARCHAR(9) NOT NULL, 
    CONSTRAINT PK_BRANCH PRIMARY KEY (BRANCH_ID)
);

CREATE TABLE PHARMACIST (
	ESSN VARCHAR(9) NOT NULL, 
    DEGREE_TYPE VARCHAR(256) NOT NULL,
    CONSTRAINT PK_PH PRIMARY KEY (ESSN, DEGREE_TYPE)
);

CREATE TABLE CASHIER (
	ESSN VARCHAR(9) NOT NULL, 
    DEGREE_TYPE VARCHAR(256) NOT NULL,
    CONSTRAINT PK_CA PRIMARY KEY (ESSN)
);

CREATE TABLE INTERN (
	ESSN VARCHAR(9) NOT NULL, 
    DEGREE_TYPE VARCHAR(256) NOT NULL,
    CONSTRAINT PK_IN PRIMARY KEY (ESSN, DEGREE_TYPE)
);

CREATE TABLE MANAGES (
	ESSN VARCHAR(9) NOT NULL, 
    BRANCH_ID INT(5) NOT NULL, 
    START_DATE DATE NOT NULL, 
    CONSTRAINT PK_MN PRIMARY KEY (ESSN, BRANCH_ID)
);

CREATE TABLE SUPPLIES (
	ORDER_ID INT(5) NOT NULL, 
    BRANCH_ID INT(5) NOT NULL, 
    MFR_LIC INT(5) NOT NULL, 
    CONSTRAINT PK_SUPP PRIMARY KEY (ORDER_ID)
);

CREATE TABLE DEPENDENT (
	DEPENDENT_ID INT(9) NOT NULL, 
    FNAME VARCHAR(256) NOT NULL, 
    MNAME VARCHAR(256),
    LNAME VARCHAR(256) NOT NULL, 
    ESSN VARCHAR(9) NOT NULL, 
    BIRTH_DATE DATE, 
    SEX CHAR(1),
    CONSTRAINT PK_DEP PRIMARY KEY (DEPENDENT_ID)
);

CREATE TABLE MANUFACTURER (
	LICENSE_NUMBER INT(5) NOT NULL,
    NAME VARCHAR(256) NOT NULL, 
    CITY VARCHAR(256), 
    STATE CHAR(2),
    CONSTRAINT PK_MAN PRIMARY KEY (LICENSE_NUMBER)
);

CREATE TABLE BUYS (
	RECEIPT_ID INT(5) NOT NULL, 
    BRANCH_ID INT(5) NOT NULL, 
    CUST_ID INT(5) NOT NULL, 
    CONSTRAINT PK_BU PRIMARY KEY (RECEIPT_ID)
);

-- ALTER TABLE & CONSTRAINTS COMMANDS --

ALTER TABLE COVERS
	ADD CONSTRAINT FOREIGN KEY (INSURANCE_ID) REFERENCES INSURANCE(INSURANCE_ID)
    ON UPDATE CASCADE;
    
ALTER TABLE DRUG
	ADD CONSTRAINT FOREIGN KEY (MFR_LIC) REFERENCES MANUFACTURER(LICENSE_NUMBER)
    ON UPDATE CASCADE;
    
ALTER TABLE PURCHASES
	ADD CONSTRAINT FOREIGN KEY(INSURANCE_ID) REFERENCES INSURANCE(INSURANCE_ID),
    ADD CONSTRAINT FOREIGN KEY(PATIENT_ID) REFERENCES CUSTOMER(PATIENT_ID)
    ON UPDATE CASCADE;
    
ALTER TABLE SHOT
	ADD CONSTRAINT FOREIGN KEY(DRUG_ID) REFERENCES DRUG(DRUG_ID)
    ON UPDATE CASCADE;
    
ALTER TABLE LIQUID
	ADD CONSTRAINT FOREIGN KEY(DRUG_ID) REFERENCES DRUG(DRUG_ID)
    ON UPDATE CASCADE;
    
ALTER TABLE TABLET
	ADD CONSTRAINT FOREIGN KEY(DRUG_ID) REFERENCES DRUG(DRUG_ID)
    ON UPDATE CASCADE;
    
ALTER TABLE OINTMENT
	ADD CONSTRAINT FOREIGN KEY(DRUG_ID) REFERENCES DRUG(DRUG_ID)
    ON UPDATE CASCADE;
    
ALTER TABLE PRESCRIBES
	ADD CONSTRAINT FOREIGN KEY(PATIENT_ID) REFERENCES CUSTOMER(PATIENT_ID),
    ADD CONSTRAINT FOREIGN KEY(DOCTOR_ID) REFERENCES DOCTOR(DOCTOR_ID)
    ON UPDATE CASCADE;
    
ALTER TABLE BUYS
	ADD CONSTRAINT FOREIGN KEY(BRANCH_ID) REFERENCES BRANCH(BRANCH_ID),
    ADD CONSTRAINT FOREIGN KEY(CUST_ID) REFERENCES CUSTOMER(PATIENT_ID)
    ON UPDATE CASCADE;
    
ALTER TABLE EMPLOYEE
	ADD CONSTRAINT FOREIGN KEY(COMPANY_ID) REFERENCES COMPANY(COMPANY_ID)
    ON UPDATE CASCADE;

ALTER TABLE VERIFIES
	ADD CONSTRAINT FOREIGN KEY(COMPANY_ID) REFERENCES COMPANY(COMPANY_ID),
    ADD CONSTRAINT FOREIGN KEY(DOCTOR_ID) REFERENCES DOCTOR(DOCTOR_ID)
    ON UPDATE CASCADE;
    
ALTER TABLE BRANCH
	ADD CONSTRAINT FOREIGN KEY(EMP_SSN) REFERENCES PHARMACIST(ESSN)
    ON UPDATE CASCADE;

ALTER TABLE PHARMACIST
	ADD CONSTRAINT FOREIGN KEY(ESSN) REFERENCES EMPLOYEE(SSN)
    ON UPDATE CASCADE;
    
ALTER TABLE CASHIER
	ADD CONSTRAINT FOREIGN KEY(ESSN) REFERENCES EMPLOYEE(SSN)
    ON UPDATE CASCADE;
    
ALTER TABLE INTERN
	ADD CONSTRAINT FOREIGN KEY(ESSN) REFERENCES EMPLOYEE(SSN)
    ON UPDATE CASCADE;
    
ALTER TABLE MANAGES 
	ADD CONSTRAINT FOREIGN KEY(BRANCH_ID) REFERENCES BRANCH(BRANCH_ID),
    ADD CONSTRAINT FOREIGN KEY(ESSN) REFERENCES PHARMACIST(ESSN)
    ON UPDATE CASCADE;
    
ALTER TABLE SUPPLIES
	ADD CONSTRAINT FOREIGN KEY(BRANCH_ID) REFERENCES BRANCH(BRANCH_ID),
    ADD CONSTRAINT FOREIGN KEY(MFR_LIC) REFERENCES MANUFACTURER(LICENSE_NUMBER)
    ON UPDATE CASCADE;
    
ALTER TABLE DEPENDENT
	ADD CONSTRAINT FOREIGN KEY(ESSN) REFERENCES EMPLOYEE(SSN)
    ON UPDATE CASCADE;
    
    -- End Of The File



