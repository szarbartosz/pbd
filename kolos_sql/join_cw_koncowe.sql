/*powtorka - kolos sql 2019*/


/*join - lab3*/


--cwiczenie 1
use northwind

--1
select od.orderid, c.companyname, sum(quantity) as 'total no of units'
from [order details] as od
inner join orders as o on od.orderid = o.orderid
inner join customers as c on o.customerid = c.customerid
group by od.orderid, c.companyname

--2
select od.orderid, c.companyname, sum(quantity) as 'total no of units'
from [order details] as od
inner join orders as o on od.orderid = o.orderid
inner join customers as c on o.customerid = c.customerid
group by od.orderid, c.companyname
having sum(quantity) > 250

--3
select od.orderid, sum(od.quantity * od.unitprice * (1 - od.discount)) as 'total value of order', c.companyname
from [order details] as od
inner join orders as o on od.orderid = o.orderid
inner join customers as c on o.customerid = c.customerid
group by od.orderid, c.companyname

--4
select od.orderid, sum(od.quantity * od.unitprice * (1 - od.discount)) as 'total value of order', c.companyname
from [order details] as od
inner join orders as o on od.orderid = o.orderid
inner join customers as c on o.customerid = c.customerid
group by od.orderid, c.companyname
having sum(quantity) > 250

--5
select od.orderid, sum(od.quantity * od.unitprice * (1 - od.discount)) as 'total value of order', c.companyname, e.firstname + ' ' + e.lastname as 'attendant employee'
from [order details] as od
inner join orders as o on od.orderid = o.orderid
inner join customers as c on o.customerid = c.customerid
inner join employees as e on o.employeeid =  e.employeeid
group by od.orderid, c.companyname, e.firstname + ' ' + e.lastname
having sum(quantity) > 250


--cwiczenie 2
use northwind

--1
select ca.categoryname, sum(od.quantity) as 'total no of ordered units'
from categories as ca
inner join products as p on ca.categoryid = p.categoryid
inner join [order details] as od on p.productid = od.productid
group by ca.categoryname

--2
select ca.categoryname, sum(od.quantity * od.unitprice * (1- od.discount)) as 'total value of ordes'
from categories as ca
inner join products as p on ca.categoryid = p.categoryid
inner join [order details] as od on p.productid = od.productid
group by ca.categoryname

--3a
select ca.categoryname, sum(od.quantity * od.unitprice * (1- od.discount)) as 'total value of ordes'
from categories as ca
inner join products as p on ca.categoryid = p.categoryid
inner join [order details] as od on p.productid = od.productid
group by ca.categoryname
order by 2

--3b
select ca.categoryname, sum(od.quantity * od.unitprice * (1- od.discount)) as 'total value of ordes'
from categories as ca
inner join products as p on ca.categoryid = p.categoryid
inner join [order details] as od on p.productid = od.productid
group by ca.categoryname
order by sum(od.quantity)


--cwiczenie 3
use northwind

--1
select s.companyname, count(*) as 'total no of shipped orders in 1997'
from shippers as s
inner join orders as o on s.shipperid = o.shipvia
where year(o.shippeddate) = 1997
group by s.companyname

--2
select top 1 s.companyname, count(*) as 'total no of shipped orders in 1997'
from shippers as s
inner join orders as o on s.shipperid = o.shipvia
where year(o.shippeddate) = 1997
group by s.companyname
order by 2 desc

--3
select top 1 e.firstname, e.lastname, count(*)
from employees as e
inner join orders as o on e.employeeid = o.employeeid
where year(o.shippeddate) = 1997
group by e.firstname, e.lastname
order by 3 desc


--cwiczenie 4
use northwind

--1
select e.firstname, e.lastname, sum(od.quantity * od.unitprice * (1 - od.discount)) as 'total value of processed orders'
from employees as e
inner join orders as o on e.employeeid = o.employeeid
inner join [order details] as od on o.orderid = od.orderid
group by e.firstname, e.lastname

--2
select top 1 e.firstname, e.lastname, sum(od.quantity * od.unitprice * (1 - od.discount)) as 'total value of processed orders'
from employees as e
inner join orders as o on e.employeeid = o.employeeid
inner join [order details] as od on o.orderid = od.orderid
group by e.firstname, e.lastname
order by 3 desc

--3a
select e.firstname, e.lastname, sum(od.quantity * od.unitprice * (1 - od.discount)) as 'total value of processed orders'
from employees as e
inner join orders as o on e.employeeid = o.employeeid
inner join [order details] as od on o.orderid = od.orderid
inner join (select distinct reportsto from employees) as er on e.employeeid = er.reportsto
group by e.firstname, e.lastname


--3b
select e.firstname, e.lastname, sum(od.quantity * od.unitprice * (1 - od.discount)) as 'total value of processed orders'
from employees as e
inner join orders as o on e.employeeid = o.employeeid
inner join [order details] as od on o.orderid = od.orderid
left outer join employees as es on e.employeeid = es.reportsto
where es.reportsto is null
group by e.firstname, e.lastname 
