use northwind

--agregaty 

select top 10 with ties od.orderid, sum(od.quantity * od.unitprice * (1 - od.discount)) as "total value of order"
from [order details] as od
group by od.orderid
order by 2

select p.productid, p.productname, count(od.productid) as 'total no of ordered units'
from products p
join [order details] od on p.productid = od.productid
where p.productid < 3
group by p.productid, p.productname

select od.productid, count(*) as 'total no of ordered units'
from [order details] od
where od.productid < 3
group by od.productid

select orderid, sum(unitprice * quantity * (1 - discount)) as 'order value', sum(quantity) as 'no of units'
from [order details]
group by orderid
having sum(quantity) > 250

select productid, orderid, sum(quantity) as 'no of units'
from [order details]
group by productid, orderid
with rollup

--join

select od.orderid, c.companyname, sum(od.quantity)
from [order details] od
join orders o on od.orderid = o.orderid
join customers c on o.customerid = c.customerid
group by od.orderid, c.companyname
having sum(od.quantity) > 250

select od.orderid, c.companyname, e.firstname + ' ' + e.lastname as 'employee in charge' , sum(od.quantity * od.unitprice * (1 - od.discount)) as 'value of order'
from [order details] od
join orders o on od.orderid = o.orderid
join customers c on o.customerid = c.customerid
join employees e on o.employeeid = e.employeeid
group by od.orderid, c.companyname, e.firstname + ' ' + e.lastname 
having sum(od.quantity) > 250

select ca.categoryid, ca.categoryname, sum(od.quantity) as 'no of ordered units'
from categories ca
left join products p on ca.categoryid = p.categoryid
left join [order details] od on p.productid = od.productid
group by ca.categoryid, ca.categoryname

select ca.categoryid, ca.categoryname, sum(od.quantity * od.unitprice * (1 - od.discount)) as 'value of ordered units'
from categories ca
left join products p on ca.categoryid = p.categoryid
left join [order details] od on p.productid = od.productid
group by ca.categoryid, ca.categoryname
order by sum(od.quantity)

select top 1 s.companyname, count(*) as 'no of shipped orders'
from shippers s
join orders o on s.shipperid = o.shipvia
where year(shippeddate) = 1997
group by s.companyname
order by 2 desc

select top 1 e.firstname, e.lastname, count(*) as 'no of processed orders'
from orders o 
join employees e on o.employeeid = e.employeeid
group by e.firstname, e.lastname
order by 3 desc

select e.firstname, e.lastname, sum(od.quantity * od.unitprice * (1 - od.discount)) as 'value of processed orders'
from [order details] od
join orders o on od.orderid = o.orderid
join employees e on o.employeeid = e.employeeid
group by e.firstname, e.lastname

select top 1 e.firstname, e.lastname, sum(od.quantity * od.unitprice * (1 - od.discount)) as 'value of processed orders'
from [order details] od
join orders o on od.orderid = o.orderid
join employees e on o.employeeid = e.employeeid
where year(o.orderdate) = 1997
group by e.firstname, e.lastname
order by 3 desc

select e.employeeid, e.firstname, e.lastname, sum(od.quantity * od.unitprice * (1 - od.discount)) as 'total value of processed orders'
from employees e 
join orders o on e.employeeid = o.employeeid
join [order details] od on o.orderid = od.orderid
join employees es on e.employeeid = es.reportsto
group by e.employeeid, e.firstname, e.lastname

select e.employeeid, e.firstname, e.lastname, sum(od.quantity * od.unitprice * (1 - od.discount)) as 'total lvalue of processed orders'
from employees e
left join employees es on e.employeeid = es.reportsto
join orders o on e.employeeid = o.employeeid
join [order details] od on o.orderid = od.orderid
where es.reportsto is null
group by e.employeeid, e.firstname, e.lastname
order by 1

--podzapytania

select distinct c.companyname, c.phone
from customers c 
join orders o on c.customerid = o.customerid
join shippers s on o.shipvia = s.shipperid
where s.companyname like 'united package' and year(o.shippeddate) = 1997

select distinct c.companyname, c.phone
from customers c
where c.customerid in (select o.customerid
					   from orders o
					   where year(o.shippeddate) = 1997 and (select s.companyname
										   					 from shippers as s
															 where o.shipvia = s.shipperid) like 'united package')
--
select distinct c.companyname, c.phone
from customers c
where c.customerid in (select o.customerid
					   from orders o
					   where o.orderid in (select od.orderid
										   from [order details] od
										   where od.productid in (select p.productid
																  from products p
																  where p.categoryid in (select ca.categoryid
																						 from categories ca
																						 where ca.categoryname like 'confections')
																 )
										   )
						)

--
select p.productname, (select max(quantity)
					  from [order details] od
					  where od.productid = p.productid)
from products p
--
select productname
from products
where unitprice < (select avg(unitprice)
				   from products)
--
select p.productname
from products p 
where unitprice < (select avg(unitprice)
				   from products
				   where categoryid = p.categoryid)
--
select productname, unitprice, (select avg(unitprice) as 'cost'
								from products), 
							    abs(unitprice - (select avg(unitprice)
						                         from products))
from products
--
select p.productname, p.unitprice, (select ca.categoryname
					                from categories ca
					                where ca.categoryid = p.categoryid) as 'categoryname',
								   (select avg(unitprice)
									from products
									where categoryid = p.categoryid) as 'avg category price',
								   abs(p.unitprice -  (select avg(unitprice)
													   from products
													   where categoryid = p.categoryid)) as 'difference'
from products p
order by 3
--
select (select sum(quantity * unitprice * (1 - discount))
	    from [order details]
		where orderid = 10250) + (select freight
								  from orders
							      where orderid = 10250)
--
select o.orderid, (select sum(od.quantity * od.unitprice * (1 - od.discount))
		           from [order details] od
		           where od.orderid = o.orderid) + freight as 'total value of order (shippment included)'						
from orders as o
--
select c.companyname, c.address
from customers c
where c.customerid not in (select o.customerid
						   from orders o
						   where year(o.orderdate) = 1997) 
--
select c.companyname, c.address
from customers c
where not exists (select o.orderid 
				  from orders o 
				  where c.customerid = o.customerid and year(orderdate) = 1997)
--
select e.firstname, e.lastname, (select sum(od.quantity * od.unitprice * (1 - od.discount))
								 from [order details] od
								 where od.orderid in (select o.orderid
													  from orders o
													  where o.employeeid = e.employeeid)
								) + (select sum(freight)
									 from orders o2
									 where o2.employeeid = e.employeeid)
from employees e
--
select top 1 e.firstname, e.lastname, (select sum(od.quantity * od.unitprice * (1 - od.discount))
								 from [order details] od
								 where od.orderid in (select o.orderid
													  from orders o
													  where o.employeeid = e.employeeid and year(o.orderdate) = 1997)
								) + (select sum(freight)
									 from orders o2
									 where o2.employeeid = e.employeeid)
from employees e
order by 3 desc
--
select e.employeeid, e.firstname, e.lastname, (select sum(od.quantity * od.unitprice * (1 - od.discount))
								 from [order details] od
								 where od.orderid in (select o.orderid
													  from orders o
													  where o.employeeid = e.employeeid)
								) + (select sum(freight)
									 from orders o2
									 where o2.employeeid = e.employeeid)
from employees e
where e.employeeid in (select es.employeeid
					   from employees es
					   where not exists (select employeeid from employees where reportsto = es.employeeid))