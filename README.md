# DataBase-Class-Project

Database Design Term Project
---------------------------------------------------------------

Project Description
---------------------------------------------------------------
Food Festive Supermarket, a grocery store in Richardson, would like one relational database to store the information about their management system to be able to carry out their work in an organized way. They have some major modules such as Person, Products and Billing.

A Person must be an Employee or a Silver Customer. Details of a person such as ID, Name (First, Middle, Last), Address, Gender, Date of Birth (Must be 16 years or older), and Phone number (one person can have more than one phone number) are recorded. The Person ID should have the format “PXXX” where X is a number from 0 to 9.

A Silver Customer is classified as online or non-online customer. An online customer can also be a non-online customer. The email address of the online customer is stored. Only online customers can order products online. The order details such as order number, date, amount, product details and customer details are stored. One online customer can order multiple products and a product can be ordered by multiple online customers.

Employee is classified as Cashier, Floor Staff or Managers. A floor staff can be promoted to cashier and later become a manager. The start date for each designation is recorded. Each floor staff is assigned the duty of arranging products into aisles. Aisle information such as section and aisle number is recorded. The date of assignment along with aisle number is stored for each employee. One employee maybe be assigned to arrange different aisles. The information about product-aisle arrangement and the date of arrangement is also stored. Products do not have a fixed aisle and can be arranged in different aisles throughout the year.

Each employee works at a store. One employee can work in multiple stores but on a given day, can work only at one store. The date and working hours of the employee are stored. Store information such as name, address and contact are stored. Each store offers ‘Sale’ from time to time. Details such as sale ID, description and duration is recorded. The sale IDs are not unique and cannot be used to identify a sale in the system.

A bill transaction is made by a cashier who records the list of products that are purchased by a person along with the date of purchase, bill amount, store ID and payment method. The cashier details, person details, store details and product details are stored together.

A Gold Customer is someone who has some extra privileges than a Silver Customer. A Gold customer can be an Employee or a Non-online Customer or both. Different vouchers are issued by the store. A non-online customer needs to buy these vouchers but vouchers are given to a Gold Customers each month free of cost. Sometimes promotional discounts are offered on the vouchers and details such promotion ID and promotion description are recorded. The Promotional IDs are not unique and cannot be used to identify a promotion in the system. Each Gold Customer is issued a membership card. A unique membership ID is generated for each Gold Customer. This number, date of issue and other information are stored.
Product details such as product ID, Quantity (0,if out of stock), description and other information are stored. Products are further classified as either perishable or non-perishable items. Date of expiry is stored for the perishable items. Various suppliers, whose information are also stored in the system supply products. One Supplier may supply more than one product. But one product is supplied by only one supplier.

Project Questions
---------------------------------------------------------------
1. Is the ability to model superclass/subclass relationships likely to be important in a grocery system environment such as Food Festive? Why or why not?
2. Can you think of 5 more business rules (other than the one explicitly described above) that are likely to be used in a supermarket environment? Add your rules to the above requirement to be implemented.
3. Justify using a Relational DBMS like Oracle for this project.

Project Exercises
---------------------------------------------------------------
Phase I. Draw an EER to accurately represent this set of requirements. This will be your Conceptual Design. Clearly specify any assumptions that you are making. You can use any tools (software) to draw the EER.

Phase II. It has been decided to use a relational DBMS to implement the database. Perform the following steps.
a. Convert your Conceptual model (Phase I) to a Logical model that can be implemented in a relational DBMS like Oracle. During this process you replace M-N relationships and multi- valued attributes with constructs that can be implemented in the relational DBMS. Draw EER for the logical model after your modifications. Feel free to change your conceptual model (first delivery) if needed.
b. Convert the EER (item a) to a database design. Document your design in Database Schema format like the one we discussed in the class.

Phase III. Now, you are ready for implementation. Use appropriate naming conventions for all of your tables and attributes.
a. Normalize all of your tables to third normal form. Make any necessary changes to the EER from Phase II b. Explain why these changes needed to be made.
b. Draw a dependency diagram for each table from Phase III a.
c. Write SQL statements to create database, tables and all other structures. Primary key
and foreign keys must be defined as appropriate.
d. Update data dictionary from previous delivery (phase III c.) to add data type for each
attribute in addition to specifying if it is primary key, foreign key, NULL is
permitted, or its value is UNIQUE.
e. Use the Create View statement to create the following views:
  1. Top Gold Customer- This view returns the First Name, Last Name and Date of membership enrollment of those gold customers who have transactions more than 12 times in the past year.
  2. Popular Product- This view returns the details of the product that customers have purchased the most in the past 2 years.
  3. Top Store- This view returns the details of the store that has maximum number of purchases in the last year.
  4. Potential Gold Customers- This view returns the name, phone number and ID of the Silver Customers who bought more than 10 vouchers in the last month.
  5. Top Supplier - This view returns the details of the supplier who has made the
most number of supplies of perishable items in the past month.

f. Answer the following Queries. Feel free to use any of the views that you created in
part (e.):
  1. List the details of all the managers of the store in the past two months.
  2. List customers who have bought all perishable items available in the store.
  3. Find the average number of purchases made by the top five Gold Customers.
  4. Find the expiry date of the perishable item that is purchased the most.
  5. Find the supplier details of products that are out of stock.
  6. Find the total number transactions made at each store.
  7. Find the employee details who has worked every day of the past week.
  8. Find the count of customers who have bought the most popular product.
  9. List all transaction details issued after the most current employee was hired.
  10. List all the employees that have enrolled as Gold Customer within a month of
being employed.
  11. Find the details of the voucher that are purchased the most.
  12. Find customers who have been Silver Customer for over 5 years.
  13. Find the number of purchases made by the potential Gold Members in the last
year.
  14. Find the maximum bill amount and details of the store that has the maximum
number of purchases in the last year.
  15. Find the date of the transaction that has a bill amount greater than the average
bill amount of all transactions in the system.

Phase IV. Document the final term project report.
a. Problem description (Copy it from Web site).
b. Project questions (Answer 3 questions listed in the project, justify your solution).
c. EER diagram with all assumptions (Solution for Phase II a).
d. Relational Schema after normalization. All relations must be in 3NF. The relational
schema should include Primary key as well as foreign keys (if any) for all relations.
(Solution for Phase III a).
e. All requested SQL statements (Solution for Phase III-c, e and f).
f. Dependency diagram (Solution for Phase III-b).
