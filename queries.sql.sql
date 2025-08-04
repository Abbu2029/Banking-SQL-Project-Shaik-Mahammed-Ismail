# BankingDB: Queries & Analytics

UPDATE Accounts SET balance = balance + 1000 WHERE account_id = 151;
INSERT INTO Transactions (account_id, transaction_type, amount, transaction_date)
VALUES (151, 'Deposit', 1000.00, CURDATE());


UPDATE Accounts SET balance = balance - 500 WHERE account_id = 152;
INSERT INTO Transactions (account_id, transaction_type, amount, transaction_date)
VALUES (152, 'Withdrawal', 500.00, CURDATE());

START TRANSACTION;
UPDATE Accounts SET balance = balance - 1000 WHERE account_id = 151;
UPDATE Accounts SET balance = balance + 1000 WHERE account_id = 152;
INSERT INTO Transactions (account_id, transaction_type, amount, transaction_date)
VALUES (151, 'Transfer', 1000.00, CURDATE());
INSERT INTO Transactions (account_id, transaction_type, amount, transaction_date)
VALUES (152, 'Transfer', 1000.00, CURDATE());
COMMIT;



SELECT 
    c.name,
    l.loan_amount,
    l.interest_rate,
    ROUND(l.loan_amount * l.interest_rate / 100, 2) AS annual_interest
FROM Loans l
JOIN Customers c ON l.customer_id = c.customer_id;

# Top 5 Customers by Balance
SELECT 
    c.name AS customer,
    a.account_type,
    a.balance,
    b.branch_name
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
JOIN Branches b ON a.branch_id = b.branch_id
ORDER BY a.balance DESC
LIMIT 5;

# Monthly Transactions
SELECT 
    YEAR(transaction_date) AS year,
    MONTH(transaction_date) AS month,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount
FROM Transactions
GROUP BY YEAR(transaction_date), MONTH(transaction_date)
ORDER BY year, month;

# Branch Performance
SELECT 
    b.branch_name,
    COUNT(a.account_id) AS total_accounts,
    AVG(a.balance) AS avg_balance
FROM Branches b
LEFT JOIN Accounts a ON b.branch_id = a.branch_id
GROUP BY b.branch_id;




SELECT 
    c.name AS Customer_Name,
    a.account_type AS Account_Type,
    a.balance AS Balance,
    b.branch_name AS Branch
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
JOIN Branches b ON a.branch_id = b.branch_id
ORDER BY a.balance DESC
LIMIT 5;










SELECT 
    YEAR(transaction_date) AS Year,
    MONTH(transaction_date) AS Month,
    COUNT(*) AS Total_Transactions,
    SUM(amount) AS Total_Amount
FROM Transactions
GROUP BY YEAR(transaction_date), MONTH(transaction_date)
ORDER BY Year, Month;











SELECT 
    b.branch_name AS Branch_Name,
    COUNT(a.account_id) AS Total_Accounts,
    AVG(a.balance) AS Average_Balance
FROM Branches b
LEFT JOIN Accounts a ON b.branch_id = a.branch_id
GROUP BY b.branch_name;
