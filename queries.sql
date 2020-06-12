
/*1. List the details of all the managers of the store in the past two months.*/
SELECT P.first_name, P.middle_name, P.last_name, P.address, P.gender, P.date_of_birth
FROM employee E, person P, shift_duty SD, store S
WHERE E.person_id=P.id AND SD.person_id=E.person_id AND S.store_id=SD.store_id AND E.employee_type='manager'
	AND SD.date >= DATE_SUB(CURDATE(), INTERVAL 2 MONTH)
GROUP BY P.first_name, P.middle_name, P.last_name, P.address, P.gender, P.date_of_birth;


/*2. List customers who have bought all perishable items available in the store.*/
SELECT P.first_name, P.middle_name, P.last_name
FROM person P
WHERE NOT EXISTS (
	SELECT PD.product_id
	FROM products PD
	WHERE PD.is_perishable=1
	NOT IN
	(
		SELECT PD.product_id
		FROM products PD, bill_transaction B, purchase_detail D
		WHERE P.id=B.person_id AND D.transaction_id=B.transaction_id AND D.product_id=PD.product_id
	)
);


/*3. Find the average number of purchases made by the top five Gold Customers.*/
SELECT AVG(nums) FROM
(
	SELECT COUNT(*) AS nums
	FROM gold_customer G, silver_customer S, person P, bill_transaction B
	WHERE G.membership_id=S.membership_id AND S.person_id=P.id AND B.person_id=P.id
	GROUP BY G.membership_id ORDER BY nums DESC LIMIT 5
) AS top_gold_customer;


/*4. Find the expiry date of the perishable item that is purchased the most.*/
SELECT Prod.exp FROM
(
	SELECT P.product_id, P.date_of_expire AS exp, SUM(PD.product_quantity) AS total
	FROM products P, purchase_detail PD 
	WHERE PD.product_id=P.product_id
	GROUP BY P.product_id ORDER BY total DESC LIMIT 1
) AS Prod;


/*5. Find the supplier details of products that are out of stock.*/
SELECT S.supplier_id, S.supplier_name
FROM supplier S, products P
WHERE P.supplier_id=S.supplier_id AND P.quantity=0;


/*6. Find the total number transactions made at each store.*/
SELECT S.store_id, S.name, COUNT(*) AS total_number_transaction
FROM store S, bill_transaction B
WHERE B.store_id=S.store_id
GROUP BY S.store_id, S.name;


/*7. Find the employee details who has worked every day of the past week.*/
SELECT E.person_id, E.employee_type, P.first_name, P.middle_name, P.last_name
FROM employee E, person P
WHERE P.id=E.person_id AND NOT EXISTS 
(
	
	SELECT CURDATE() AS day
		UNION SELECT CURDATE() - INTERVAL 1 DAY
		UNION SELECT CURDATE() - INTERVAL 2 DAY
		UNION SELECT CURDATE() - INTERVAL 3 DAY
		UNION SELECT CURDATE() - INTERVAL 4 DAY
		UNION SELECT CURDATE() - INTERVAL 5 DAY
		UNION SELECT CURDATE() - INTERVAL 6 DAY
   	
	NOT IN
	(
		SELECT S.date
		FROM shift_duty S
		WHERE S.date > DATE_SUB(CURDATE(), INTERVAL 7 DAY) AND P.id=S.person_id
	)
);


/*8. Find the count of customers who have bought the most popular product.*/
SELECT COUNT(*) FROM
(
	SELECT DISTINCT S.person_id
	FROM silver_customer S, person P, bill_transaction B, purchase_detail PD
	WHERE S.person_id=P.id AND P.id=B.person_id AND B.transaction_id=PD.transaction_id
		AND PD.product_id IN (SELECT Product_ID FROM Popular_Product)
	GROUP BY S.person_id
) AS Pers;


/*9. List all transaction details issued after the most current employee was hired.*/
SELECT B.transaction_id, B.date_of_purchase, B.bill_amount, B.store_id, B.payment_method
FROM bill_transaction B
INNER JOIN
(
	SELECT employment_date 
	FROM employee 
	ORDER BY employment_date DESC LIMIT 1
) AS Edate
WHERE B.date_of_purchase=Edate.employment_date;


/*10. List all the employees that have enrolled as Gold Customer within a month of being employed.*/
SELECT E.person_id
FROM employee E, gold_customer G
WHERE E.membership_id=G.membership_id AND G.enrolled_date <= DATE_ADD(E.employment_date, INTERVAL 1 MONTH) 
	AND G.enrolled_date >= E.employment_date;


/*11. Find the details of the voucher that are purchased the most.*/
SELECT V.voucher_id, V.issued_date, V.store_id
FROM voucher V
WHERE V.voucher_id IN 
(SELECT id FROM
	(
		SELECT VB.voucher_id AS id, COUNT(*) AS nums
		FROM voucher_bought_record VB
		GROUP BY VB.voucher_id ORDER BY nums DESC LIMIT 1
	) AS best_seller
);


/*12. Find customers who have been Silver Customer for over 5 years.*/
SELECT P.id, P.first_name, P.middle_name, P.last_name
FROM silver_customer S, person P
WHERE S.person_id=P.id AND S.start_date < DATE_SUB(CURDATE(), INTERVAL 5 YEAR);


/*13. Find the number of purchases made by the potential Gold Members in the last year.*/
SELECT COUNT(*) AS number_of_purchases, S.membership_id
FROM silver_customer S, person P, bill_transaction B
WHERE S.person_id=P.id AND B.person_id=P.id AND B.date_of_purchase > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
	AND S.membership_id IN (SELECT ID FROM Potential_Gold_Customer)
GROUP BY S.membership_id;


/*14. Find the maximum bill amount and details of the store that has the maximum 
number of purchases in the last year.*/
SELECT B.bill_amount, S.name, S.address, S.contact
FROM bill_transaction B, store S
INNER JOIN
(
	SELECT store_id
	FROM bill_transaction
	WHERE date_of_purchase > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
	ORDER BY bill_amount DESC LIMIT 1
) AS top_amount
WHERE B.store_id=S.store_id AND  B.store_id=top_amount.store_id;


/*15. Find the date of the transaction that has a bill amount greater than the average
bill amount of all transactions in the system.*/
SELECT B.date_of_purchase
FROM bill_transaction B
WHERE B.bill_amount > 
(
	SELECT AVG(bill_amount)
	FROM bill_transaction
)


















