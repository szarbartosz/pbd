use northwind

select top 5 orderid, productid, quantity
from [order details]
order by quantity desc

select top 5 with ties orderid, productid, quantity
from [order details]
order by quantity desc

select count(*)
from employees

select count(reportsto)
from employees

select avg(unitprice)
from products

select sum(quantity)
from [order details]

select count(*)
from products
where unitprice between 10 and 20

select max(unitprice)
from products
where unitprice < 20

select max(unitprice)
from products
where quantityperunit like '%bottle%'

select min(unitprice)
from products
where quantityperunit like '%bottle%'

select avg(unitprice)
from products
where quantityperunit like '%bottle%'

select *
from products
where unitprice > (select avg(unitprice) from products)

select sum(unitprice * quantity * (1-discount))
from [order details]
where orderid = 10250

select orderid, sum(unitprice * quantity * (1-discount))
from [order details]
group by orderid

select * from orderhist

select orderid, max(unitprice) as 'maxPrice'
from [order details]
group by orderid
order by maxPrice desc

select orderid, max(unitprice)
from [order details]
group by orderid

select orderid, min(unitprice)
from [order details]
group by orderid

select shipvia, count(orderid) as 'ordersNo'
from orders
group by shipvia

select top 1 shipvia as [id spedytora], count(*) as [liczba przewiezoinych zamowien]
from orders
where year(shippeddate) = 1997
group by shipvia
order by 2 desc 

select productid, sum(quantity) as total_quantity
from [order details]
group by productid having sum(quantity) > 1200

select orderid, count(*) as total_no_of_products
from [order details]
group by orderid having count(*) > 5

select customerid, count(*) as total_no_of_orders
from orders
where year(shippeddate) = 1998
group by customerid having count(*) > 8
order by sum(freight) desc

select productid, orderid, sum(quantity) as total_quantity
from orderhist
group by productid, orderid
with rollup
order by productid, orderid

--to samo bez rollupa

select NULL, NULL, sum(quantity)
from orderhist

select productid, NULL, sum(quantity)
from orderhist
group by productid






