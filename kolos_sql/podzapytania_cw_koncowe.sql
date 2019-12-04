/*powtorka - kolos sql 2019*/


/*podzapytania - lab4*/


/*cwiczenie 1*/
use northwind

--1
select c.companyname, c.phone
from customers as c
where c.customerid in (
	select o.customerid from orders as o 
	where shipvia = (
		select shipperid from shippers 
		where companyname like 'united package'
	) 
	and year(shippeddate) = 1997
)  

--2
select c.companyname, c.phone
from customers as c
where customerid in (
	select customerid from orders
	where orderid in (
		select orderid from [order details]
		where productid in (
			select productid from products
			where categoryid = (select categoryid from categories where categoryname like 'confections')
		)
	)
)

--3
select c.companyname, c.phone
from customers as c
where customerid not in (
	select customerid from orders
	where orderid in (
		select orderid from [order details]
		where productid in (
			select productid from products
			where categoryid = (select categoryid from categories where categoryname like 'confections')
		)
	)
)


/*cwiczenie 2*/
use northwind

--1
select productid, productname, (select max(quantity) from [order details] as od where p.productid = od.productid)
from products as p

--2
select productid, productname, unitprice, (select avg(unitprice) from products as p2)
from products as p
where unitprice < (select avg(unitprice) from products as p_wew)

--3
select productid, productname, unitprice, (select avg(unitprice) from products as p_wew where p_wew.categoryid = p_zew.categoryid)
from products as p_zew
where unitprice < (select avg(unitprice) from products as p_wew where p_wew.categoryid = p_zew.categoryid)
order by 1


/*cwiczenie 3*/
use northwind

--1
select productname, unitprice, (select avg(unitprice) from products), unitprice - (select avg(unitprice) from products)
from products

--2
select productname, (select categoryname from categories as c where p.categoryid = c.categoryid), unitprice, 
		(select avg(unitprice) from products), unitprice - (select avg(unitprice) from products)
from products as p


/*cwiczenie 4*/
use northwind

--1
select orderid, sum(quantity * unitprice * (1 - discount)) + (select freight from orders where orderid = 10250)
from [order details]
where orderid = 10250
group by orderid

--2
select orderid, sum(quantity * unitprice * (1 - discount)) + (select freight from orders as o where od.orderid = o.orderid)
from [order details] as od
group by orderid

--3
select customerid, companyname, address
from customers
where customerid not in (select customerid from orders where year(orderdate) = 1997)											

