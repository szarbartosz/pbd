/*lab3*/

/*cwiczenie 1*/
use northwind
select productname, categoryname, unitprice, address
from products inner join categories
on products.categoryid = categories.categoryid
inner join suppliers
on products.supplierid = suppliers.supplierid
where categoryname like 'meat/poultry' and unitprice between 20 and 30

/*cwiczenie 2*/
use northwind
select productname, unitprice, companyname
from products inner join categories
on products.categoryid = categories.categoryid
inner join suppliers
on products.supplierid = suppliers.supplierid
where categoryname like 'confections'

/*cwiczenie 3*/
use northwind
select customers.companyname, customers.phone
from customers inner join orders
on customers.customerid = orders.customerid
inner join shippers
on shipperid = shipvia
where year(shippeddate) = 1997 and shippers.companyname like 'united package'

/*cwiczenie 4*/
use northwind
select companyname, phone
from customers inner join orders
on customers.customerid = orders.customerid
inner join [order details]
on orders.orderid = [order details].orderid
inner join products
on [order details].productid = products.productid
inner join categories
on products.categoryid = categories.categoryid
where categoryname like 'confections'

/*cwiczenie 5*/
use library
select member.member_no, firstname, lastname, birth_date, street, city, state, zip
from member left outer join adult
on member.member_no = adult.member_no
left outer join juvenile
on juvenile.member_no = member.member_no

/*cwiczenie 6*/
use library
select member.member_no, member.firstname, member.lastname, birth_date, p.street, p.city, p.state, p.zip,
p.firstname as parent_firstname, p.lastname as parent_lastname
from juvenile inner join member
on juvenile.member_no = member.member_no
inner join (select adult.member_no, firstname, lastname, street, city, state, zip
			from adult inner join member
			on adult.member_no = member.member_no) as p
on adult_member_no = p.member_no



