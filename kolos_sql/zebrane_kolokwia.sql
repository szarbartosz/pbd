/*zygmunt kolokwia*/


--2015/16

--1
use library
select m.member_no, m.firstname, m.lastname, a.street, a.city, a.state, a.zip, count(l.isbn) as 'no of borrowed books', 'adult'
from member as m
inner join adult as a on m.member_no = a.member_no
left outer join loan as l on m.member_no = l.member_no
group by m.member_no, m.firstname, m.lastname, a.street, a.city, a.state, a.zip
union
select m.member_no, m.firstname, m.lastname, a.street, a.city, a.state, a.zip, count(l.isbn) as 'no of borrowed books', 'child'
from member as m
inner join juvenile as j on m.member_no = j.member_no
inner join adult as a on j.adult_member_no = a.member_no
left outer join loan as l on m.member_no = l.member_no
group by m.member_no, m.firstname, m.lastname, a.street, a.city, a.state, a.zip
order by 1

--2a
use library
select m.firstname, m.lastname
from member as m
left outer join loan as l on m.member_no = l.member_no
left outer join loanhist as lh on m.member_no = lh.member_no
where l.out_date is null and lh.in_date is null

--2b
use library
select firstname, lastname
from member as m
where m.member_no not in (select member_no from loan as l where m.member_no = l.member_no)
		and m.member_no not in (select member_no from loanhist as lh where m.member_no = lh.member_no)

--3a
use northwind
select od.orderid, o.freight, (select avg(freight) from orders) as 'avg freight'
from [order details] as od
inner join orders as o on od.orderid = o.orderid
where o.freight > (select avg(freight) from orders)
order by 2

--4a
use northwind
select s.companyname, month(o.orderdate) as 'month', year(o.orderdate) as 'year', sum(o.freight) as 'shipping cost'
from orders as o
inner join shippers as s on o.shipvia = s.shipperid
group by s.companyname, month(o.orderdate), year(o.orderdate)
order by 1, 3, 2, 4


--2013/14

--1
use northwind
select orderid, freight, year(shippeddate), (select avg(freight) from orders)
from orders
where freight > (select avg(freight) from orders)
order by 2

--2
use library
select distinct m.firstname, m.lastname
from member as m
left outer join loan as l on m.member_no = l.member_no
left outer join loanhist as lh on m.member_no = lh.member_no
where (year(l.due_date) != 1996 and year(lh.in_date) != 1997) or (l.due_date is null and lh.in_date is null
