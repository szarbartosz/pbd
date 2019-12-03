/*zygmunt kolokwia*/


--2015/16

--1a
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
