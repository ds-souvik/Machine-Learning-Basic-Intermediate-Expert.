-- -----------------------------------------------------------------------------------------------------------------
-- Session: Joins and Set Operations
-- Inner Join
use market_star_schema;

-- 1. Print the product categories and subcategories along with the profits made for each order.
select Ord_id, Product_Category, Product_Sub_Category, Profit 
from prod_dimen p inner join market_fact_full m 
on p.Prod_id=m.Prod_id; 


-- 2. Find the shipment date, mode and profit made for every single order.
select Ship_Date, Ship_Mode, Profit 
from shipping_dimen s inner join market_fact_full m
on s.Ship_id=m.Ship_id;

-- 3. Print the shipment mode, profit made and product category for each product.
select s.Ship_Mode, m.Profit, p.Product_Category 
from shipping_dimen s inner join market_fact_full m
on s.Ship_id=m.Ship_id inner join prod_dimen p 
on p.Prod_id=m.Prod_id;

-- 4. Which customer ordered the most number of products?
select Cust_id from market_fact_full m
group by Cust_id order by count(Prod_id) desc
limit 1;

-- 5. Selling office supplies was more profitable in Delhi as compared to Patna. True or false?
select sum(m.Profit), c.City from 
cust_dimen c inner join market_fact_full m on
c.Cust_id=m.Cust_id  inner join
prod_dimen p on p.Prod_id=m.Prod_id where p.Product_Category='Office Supplies' and 
City in ('Delhi', 'Patna')
group by c.City;

-- 6. Print the name of the customer with the maximum number of orders.
select c.Cust_id, c.Customer_Name, c.City, c.State, c.Customer_Segment,
count(c.Cust_id)
from cust_dimen c inner join
market_fact_full m on
c.Cust_id=m.Cust_id group by m.Cust_id order by count(m.Cust_id) desc
limit 1;

select Customer_Name, count(Customer_Name) as No_Of_Orders
from cust_dimen c
inner join market_fact_full m
on c.cust_id = m.cust_id
group by Customer_Name
order by No_Of_Orders desc
limit 1;

select Customer_Name, sum(Order_Quantity) as No_Of_Orders
from cust_dimen c
inner join market_fact_full m
on c.cust_id = m.cust_id
group by Customer_Name
order by No_Of_Orders desc
limit 1;
-- 7. Print the three most common products.
select Product_Category, Product_Sub_Category 
from prod_dimen p
inner join market_fact_full m on
p.Prod_id=m.Prod_id
group by Product_Sub_Category
order by (Order_Quantity) desc
limit 1;


-- -----------------------------------------------------------------------------------------------------------------
-- Outer Join

-- 1. Return the order ids which are present in the market facts table.
select Ord_id from market_fact_full;
-- Execute the below queries before solving the next question.

create table manu (
	Manu_Id int primary key,
	Manu_Name varchar(30),
	Manu_City varchar(30)
);

insert into manu values
(1, 'Navneet', 'Ahemdabad'),
(2, 'Wipro', 'Hyderabad'),
(3, 'Furlanco', 'Mumbai');

alter table Prod_Dimen
add column Manu_Id int;

update Prod_Dimen
set Manu_Id = 2
where Product_Category = 'technology';

-- 2. Display the products sold by all the manufacturers using both inner and outer joins.

select Product_Category, Product_Sub_Category, m.Manu_Id from
prod_dimen p inner join manu m on
p.Manu_Id=m.Manu_Id; 

select Product_Category, Product_Sub_Category, m.Manu_Id, Manu_Name from
prod_dimen p left join manu m on
p.Manu_Id=m.Manu_Id;

select distinct Manu_Id from prod_dimen;


-- 3. Display the number of products sold by each manufacturer.
select Manu_Name, count(p.prod_Id) from manu m left join
prod_dimen p on m.Manu_Id=p.Manu_Id group by m.Manu_Id
;

select * from manu;

select * from prod_dimen;

-- 4. Create a view to display the customer names, segments, sales, product categories and
-- subcategories of all orders. Use it to print the names and segments of those customers who ordered more than 20
-- pens and art supplies products.


-- -----------------------------------------------------------------------------------------------------------------
-- Union, Union all, Intersect and Minus

-- 1. Combine the order numbers for orders and order ids for all shipments in a single column.

-- 2. Return non-duplicate order numbers from the orders and shipping tables in a single column.

-- 3. Find the shipment details of products with no information on the product base margin.

-- 4. What are the two most and the two least profitable products?
(select Prod_id, sum(Profit) as Total_Profit 
from market_fact_full
group by Prod_id
order by Profit desc
limit 2)
union
(select Prod_id, sum(Profit) as Total_Profit
from market_fact_full
group by Prod_id
order by Total_Profit
limit 2);

