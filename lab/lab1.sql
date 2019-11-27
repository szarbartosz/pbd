use northwind

--select employeeid, lastname, firstname, title from employees
--select companyname, address from customers
--select lastname, homephone from employees
--select productname, unitprice from products
--select categoryname, description from categories
--select companyname, homepage from suppliers

--select employeeid, lastname, firstname, title from employees where employeeid = 5
--select lastname, city from employees where country = 'usa'
--select orderid, customerid from orders where orderdate < '1996-08-01'
--select companyname, address from customers where city = 'london'
--select companyname, address from customers where country = 'france' or country = 'spain'
--select productname, unitprice from products where unitprice between 20.00 and 30.00
--select productname, unitprice from products, categories where (select categoryname like 'meat%'
--select productname, unitprice from products where productid = (select categoryid from categories where categoryname like 'Meat/Poultry')

--select companyname from customers where companyname like '%restaurant%'
--select productname from products where quantityperunit like '%bottle%'
--select reportsto from employees where lastname like '[b-l]%'
--select reportsto from employees where lastname like '[bl]%'
--select categoryname from categories where description like '%,%'
--select companyname from customers where companyname like '%store'

--select productname, unitprice from products where unitprice between 10 and 20
--select companyname, country from suppliers where country in ('japan', 'italy')
--select companyname , fax from suppliers where fax is null
--select orderid, orderdate, customerid from orders where shippeddate is null and shipcountry = 'argentina'
--select orderid, orderdate, customerid from orders where (shippeddate is null or shippeddate > getdate()) and shipcountry = 'argentina'

--select productid, productname, unitprice from products order by unitprice
--select productid, productname, unitprice from products order by unitprice desc
/*ASC - default - ascending, DESC - descendig*/
--select companyname, country from customers order by country, companyname
--select categoryname, productname, unitprice from categories, products order by categoryname, unitprice desc
--select companyname, country from customers where country like 'uk' or country like 'italy' order by country, companyname

--select distinct country from suppliers
--select distinct country, city from suppliers
/*distinct - dziala na ostatni z wymienionych parametrow*/
--select firstname as imie, lastname as nazwisko from employees
--select firstname, lastname, 'id number:', employeeid from employees
--select firstname + '    ' + lastname as 'imie i nazwisko' from employees
--select orderid, unitprice as oldunitprice, unitprice * 1.05 as newunitprice from [order details]
--select firstname + lastname as imieinazwisko from employees



