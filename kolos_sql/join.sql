/*powtorka - kolos sql 2019*/


/*join - lab3*/


--cwiczenie 1
use library

--1
select m.firstname, m.lastname, j.birth_date
from member as m
inner join juvenile as j on m.member_no = j.member_no

--2
select t.title
from title as t
inner join loan as l on t.title_no = l.title_no

--3
select lh.in_date, datediff(day, lh.in_date, lh.due_date), lh.fine_paid
from loanhist as lh
inner join title as t on lh.title_no = t.title_no
where lh.in_date > lh.due_date and t.title like 'tao teh king'

--4
select r.isbn
from reservation as r
inner join member as m on r.member_no = m.member_no
where m.firstname like 'stephen' and middleinitial like 'a' and lastname like 'graff'


--cwiczenie 2
use northwind

--1
select p.productname, p.unitprice, s.address
from products as p
inner join suppliers as s on p.supplierid = s.supplierid
where p.unitprice between 20 and 30

--2
select p.productname, p.unitsinstock
from products as p
inner join suppliers as s on p.supplierid = s.supplierid
where s.companyname like 'tokyo traders'

--3
select c.companyname
from customers as c
left outer join orders as o on c.customerid = o.customerid and  year(orderdate) = 1997
where orderdate is null

--4
select s.companyname, s.phone
from suppliers as s
inner join products as p on s.supplierid = p.supplierid
where p.unitsinstock = 0

--cwiczenie 3

--1
select p.productname, p.unitprice, s.address
from products as p
inner join suppliers as s on p.supplierid = s.supplierid
inner join categories as c on p.categoryid = c.categoryid
where p.unitprice between 20 and 30 and c.categoryname like 'meat/poultry'

--2
select p.productname, p.unitprice, s.companyname
from products as p
inner join categories as c on p.categoryid = c.categoryid
inner join suppliers as s on p.supplierid = s.supplierid
where c.categoryname like 'confections'

--3
select c.companyname, c.phone
from customers as c
inner join orders as o on c.customerid = o.customerid
inner join shippers as s on o.shipvia = s.shipperid
where year(shippeddate) = 1997 and s.companyname like 'united package'

--4
select c.companyname, c.phone
from customers as c
inner join orders as o on c.customerid = o.customerid
inner join [order details] as od on o.orderid = od.orderid
inner join products as p on od.productid = p.productid
inner join categories as cat on p.categoryid = cat.categoryid
where cat.categoryname like 'confections'


--cwiczenie 4
use library

--1
select m.firstname, m.lastname, j.birth_date, a.zip, a.street, a.city, a.state
from member as m
inner join juvenile as j on m.member_no = j.member_no
inner join adult as a on j.adult_member_no = a.member_no

--2
select jm.firstname, jm.lastname, j.birth_date, a.zip, a.street, a.city, a.state, am.firstname, am.lastname
from member as jm
inner join juvenile as j on jm.member_no = j.member_no
inner join adult as a on j.adult_member_no = a.member_no
inner join member as am on am.member_no = a.member_no


--cwiczenie 5
use northwind

--1
select a.firstname + a.lastname as 'superior', b.firstname + b.lastname as 'subordinate'
from employees as a
right outer join employees as b on a.employeeid = b.reportsto

--2
select a.firstname + a.lastname as 'superior', b.firstname + b.lastname as 'subordinate'
from employees as a
left outer join employees as b on a.employeeid = b.reportsto
where b.firstname + b.lastname is null


--cwiczenie 6
use library

--1
select a.street, a.city, a.state, a.zip, j.birth_date
from adult as a
inner join juvenile as j on a.member_no = j.adult_member_no
where j.birth_date < '1/1/96'

--2
select a.street, a.city, a.state, a.zip, j.birth_date
from adult as a
left outer join loan as l on a.member_no = l.member_no and (l.due_date > getdate() or l.due_date is null)
inner join juvenile as j on a.member_no = j.adult_member_no
where j.birth_date < '1/1/96'

--3
select m.firstname + ' ' + m.lastname as 'name', a.street + ' ' + a.city + ' ' + a.state + ' ' + a.zip as 'address'
from adult as a
inner join member as m on a.member_no = m.member_no

--4
select m.member_no, m.firstname, m.lastname, r.isbn, r.log_date
from member as m
left outer join reservation as r on m.member_no = r.member_no
where m.member_no = 250 or m.member_no = 342 or m.member_no = 1675

--5
select m.firstname, m.lastname, count(j.member_no)
from adult as a
inner join juvenile as j on a.member_no = j.adult_member_no
inner join member as m on a.member_no = m.member_no 
where a.state like 'az'
group by m.firstname, m.lastname
having count(j.member_no) > 2

--6
select m.firstname, m.lastname, count(j.member_no)
from adult as a
inner join juvenile as j on a.member_no = j.adult_member_no
inner join member as m on a.member_no = m.member_no 
where a.state like 'az'
group by m.firstname, m.lastname
having count(j.member_no) > 2
union
select m.firstname, m.lastname, count(j.member_no)
from adult as a
inner join juvenile as j on a.member_no = j.adult_member_no
inner join member as m on a.member_no = m.member_no 
where a.state like 'ca'
group by m.firstname, m.lastname
having count(j.member_no) > 3


--cwiczenie 7
use northwind

--1
select ca.categoryname,  sum(od.quantity) as 'total no of units', c.companyname
from categories as ca
inner join products as p on ca.categoryid = p.categoryid
inner join [order details] as od on p.productid = od.productid
inner join orders as o on od.orderid = o.orderid
inner join customers as c on o.customerid = c.customerid
group by ca.categoryname, c.companyname

--2
select od.orderid, sum(od.quantity) as 'total no of units', c.companyname
from [order details] as od
inner join orders as o	on od.orderid = o.orderid
inner join customers as c on o.customerid  = c.customerid
group by od.orderid, c.companyname

--3
select od.orderid, sum(od.quantity) as 'total no of units', c.companyname
from [order details] as od
inner join orders as o	on od.orderid = o.orderid
inner join customers as c on o.customerid  = c.customerid
group by od.orderid, c.companyname
having sum(od.quantity) > 250

--4
select c.companyname, p.productname
from customers as c
inner join orders as o on c.customerid = o.customerid
inner join [order details] as od on o.orderid = od.orderid
inner join products as p on od.productid = p.productid
order by 1

--5
select c.companyname, o.orderid,  sum(od.quantity * od.unitprice * (1 - od.discount)) as 'total value of orders'
from customers as c
left outer join orders as o on c.customerid = o.customerid
inner join [order details] as od on o.orderid = od.orderid
group by c.companyname, o.orderid
order by 1,2


--cwiczenie 8
use library

--1
select m.firstname, m.lastname
from member as m
left outer join loan as l on m.member_no = l.member_no
left outer join loanhist as lh on m.member_no = lh.member_no
where l.due_date is null and lh.due_date is null
