/*join - cwiczenia koncowe*/

/*cwiczenie 1*/
use northwind
--1
select c.companyname, sum(od.quantity)
from customers as c 
inner join orders as o on c.customerid = o.customerid
inner join [order details] as od on o.orderid = od.orderid
group by o.orderid, c.companyname

--2
select c.companyname, sum(od.quantity)
from customers as c 
inner join orders as o on c.customerid = o.customerid
inner join [order details] as od on o.orderid = od.orderid
group by o.orderid, c.companyname
having sum(od.quantity) > 250

--3
select od.orderid, c.companyname, sum(od.unitprice * quantity * (1 - discount)) as 'total price'
from [order details] as od
inner join orders as o on od.orderid = o.orderid
inner join customers as c on o.customerid = c.customerid
group by od.orderid, c.companyname

--4
select od.orderid, c.companyname, sum(od.unitprice * quantity * (1 - discount)) as 'total price'
from [order details] as od
inner join orders as o on od.orderid = o.orderid
inner join customers as c on o.customerid = c.customerid
group by od.orderid, c.companyname
having sum(od.quantity) > 250

--5
select e.firstname, e.lastname, od.orderid, c.companyname, sum(od.unitprice * od.quantity * (1 - discount)) as 'total price'
from [order details] as od
inner join orders as o on od.orderid = o.orderid
inner join customers as c on o.customerid = c.customerid
inner join employees as e on e.employeeid = o.employeeid
group by od.orderid, c.companyname, e.firstname, e.lastname
having sum(od.quantity) > 250

/*cwiczenie 2*/
--1
select c.categoryname, sum(od.quantity) as 'total number of ordered units'
from categories as c
inner join products as p on c.categoryid = p.categoryid
inner join [order details] as od on p.productid = od.productid
group by c.categoryname

--2
select c.categoryname, sum(od.unitprice * od.quantity * (1 - od.discount)) as 'total value of orders'
from categories as c
inner join products as p on c.categoryid = p.categoryid
inner join [order details] as od on p.productid = od.productid
group by c.categoryname

--3a
select c.categoryname, sum(od.unitprice * od.quantity * (1 - od.discount)) as 'total value of orders'
from categories as c
inner join products as p on c.categoryid = p.categoryid
inner join [order details] as od on p.productid = od.productid
group by c.categoryname
order by 2

--3b
select c.categoryname, sum(od. unitprice * od.quantity * (1 - od.discount)) as 'total value of orders', sum(od.quantity) as 'total number of ordered units'
from categories as c
inner join products as p on c.categoryid = p.categoryid
inner join [order details] as od on p.productid = od.productid
group by c.categoryname
order by sum(od.quantity)

/*cwiczenie 3*/
--1
select s.companyname, count(*) as 'orders shipped in 1997'
from shippers as s
inner join orders as o on s.shipperid = o.shipvia
where year(o.shippeddate) = 1997
group by s.companyname

--2
select top 1 s.companyname as 'top shipper in 1997'
from shippers as s
inner join orders as o on s.shipperid = o.shipvia
where year(o.shippeddate) = 1997
group by s.companyname
order by count(*) desc

--3
select top 1 e.firstname + ' ' + e.lastname as 'top employee of 1997'
from employees as e
inner join orders as o on e.employeeid = o.employeeid
where year(shippeddate) = 1997
group by e.firstname, e.lastname
order by count(*) desc

/*cwiczenie 4*/
--1
select e.firstname, e.lastname, sum(od.unitprice * od.quantity * (1 - od.discount)) as 'total value of processed orders'
from employees as e 
inner join orders as o on e.employeeid = o.employeeid
inner join [order details] as od on o.orderid = od.orderid
group by e.firstname, e.lastname

--2
select top 1 e.firstname + ' ' + e.lastname as 'employee which processed orders with the largest total value'
from employees as e 
inner join orders as o on e.employeeid = o.employeeid
inner join [order details] as od on o.orderid = od.orderid
group by e.firstname, e.lastname
order by sum(od.quantity * (1 - od.discount)) desc

--3a
select e.firstname + ' ' + e.lastname as 'employee with subordinates', sum(od.unitprice * od.quantity * (1 - od.discount)) as 'total value of processed orders'
from employees as e 
inner join orders as o on e.employeeid = o.employeeid
inner join [order details] as od on o.orderid = od.orderid
inner join (select distinct reportsto from employees)
as er on e.employeeid = er.reportsto
group by e.firstname, e.lastname

--3b
select e.firstname + ' ' + e.lastname as 'employee without subordinates', sum(od.unitprice * od.quantity * (1 - od.discount)) as 'total value of processed orders'
from employees as e 
inner join orders as o on e.employeeid = o.employeeid
inner join [order details] as od on o.orderid = od.orderid
left outer join employees as es on es.reportsto = e.employeeid
where es.reportsto is null
group by e.firstname, e.lastname

