-- Print all the attributes and values of table cust_dimen.
select * from cust_dimen;

 -- Print all the customer names.
select Customer_Name from cust_dimen;

-- Print all the Customer_Name, City, State from cust_dimen.
select Customer_Name, City, State from cust_dimen;

-- Print the total number of customers.
select count(*) as 'total_customers'
from cust_dimen;

select count(*) as 'total customers from West Bengal'
from cust_dimen where State='West Bengal';

select Customer_name as 'customers from West Bengal'
from cust_dimen where State='West Bengal' and city='Kolkata';

select count(*) from cust_dimen where Customer_Segment='Corporate'
and  State='Maharashtra';

select * from cust_dimen where State in (' Karnataka', 'Telangana', 'Tamil Nadu',
'Kerela');

select * from cust_dimen where Customer_Segment != 'Small Business';

select * from market_fact_full;

select Ord_id, Profit from market_fact_full where Profit < 0;

select Ord_id from market_fact_full where Ord_id like '%_5%' and 
Shipping_Cost between 10 and 15;

select City from cust_dimen where City like 'K%';

select City from cust_dimen where City between 'kanyakumari' and 'Mumbai';

select count(*) from cust_dimen;

select count(Customer_Name) from cust_dimen;

select count(Customer_Name) as City_Wise_Customers, City from cust_dimen
group by City;

select count(Customer_Name) as City_Wise_Customers, City, State from cust_dimen
group by City, State;

select * from market_fact_full;

select min(Sales), Market_fact_id, Cust_id from market_fact_full
group by Cust_id;

select avg(Sales), Market_fact_id, Cust_id from market_fact_full
group by Cust_id;

select Market_fact_id, Ord_id, Prod_id, Cust_id, Profit  from market_fact_full
where Profit<0;

select count(*) as Count_Of_Custname_from_Bihar, State, Customer_Segment
from cust_dimen where State='Bihar' group by Customer_Segment;

select Customer_Name from cust_dimen
order by Customer_Name;

select distinct Customer_Name from cust_dimen
order by Customer_Name;

select distinct Customer_Name from cust_dimen
order by Customer_Name desc;

select distinct Customer_Name from cust_dimen
order by Customer_Segment, City desc;

select distinct Customer_Name from cust_dimen
order by City,Customer_Segment desc;

select sum(Order_Quantity), Prod_id from market_fact_full
group by Prod_id order by sum(Order_Quantity) desc
limit 3;

select sum(Order_Quantity), Prod_id from market_fact_full
group by Prod_id order by sum(Order_Quantity) 
limit 3;

select sum(Order_Quantity), Prod_id from market_fact_full
group by Prod_id having sum(Order_Quantity)> 49 order by sum(Order_Quantity) desc
limit 3;

select count(Ship_id) as num, month(Ship_Date) as month_
from shipping_dimen
group by month_
having count(Ship_id)>10
order by num desc
limit 3;

select count(Ship_id) as num, month(Ship_Date) as month_, year(Ship_Date) as year_
from shipping_dimen
group by month_, year_
having count(Ship_id)>10
order by num desc
limit 3;

select count(Customer_Name) from cust_dimen
where Customer_Name regexp '^[abcd].*er$';

select Ord_id, max(sales) from market_fact_full
group by Ord_id order by max(Sales) desc
limit 1;

select Ord_id from market_fact_full where sales in (
select max(sales) from market_fact_full);

select Ord_id from market_fact_full where sales =(
select max(sales) from market_fact_full);

select Product_Category, Product_Sub_Category from prod_dimen
where Prod_id in (
select Prod_id from market_fact_full
where Product_Base_Margin is not null);

select Cust_id, Customer_Name from cust_dimen
where Cust_id=(
select Cust_id from market_fact_full
group by Cust_id order by count(Ord_id) desc
limit 1);

select Cust_id, Customer_Name from cust_dimen
where Cust_id=(
select Cust_id from market_fact_full
group by Cust_id order by count(Cust_id) desc
limit 1);

select Product_Category, Product_Sub_Category
from prod_dimen
where Prod_id in (
select Prod_id 
from market_fact_full
group by Prod_id
order by count(Prod_id) desc)
limit 3;


with least_losses as (
select Prod_id, Profit, Product_Base_Margin 
from market_fact_full
where Profit<0
order by Profit desc
limit 5) select Prod_id, Profit from least_losses
where Product_Base_Margin= (
select max(Product_Base_Margin) from
least_losses);

with April_Low_Priority_Orders as(
select Ord_id, Order_Date from orders_dimen
where Order_Priority = 'low' and 
month(Order_Date)=4
) select count(Ord_id) from April_Low_Priority_Orders
where Day(Order_Date) between 1 and 15;

create view Low_prior
as select Ord_id, Order_Date from orders_dimen
where Order_Priority = 'low' and 
month(Order_Date)=4;

select count(Ord_id) from Low_prior
where Day(Order_Date) between 1 and 15;