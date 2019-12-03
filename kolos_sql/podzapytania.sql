/*powtorka - kolos sql 2019*/


/*podzapytania - lab4*/


/*podzapytania*/
use northwind

--podzapytania do tabel
select t.orderid, t.customerid
from (select orderid, customerid from orders) as t

--podzapytanie jako wyrażenie
select productname, unitprice, (select avg(unitprice) from products) as average, unitprice - (select avg(unitprice) from products) as difference
from products

--podzapytanie w warunku

select productname, unitprice, (select avg(unitprice) from products) as average, unitprice - (select avg(unitprice) from products) as differece
from products
where unitprice > (select avg(unitprice) from products)


/*podzapytania skolerowane*/
use northwind

--podzapytania skolerowane
select productname, unitprice, (select avg(unitprice) from products as p_wew where p_zew.categoryid = p_wew.categoryid) as 'category average'
from products as p_zew

--podzapytania skorelowane w warunku
select productname, unitprice, (select avg(unitprice) from products as p_wew where p_zew.categoryid = p_wew.categoryid) as 'category average'
from products as p_zew
where unitprice > (select avg(unitprice) from products as p_wew where p_zew.categoryid = p_wew.categoryid)

--dla kazdego produktu podaj maksymalna liczbe zamowionych jednostek
select distinct productid, quantity
from [order details] as od1
where quantity = (select max(quantity) from [order details] as od2 where od1.productid = od2.productid)
order by productid

--to samo przy uzyciu group by
select productid, max(quantity)
from [order details]
group by productid
order by productid


/*operatory exists, not exists*/
use northwind

--exists
select lastname, employeeid
from employees as e
where exists (select * from orders as o where e.employeeid = o.employeeid and o.orderdate = '9/5/97')

--to samo przy uzyciu join
select distinct lastname, e.employeeid
from orders as o
inner join employees as e on o.employeeid = e.employeeid
where o.orderdate = '9/5/97'

--not exists
select lastname, employeeid
from employees as e
where not exists (select * from orders as o where e.employeeid = o.employeeid and o.orderdate = '9/5/97')



/*operatory in, not in*/
use northwind

--in
select lastname, employeeid
from employees as e
where employeeid in (select employeeid from orders as o where e.employeeid = o.employeeid and o.orderdate = '9/5/97')

--not in
select lastname, employeeid
from employees as e
where employeeid not in (select employeeid from orders as o where e.employeeid = o.employeeid and o.orderdate = '9/5/97')