/*create database（name：grocery_store) and tables in MySQL*/
create database grocery_store1;

create table supplier(
	supplier_id int auto_increment,
	supplier_name varchar(100),
	primary key (supplier_id)
);

create table products(
	product_id int auto_increment,
	description varchar(255),
	quantity int not null,
	is_perishable boolean not null,
	date_of_expire date,
	supplier_id int,
	primary key (product_id),
	foreign key (supplier_id) references supplier (supplier_id)
);

create table supply_history(
	product_id int,
	record_id int,
	supply_date date,
	supply_quantity int,
	primary key (product_id, record_id),
	foreign key (product_id) references products (product_id)
);

create table person(
	id int auto_increment,
	first_name varchar(30) not null,
	middle_name varchar(30),
	last_name varchar(30) not null,
	address varchar(255),
	gender varchar(30),
	date_of_birth date,
	primary key(id)
);

create table phone_number(
	person_id int,
	phone_number varchar(30),
	primary key (person_id, phone_number),
	foreign key(person_id) references person(id)
);

create table gold_customer(
	membership_id int auto_increment,
	enrolled_date date,
	primary key(membership_id)
);

create table membership_card(
	membership_id int,
	card_number int not null,
	date_of_issue date not null,
	primary key (membership_id),
	foreign key(membership_id) references gold_customer(membership_id)
);

create table aisle(
	section varchar(10),
	aisle_number int,
	primary key(section, aisle_number)
);


create table employee(
	person_id int,
	employee_type varchar(40),
	employment_date date,
	cashier_designation_date date,
	manager_designation_date date,
	membership_id int,
	primary key(person_id),
	foreign key(person_id) references person(id),
	foreign key(membership_id) references gold_customer(membership_id)
);

create table product_aisle_assignment(
	person_id int,
	aisle_section varchar(10),
	aisle_number int,
	product_id int,
	date_of_assignment date,
	primary key (person_id, aisle_section, aisle_number, product_id),
	foreign key(person_id) references employee(person_id),
	foreign key(product_id) references products(product_id),
	foreign key(aisle_section, aisle_number) references aisle(section, aisle_number)
);

create table silver_customer(
	person_id int,
	non_online_customer_flag boolean not null,
	online_customer_flag boolean not null,
	email_address varchar(255),
	start_date date,
	membership_id int,
	primary key (person_id),
	foreign key(membership_id) references gold_customer(membership_id),
	foreign key (person_id) references person (id)
);


create table online_order(
	order_number int auto_increment,
	person_id int not null,
	date datetime not null,
	total_amount int not null,
	primary key(order_number),
	foreign key(person_id) references silver_customer(person_id)
);

create table online_order_detail(
	order_number int,
	product_id int,
	product_quantity int not null,
	unit_price float(100,2) not null,
	amount int,
	primary key (order_number, product_id),
	foreign key (product_id) references products (product_id),
	foreign key (order_number) references online_order (order_number)
);


create table store(
	store_id int auto_increment,
	name varchar(40) not null,
	address varchar(255),
	contact varchar(255),
	primary key(store_id)
);

create table shift_duty(
	record_id int auto_increment,
	store_id int,
	person_id int,
	date date ,
	working_hour float(10,1),
	primary key(record_id),
	foreign key(store_id) references store(store_id),
	foreign key(person_id) references employee(person_id)
);

create table sale(
	store_id int,
	sale_id int,
	description varchar(255),
	duration date,
	primary key(store_id, sale_id),
	foreign key(store_id) references store(store_id)
);

create table voucher(
	voucher_id int auto_increment,
	issued_date date,
	store_id int ,
	primary key(voucher_id),
	foreign key (store_id) references store (store_id)
);


create table promotional_discount(
	voucher_id int ,
	promotional_id int,
	promotion_description varchar(255),
	primary key(voucher_id, promotional_id),
	foreign key(voucher_id) references voucher(voucher_id)
);

create table voucher_bought_record(
	voucher_id int,
	record_id int,
	is_free int not null,
	person_id int ,
	membership_id int,
	bought_date date,
	primary key(voucher_id, record_id),
	foreign key (voucher_id) references voucher(voucher_id),
	foreign key(person_id) references silver_customer(person_id),
	foreign key(membership_id) references gold_customer(membership_id)
);


create table bill_transaction(
	transaction_id int auto_increment,
	date_of_purchase date not null,
	bill_amount float(20,2),
	store_id int not null,
	payment_method varchar(40),
	person_id int ,
	employee_person_id int ,
	primary key(transaction_id),
	foreign key(store_id) references store(store_id),
	foreign key(person_id) references person(id),
	foreign key(employee_person_id) references employee(person_id) 
);

create table purchase_detail(
	transaction_id int,
	product_id int,
	product_quantity int not null,
	unit_price float(20,2) not null,
	amount int,
	primary key (transaction_id, product_id),
	foreign key(transaction_id) references bill_transaction(transaction_id),
	foreign key(product_id) references products(product_id)
);
