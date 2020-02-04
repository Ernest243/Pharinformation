USE PHARMINFORMATION;

-- List the Drug ID's and expiration dates that have been issued after the date xxxx-xx-xx
SELECT DRUG_ID, EXP_DATE
FROM DRUG
WHERE ISSUE_DATE > '2011-12-10'; -- OK

-- List employees and their id's, first, middle, and last names along with genders that are pharmacists and manage branches that are part of a specific company name ‘xxxxxxxxxxxxx’
SELECT EMP_ID, FNAME, MNAME, LNAME, SEX
FROM EMPLOYEE AS E, COMPANY AS CM, MANAGES AS MN, BRANCH AS BR
WHERE CM.NAME = 'Publix Pharmacies' AND CM.COMPANY_ID = BR.COMPANY_ID AND E.SSN = MN.ESSN
		 AND MN.BRANCH_ID = BR.BRANCH_ID; -- OK
         
-- Get the name of manufacturer that supplied drugs to a branch under order Id xxxxx
USE PHARMINFORMATION;
SELECT M.NAME
FROM MANUFACTURER AS M, SUPPLIES AS S, BRANCH AS B
WHERE S.ORDER_ID = '45363' AND S.BRANCH_ID = B.BRANCH_ID AND S.MFR_LIC = M.LICENSE_NUMBER; -- OK

-- List customer ID's and the respective drugs purchased
USE PHARMINFORMATION;
SELECT D.NAME, C.PATIENT_ID
FROM DRUG AS D, CUSTOMER AS C, BUYS AS B, BRANCH AS BR
WHERE B.CUST_ID = C.PATIENT_ID AND BR.BRANCH_ID = B.BRANCH_ID; -- OK

-- Delete all of the dependents that are age 21 or older due to insurance policy for minor coverage.
DELETE FROM DEPENDENT 
WHERE BIRTH_DATE < '1998-01-01'; -- OK

-- List name, sex and birth date of customers who bought drugs with insurance policies
USE PHARMINFORMATION;
SELECT DISTINCT(CUST.FNAME), CUST.LNAME, CUST.SEX, CUST.BIRTH_DATE
FROM CUSTOMER AS CUST, COVERS JOIN PURCHASES AS PCVR
WHERE CUST.PATIENT_ID = PCVR.PATIENT_ID; -- OK

-- Delete all the drugs that have an issue date older than 3 years
DELETE FROM DRUG
WHERE CURDATE() - ISSUE_DATE > 3; -- OK

