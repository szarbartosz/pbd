/*podzapytania*/
use northwind

/*cwizcenie 1*/
--1
select companyname, phone
from customers as c
where select o.shippeddate, s.companyname
		from orders as o

/*cwiczenie 4*/
--1a
select sum(unitprice * quantity * (1 - discount)) 
+ (select freight from orders where orderid = 10250)
from [order details]
where [order details].orderid = 10250

--1b
select orderid, (select sum(unitprice * quantity * (1 - discount))
from [order details] where [order details].orderid = 10250)
+ (select freight from orders where orders.orderid = 10250)
from orders where orders.orderid = 10250

--2
select a.orderid, a.freight +
(select sum(b.unitprice * b.quantity * (1 - b.discount)) 
from [order details] as b where a.orderid = b.orderid)
from orders as a
order by a.orderid

--3
select c.companyname, c.address
from customers as c
where not exists (select * from orders as o
					where o.customerid = c.customerid 
					and year(orderdate) = 1997)

--4 join
select p.productname
from products as p
inner join [order details] od on od.productid = p.productid
inner join orders o on o.orderid = od.orderid
inner join customers c on c.customerid = o.customerid
group by productname
having count(c.companyname) > 1