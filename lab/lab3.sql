use joindb

select *
from buyers

select * 
from produce

select *
from sales

select buyer_name, sales.buyer_id, qty
from buyers left outer join sales
on buyers.buyer_id = sales.buyer_id

select buyer_name, sales.buyer_id, qty
from buyers left outer join sales
on buyers.buyer_id = sales.buyer_id
where qty is null

/*cwiczenie 1*/
use library

select firstname, lastname, juvenile.member_no, birth_date
from member join juvenile
on member.member_no = juvenile.member_no

select firstname, lastname, juvenile.member_no, birth_date
from member left outer join juvenile
on member.member_no = juvenile.member_no

select distinct title
from loan inner join title
on loan.title_no = title.title_no

select  member_no, title, fine_assessed
from loanhist inner join title
on loanhist.title_no = title.title_no
where title like 'tao teh king' and fine_assessed is not null and fine_assessed != 0

select  member_no, title, in_date, due_date, datediff(day, due_date, in_date)
from loanhist inner join title
on loanhist.title_no = title.title_no
where title like 'tao teh king' and in_date > due_date

select isbn
from reservation inner join member
on reservation.member_no = member.member_no
where firstname like 'stephen' and middleinitial like 'a' and lastname like 'graff'

/*cwiczenie 2*/
use northwind

select productname, unitprice, address
from products inner join suppliers
on products.supplierid = suppliers.supplierid
where unitprice between 20 and 30

select productname, unitsinstock
from products inner join suppliers
on products.supplierid = suppliers.supplierid
where companyname like 'tokyo traders'

select companyname, address
from customers left outer join orders
on customers.customerid = orders.customerid and year(orderdate) = 1997
where orderdate is null

select companyname, phone
from suppliers inner join products
on suppliers.supplierid = products.supplierid
where unitsinstock = 0

--laczenie wiecej niz 2 tabel
use joindb

select buyer_name, prod_name, qty
from buyers 
inner join sales
on buyers.buyer_id = sales.buyer_id
inner join produce
on sales.prod_id = produce.prod_id

select buyer_name, prod_name, qty
from buyers 
left outer join sales
on buyers.buyer_id = sales.buyer_id
left outer join produce
on sales.prod_id = produce.prod_id

--laczenie tabeli samej ze soba
use joindb
select a.buyer_name as buyer1, produce.prod_name,
b.buyer_name as buyer2
from sales as a join sales as b
on a.prod_id = b.prod_id
join buyers on buyers.buyer_id = a.buyer_id
join buyers on buyers.buyer_id = a.buyer_id
join produce on produce.prod_id = b.prod_id
where a.buyer_id < b.buyer_id
