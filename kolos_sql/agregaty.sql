/*powtorka - kolos sql 2019*/


/*agregaty - lab2*/


--cwiczenie 1
use northwind

--1
select count(*)
from products
where unitprice not between 10 and 20

--2
select max(unitprice)
from products
where unitprice < 20

--3a
select max(unitprice)
from products
where quantityperunit like '%bottle%'

--3b
select min(unitprice)
from products
where quantityperunit like '%bottle%'

--3c
select avg(unitprice)
from products
where quantityperunit like '%bottle%'

--4
select *
from products
where unitprice > (select avg(unitprice) from products)

--5
select sum(quantity * unitprice * (1 - discount))
from [order details]
where orderid = 10250


--cwiczenie 2
use northwind

--1
select orderid, max(unitprice)
from [order details]
group by productid
order by 2 desc

--2
select orderid, max(unitprice), min(unitprice)
from [order details]
group by orderid

--3
select shipvia, count(*)
from orders
where shippeddate is not null
group by shipvia

--4
select top(1) shipvia, count(*)
from orders
where year(shippeddate) = 1997
group by shipvia
order by 2 desc


--cwiczenie 3
use northwind

--1
select orderid
from [order details]
group by orderid
having count(*) > 5

--2
select customerid
from orders
where year(shippeddate) = 1998
group by customerid
having count(*) > 8 
order by sum(freight)


--group by (with rollup / cube)
select productid, orderid, sum(quantity) as 'total quantity'
from orderhist
group by productid, orderid
with rollup

select productid, orderid, sum(quantity) as 'total quantity'
from orderhist
group by productid, orderid
with cube

select productid, orderid, sum(quantity) as 'total quantity'
from orderhist
group by productid, orderid






