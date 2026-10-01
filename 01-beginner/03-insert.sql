SET search_path TO beginner;

INSERT INTO customers (first_name,last_name,email,date_of_birth,city) VALUES
('Ravi','Kumar','ravi@example.com','1995-05-10','Visakhapatnam'),
('Anita','Rao','anita@example.com','1992-08-21','Hyderabad'),
('Kiran','Sharma','kiran@example.com','1998-01-15','Vijayawada'),
('Priya','Reddy','priya@example.com','1990-12-05','Visakhapatnam'),
('Arjun','Naidu','arjun@example.com','1988-03-30','Hyderabad');

INSERT INTO accounts (customer_id,account_number,account_type,balance)
SELECT customer_id,'ACC' || LPAD(customer_id::text,6,'0'),
       CASE WHEN customer_id % 2 = 0 THEN 'CURRENT' ELSE 'SAVINGS' END,
       customer_id * 10000
FROM customers;
