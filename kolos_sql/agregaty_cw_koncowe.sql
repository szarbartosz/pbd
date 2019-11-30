/*powtorka - kolos sql 2019*/


/*agregaty - lab2*/


--cwiczenie 1
use northwind

--1
select orderid, sum(quantity * unitprice * (1 - discount)) as 'order value'
from [order details]
group by orderid
order by 2 desc

--2
select top 10 orderid, sum(quantity * unitprice * (1 - discount)) as 'order value'
from [order details]
group by orderid
order by 2 desc

--3
select top 10 with ties orderid, sum(quantity * unitprice * (1 - discount)) as 'order value'
from [order details]
group by orderid
order by 2 desc


--cwiczenie 2 
use northwind

--1
select productid, sum(quantity) as 'total quantity'
from [order details]
where productid < 3
group by productid

--2
select productid, sum(quantity) as 'total quantity'
from [order details]
group by productid 

--3
select orderid, sum(quantity + unitprice * (1 - discount)) as 'order value'
from [order details]
group by orderid
having sum(quantity) > 250


--cwiczenie 3 
use northwind

--1
select productid, orderid, sum(quantity)
from [order details]
group by productid, orderid with rollup

--2
select productid, orderid, sum(quantity)
from [order details]
where productid = 50
group by productid, orderid with rollup





