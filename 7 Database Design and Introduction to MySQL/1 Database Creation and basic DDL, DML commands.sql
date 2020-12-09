-- There are 2 types of commands in SQL: DDL commands and DML commands.
-- DDL Data Definition language.
-- DML Data Manipulation language. 

-- DDL commands- create table, 
-- alter table- add constraint, add column, drop column, change(datatype) of a column.
-- drop, truncate, cooment, rename.

-- DML commands- select, insert, update, delete.  

-- Creating a 
create database market_star_schema;

use market_star_schema;

create table shipping_mode_dimen(
	Ship_Mode varchar(25),
    Vehicle_Company varchar(25),
    Toll_Required boolean
);

alter table shipping_mode_dimen
add constraint primary key (Ship_Mode);

insert into shipping_mode_dimen
values ('Delivery truck', 'Ashok Leyland', False),
('Regular Air', 'Air India', False);

insert into shipping_mode_dimen (Ship_Mode, Vehicle_Company, Toll_Required)
values ('Roadways', 'LNT', False),
('Regular Airways', 'Spice jet', False);

select * from shipping_mode_dimen;

insert into shipping_mode_dimen (Ship_Mode, Vehicle_Company)
values ('Waterways', 'Sultan Mirza Transport');

update shipping_mode_dimen
set Toll_Required= True
where Ship_Mode in ('Regular Airways', 'Delivery truck');

delete from shipping_mode_dimen
where Ship_Mode='Waterways';

alter table shipping_mode_dimen
add Vehicle_num varchar(20);

update shipping_mode_dimen
set Vehicle_num='GJ16 JV 4752'
where Ship_Mode in ('Delivery truck', 'Roadways');

update shipping_mode_dimen
set Vehicle_num= null
where Ship_Mode NOT in ('Delivery truck', 'Roadways');

select * from shipping_mode_dimen;

alter table shipping_mode_dimen
drop column Vehicle_num;

alter table shipping_mode_dimen
change Toll_Required Toll_amount int;
select * from shipping_mode_dimen;

drop table shipping_mode_dimen;


