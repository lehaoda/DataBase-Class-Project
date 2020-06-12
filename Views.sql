
/*1. Top Gold Customer- This view returns the First Name, Last Name and Date
 of membership enrollment of those gold customers who have transactions 
 more than 12 times in the past year.*/
CREATE VIEW Top_Gold_Customer (First_Name, Last_Name, Date_of_Enrollment) AS
SELECT P.first_name, P.last_name, G.enrolled_date
FROM gold_customer G, person P, silver_customer S, bill_transaction B
WHERE S.membership_id=G.membership_id AND P.id=S.person_id AND P.id=B.person_id 
	AND B.date_of_purchase >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY P.first_name, P.last_name, G.enrolled_date
HAVING Count(B.transaction_id)>12;


/*2. Popular Product- This view returns the details of the product that customers
have purchased the most in the past 2 years.*/
CREATE VIEW Popular_Product (Product_ID, Product_Description, Is_Perishable, Supplier, Total_Purchase_Times) AS
SELECT P.product_id, P.description, P.is_perishable, P.supplier_id, SUM(PD.product_quantity)+SUM(OD.product_quantity) AS total
FROM products P, purchase_detail PD, online_order_detail OD, bill_transaction BT, online_order OO
WHERE PD.product_id=P.product_id AND OD.product_id=P.product_id AND BT.transaction_id=PD.transaction_id AND OO.order_number=OD.order_number
	AND BT.date_of_purchase >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR) AND OO.date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR)
GROUP BY P.product_id 
ORDER BY total DESC LIMIT 1;


/*3. Top Store- This view returns the details of the store that has maximum 
number of purchases in the last year.*/
CREATE VIEW Top_Store (Store_ID, Name, Address, Contact, Purchase_Times) AS
SELECT S.store_id, S.name, S.address, S.Contact, COUNT(B.transaction_id) AS times
FROM Store S, bill_transaction B
WHERE S.store_id=B.store_id AND B.date_of_purchase >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY S.store_id 
ORDER BY times DESC LIMIT 1;


/*4. Potential Gold Customers- This view returns the name, phone number and ID 
of the Silver Customers who bought more than 10 vouchers in the last month.*/
CREATE VIEW Potential_Gold_Customer (Name, Phone_Number, ID) AS
SELECT P.first_name+P.last_name, PN.phone_number, S.person_id
FROM silver_customer S, person P, phone_number PN, voucher_bought_record VB
WHERE P.id=S.person_id AND P.id=PN.person_id AND S.person_id=VB.person_id AND VB.bought_date >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY P.first_name, P.last_name, S.person_id, PN.phone_number
HAVING COUNT(*)>10;


/*5. Top Supplier - This view returns the details of the supplier who has made the
most number of supplies of perishable items in the past month.*/
CREATE VIEW Top_Supplier (Supplier_ID, Supplier_Name) AS
SELECT S.supplier_id, S.supplier_name
FROM supplier S, products P, supply_history SH
WHERE SH.product_id=P.product_id AND P.supplier_id=S.supplier_id AND P.is_perishable=1 AND SH.supply_date >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY S.supplier_id, S.supplier_name
ORDER BY SUM(SH.supply_quantity) DESC LIMIT 1









