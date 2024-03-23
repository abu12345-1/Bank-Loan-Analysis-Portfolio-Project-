Select * from bank_loan_data

--Total Loan Applications
SELECT COUNT(id) AS Total_Applications FROM bank_loan_data

--MTD Loan Applications
SELECT COUNT(id) AS Total_Applications FROM bank_loan_data
WHERE MONTH(issue_date) = 12
 
--PMTD Loan Applications
SELECT COUNT(id) AS Total_Applications FROM bank_loan_data
WHERE MONTH(issue_date) = 11

--Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data

--MTD Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data
WHERE MONTH(issue_date) = 12

--PMTD Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data
WHERE MONTH(issue_date) = 11
 

--Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected FROM bank_loan_data
 
--MTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected FROM bank_loan_data
WHERE MONTH(issue_date) = 12
 
--PMTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected FROM bank_loan_data
WHERE MONTH(issue_date) = 11
 

--Average Interest Rate
SELECT AVG(int_rate)*100 AS Avg_Int_Rate FROM bank_loan_data
 
--MTD Average Interest
SELECT AVG(int_rate)*100 AS MTD_Avg_Int_Rate FROM bank_loan_data
WHERE MONTH(issue_date) = 12


--PMTD Average Interest
SELECT AVG(int_rate)*100 AS PMTD_Avg_Int_Rate FROM bank_loan_data
WHERE MONTH(issue_date) = 11


--Avg DTI
SELECT AVG(dti)*100 AS Avg_DTI FROM bank_loan_data
 
--MTD Avg DTI
SELECT AVG(dti)*100 AS MTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 12
 
--PMTD Avg DTI
SELECT AVG(dti)*100 AS PMTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 11


--Good Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100) / 
	COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data


--Good Loan Applications
Select Count(id) As Good_loan_applications
From bank_loan_data 
Where loan_status='Fully Paid' OR  loan_status='Current';

--Good Loan Funded amount
Select Sum(loan_amount) As Good_loan_applications
From bank_loan_data 
Where loan_status='Fully Paid' OR  loan_status='Current';


--Good Loan Amount Received
SELECT SUM(total_payment) AS Good_Loan_amount_received FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'


--Bad Loan Applications Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' OR loan_status = 'Current' THEN id END) * 100) / 
	COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data

--Bad Loan Applications
Select Count(id) As Good_loan_applications
From bank_loan_data 
Where loan_status='Charged Off';


--Bad Loan Funded amount
Select Sum(loan_amount) As Good_loan_applications
From bank_loan_data 
Where loan_status='Charged Off';


--Bad Loan amount received
SELECT SUM(total_payment) AS Good_Loan_amount_received FROM bank_loan_data
Where loan_status='Charged Off';


--Loan Status
Select
loan_status,
Count(id) as LoanCount,
Sum(total_payment) as Total_Amount_Received,
Sum(loan_amount) as Total_Funded_Amount,
Avg(int_rate*100) as Avg_interest_Rate,
Avg(dti*100) as AVG_DTI
From bank_loan_data
Group by loan_status

SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status


--BANK LOAN REPORT | OVERVIEW
--MONTH
Select
Month(issue_date) as Month_number,
DateName(month, issue_date) as Month_name,
Sum(loan_amount)as Total_Funded_Amount,
Sum(total_payment) as Total_Amount_Received
From bank_loan_data
Group by Month(issue_date),DATENAME(month, issue_date)
Order by Month(issue_date)


--STATE
Select
address_state as State,
Count(Id) as Total_loan_applications,
Sum(loan_amount)as Total_Funded_Amount,
Sum(total_payment) as Total_Amount_Received
From bank_loan_data
Group by address_state
Order by address_state


--Term
Select
term as Term,
Count(Id) as Total_loan_applications,
Sum(loan_amount)as Total_Funded_Amount,
Sum(total_payment) as Total_Amount_Received
From bank_loan_data
Group by term
Order by term


--Employee Length
Select
emp_length as Employee_length,
Count(Id) as Total_loan_applications,
Sum(loan_amount)as Total_Funded_Amount,
Sum(total_payment) as Total_Amount_Received
From bank_loan_data
Group by emp_length
Order by emp_length

--Purpose of Loan
Select
purpose as Purpose_of_Loan,
Count(Id) as Total_loan_applications,
Sum(loan_amount)as Total_Funded_Amount,
Sum(total_payment) as Total_Amount_Received
From bank_loan_data
Group by purpose
Order by purpose


--HOME OWNERSHIP
Select
home_ownership as Home_Ownership,
Count(Id) as Total_loan_applications,
Sum(loan_amount)as Total_Funded_Amount,
Sum(total_payment) as Total_Amount_Received
From bank_loan_data
Group by home_ownership
Order by home_ownership

SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose