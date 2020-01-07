use library
--Wypisać wszystkich czytalnikow którzy nigdy nie wypożyczyli książki dane adresowe i podział czy ta osoba jest dzieckiem (joiny, in, exists)
select m.firstname, m.lastname, a.street, a.city, a.state, 'adult' as 'adult/child', (select count(*)
																					  from juvenile j
																					  where j.adult_member_no = m.member_no) as 'no of chcildren'
from member m
join adult a on m.member_no = a.member_no
left join loan l on m.member_no = l.member_no
left join loanhist lh on m.member_no = lh.member_no
where l.out_date is null and lh.out_date is null
union
select m.firstname, m.lastname, a.street, a.city, a.state, 'child' as 'adult/child', 0 as 'no of children'
from member m
join juvenile j on m.member_no = j.member_no
join adult a on j.adult_member_no = a.member_no
left join loan l on m.member_no = l.member_no
left join loanhist lh on m.member_no = lh.member_no
where l.out_date is null and lh.out_date is null
--
select m.firstname,
	   m.lastname,
	   (select a.street
	   from adult a
	   where a.member_no = m.member_no), 
	   (select a.city
	   from adult a
	   where a.member_no = m.member_no),
	   (select a.state
	   from adult a
	   where a.member_no = m.member_no),
	   'adult' as 'adult/child', 
	   (select count(*)
	    from juvenile j
		where j.adult_member_no = m.member_no) as 'no of chcildren'
from member m
where m.member_no in (select a.member_no
				      from adult a) and m.member_no not in (select l.member_no
															from loan as l) and m.member_no not in (select lh.member_no
																									from loanhist lh)
union
select m.firstname,
	   m.lastname,
	   (select a.street
	    from adult a
		where a.member_no in (select j.adult_member_no
							  from juvenile j
							  where j.member_no = m.member_no)),
	   (select a.street
	   from adult a
	   where a.member_no in (select j.adult_member_no
							 from juvenile j
							 where j.member_no = m.member_no)),
	   (select a.street
	   from adult a
	   where a.member_no in (select j.adult_member_no
							 from juvenile j
							 where j.member_no = m.member_no)),
	   'child' as 'adult/child', 
	   0 as 'no of children'
from member m
where m.member_no in (select j.member_no
				      from juvenile j) and m.member_no not in (select l.member_no
															from loan as l) and m.member_no not in (select lh.member_no
																									from loanhist lh)
--
select m.firstname,
	   m.lastname,
	   (select a.street
	   from adult a
	   where a.member_no = m.member_no), 
	   (select a.city
	   from adult a
	   where a.member_no = m.member_no),
	   (select a.state
	   from adult a
	   where a.member_no = m.member_no),
	   'adult' as 'adult/child', 
	   (select count(*)
	    from juvenile j
		where j.adult_member_no = m.member_no) as 'no of chcildren'
from member m
where exists (select a.member_no
			  from adult a
			  where a.member_no = m.member_no) and not exists (select l.member_no
			                                                   from loan l
															   where l.member_no = m.member_no) and not exists (select lh.member_no
																											   from loanhist lh
																											   where lh.member_no = m.member_no)
union
select m.firstname,
	   m.lastname,
	   (select a.street
	    from adult a
		where a.member_no in (select j.adult_member_no
							  from juvenile j
							  where j.member_no = m.member_no)),
	   (select a.city
	   from adult a
	   where a.member_no in (select j.adult_member_no
							 from juvenile j
							 where j.member_no = m.member_no)),
	   (select a.state
	   from adult a
	   where a.member_no in (select j.adult_member_no
							 from juvenile j
							 where j.member_no = m.member_no)),
	   'child' as 'adult/child', 
	   0 as 'no of children'
from member m
where exists (select j.member_no
			  from juvenile j
			  where j.member_no = m.member_no) and not exists (select l.member_no
			                                                   from loan l
															   where l.member_no = m.member_no) and not exists (select lh.member_no
																											   from loanhist lh
																											   where lh.member_no = m.member_no)
--Dla każdego czytelnika imię nazwisko, suma książek wypożyczony przez tą osobę i jej dzieci, ten który żyje w Arizona ma mieć więcej niż 2 dzieci,
--ten kto żyje w californi ma mieć więcej niż 3 dzieci
select m.member_no,
	   m.firstname,
	   m.lastname,
	   (select count(*)
	    from loan l
	    where l.member_no = m.member_no) +
	   (select count(*)
	    from loanhist lh
		where lh.member_no = m.member_no) +
	   (select count(*)
	    from loan lch
		where lch.member_no in (select j.member_no
								from juvenile j
								where j.adult_member_no = m.member_no)) + 
	   (select count(*)
	    from loanhist lhch
		where lhch.member_no in (select j.member_no
								from juvenile j
								where j.adult_member_no = m.member_no)) as 'no of books borrowed by the: person and theirs child / child',
	   'adult' as 'adult/child', 
	   (select count(*)
	    from juvenile j
		where j.adult_member_no = m.member_no) as 'no of chcildren',
	   (select a.state
	    from adult a
	    where a.member_no = m.member_no)
from member m
where ((select count(*)
	   from juvenile j
	   where j.adult_member_no = m.member_no) > 2 and (select a.state
													   from adult a
													   where a.member_no = m.member_no) like 'az') or 
	  ((select count(*)
	   from juvenile j
	   where j.adult_member_no = m.member_no) > 3 and (select a.state
													   from adult a
													   where a.member_no = m.member_no) like 'ca') or
	  (((select a.state
	   from adult a
	   where a.member_no = m.member_no) not like 'ca')	and		
	  ((select a.state
	   from adult a
	   where a.member_no = m.member_no) not like 'az'))
union
select m.member_no,
	   m.firstname,
	   m.lastname,
	   (select count(*)
	    from loan l
		where l.member_no = m.member_no) +
	   (select count(*)
	    from loanhist lh
		where lh.member_no = m.member_no) as 'no of books borrowed by the: person and theirs child / child',
	   'child' as 'adult/child', 
	   0 as 'no of chcildren',
	   (select a.state
	    from adult a
	    where a.member_no = (select j.adult_member_no
		                      from juvenile j
							  where j.member_no = m.member_no))
from member m
where m.member_no in (select j.member_no
					 from juvenile j)
order by 1
--Najczęściej wybierana kategoria w 1997 dla każdego klienta
use northwind
select c.companyname,
	   (select top 1 ca.categoryname
	    from categories ca
		join products p on ca.categoryid = p.categoryid
		join [order details] od on p.productid = od.productid
		join orders o on od.orderid = o.orderid
		where o.customerid = c.customerid and year(o.orderdate) = 1997
		group by ca.categoryname
		order by count(*) desc) as 'category'
from customers c
--Podział na company, year month i suma freight
select s.companyname,
       year(o.shippeddate) as 'year',
	   month(o.shippeddate) as 'month',
	   sum(o.freight) as 'shipping cost'
from shippers s
join orders o on s.shipperid = o.shipvia
group by s.companyname, year(o.shippeddate), month(o.shippeddate)
order by 1, 2, 3
--liczba ksiazek pozyczonych przez kazdego czytelnika
use library
select distinct m.member_no,
	   (select count(distinct l.isbn)
	    from loan l
		where l.member_no = m.member_no) +
		(select count(distinct lh.isbn)
		from loanhist lh
		where lh.member_no = m.member_no) as 'no of borrowed books'
from member m
order by 2 desc
--Wypisz wszystkich członków biblioteki z adresami i info czy jest dzieckiem czy nie i ilosc 
--wypozyczeń w poszczegolnych latach i miesiacach
select m.member_no,
	   m.firstname, 
	   m.lastname,
	   a.street,
	   a.city,
	   a.state,
	   a.zip,
	   'adult' as 'adult/child',
	   year(lh.out_date) as 'year',
	   month(lh.out_date) as 'month',
	   count(distinct lh.isbn) as 'no of borrowed books'
from member m
join adult a on m.member_no = a.member_no
left join loanhist lh on m.member_no = lh.member_no
group by m.member_no, m.firstname, m.lastname, a.street, a.city, a.state, a.zip, year(lh.out_date), month(lh.out_date)
union
select m.member_no,
       m.firstname,
	   m.lastname,
	   a.street,
	   a.city,
	   a.state,
	   a.zip,
	   'adult' as 'adult/child',
	   year(lh.out_date) as 'year',
	   month(lh.out_date) as 'month',
	   count(distinct lh.isbn) as 'no of borrowed books'
from member m
join juvenile j on m.member_no = j.member_no
join adult a on j.adult_member_no = a.member_no
left join loanhist lh on m.member_no = lh.member_no
group by m.member_no, m.firstname, m.lastname, a.street, a.city, a.state, a.zip, year(lh.out_date), month(lh.out_date)


/*
(select a.street
	    from adult a
		where a.member_no in (select j.member_no
							 from juvenile j)),
	   (select a.city
	    from adult a
		where a.member_no = (select j.member_no
							 from juvenile j)),
	   (select a.state
	    from adult a
		where a.member_no = (select j.member_no
							 from juvenile j)),
	   (select a.zip
	    from adult a
		where a.member_no = (select j.member_no
							 from juvenile j)),
*/

--zamowienia z freight wiekszym niz avg danego roku
use northwind
select o.orderid,
	   year(o.orderdate) as year,
	   o.freight,
	   (select avg(freight)
	    from orders o2
		where year(o2.orderdate) = year(o.orderdate)
		group by year(o2.orderdate)) as 'avg freight'
from orders o
where o.freight > (select avg(freight)
				   from orders o2
				   where year(o.orderdate) = year(o2.orderdate))
--klienci, ktorzy nie zamowili nigdy produktow z kategorii seafood
select c2.customerid, c2.companyname
from customers c
join orders o on c.customerid = o.customerid
join [order details] od on o.orderid = od.orderid
join products p on od.productid = p.productid
join categories ca on p.categoryid = ca.categoryid and ca.categoryname like 'seafood'
right join customers c2 on c.customerid  = c2.customerid
where c.customerid is null

select c.customerid, c.companyname
from customers c
where c.customerid not in (select o.customerid
						   from orders o
						   where o.orderid in (select od.orderid
											   from [order details] od
											   where od.productid in (select p.productid
																      from products p
																	  where p.categoryid in (select ca.categoryid
																							 from categories ca
																							 where ca.categoryname like 'seafood')
																	  )
											   )
						  )

select c.customerid, c.companyname
from customers c
where not exists (select *
				  from orders o
				  where o.customerid = c.customerid and exists (select *
																from [order details] od
															    where od.orderid = o.orderid and exists (select *
																										 from products p
																										 where p.productid = od.productid and p.categoryid = (select ca.categoryid
																																							  from categories ca
																																							  where ca.categoryname like 'seafood')
																										 )
																)
				)
																											
--Dla każdego klienta najczęściej zamiawiana kategoria w dwóch wersjach
select c.customerid,
	   c.companyname,
	   (select top 1 ca.categoryname
	    from categories ca
		join products p on ca.categoryid = p.categoryid
		join [order details] od on p.productid = od.productid
		join orders o on od.orderid = o.orderid
		where o.customerid = c.customerid
		group by ca.categoryname
		order by count(*) desc)
from customers  c

select c.customerid,
	   c.companyname,
	   (select top 1 ca.categoryname
	    from categories ca
		where ca.categoryid in (select p.categoryid
							    from products p
							    where p.productid in (select od.productid
												      from [order details] od
													  where od.orderid in (select o.orderid
																		   from orders o
																		   where o.customerid = c.customerid)
													)
								)
		group by ca.categoryname
		order by count(*) desc)
from customers c
--Wyświetl imię, nazwisko, dane adresowe oraz ilość wypożyczonych książek dla każdego członka biblioteki
use library
select m.member_no,
	   m.firstname,
	   m.lastname,
	   a.street,
	   a.city,
	   a.state,
	   a.zip,
	   count(distinct l.isbn) + count(distinct lh.isbn) as 'no of borrowed books'
from member m
join adult a on m.member_no = a.member_no
left join loan l on m.member_no = l.member_no
left join loanhist lh on m.member_no = lh.member_no
group by m.member_no, m.firstname, m.lastname, a.street, a.city, a.state, a.zip
union
select m.member_no,
	   m.firstname,
	   m.lastname,
	   a.street,
	   a.city,
	   a.state,
	   a.zip,
	   count(distinct l.isbn) + count(distinct lh.isbn) as 'no of borrowed books'
from member m
join juvenile j on m.member_no = j.member_no
join adult a on j.adult_member_no = a.member_no
left join loan l on m.member_no = l.member_no
left join loanhist lh on m.member_no = lh.member_no
group by m.member_no, m.firstname, m.lastname, a.street, a.city, a.state, a.zip
order by 1
--
select m.member_no,
	   m.firstname,
	   m.lastname,
	   (select a.street
	    from adult a
		where a.member_no = m.member_no) street,
	   (select a.city
	    from adult a
		where a.member_no = m.member_no) city,
	   (select a.state
	    from adult a
		where a.member_no = m.member_no) state,
	   (select a.zip
	    from adult a
		where a.member_no = m.member_no),
	   (select count(l.isbn)
	    from loan l
		where m.member_no = l.member_no) + 
	   (select count(lh.isbn)
	    from loanhist lh
		where m.member_no = lh.member_no) as 'no of borrowed books'
from member m
where m.member_no in (select a.member_no
					  from adult a)
union
select m.member_no,
	   m.firstname,
	   m.lastname,
	   (select a.street
	    from adult a
		where a.member_no = (select j.adult_member_no
						     from juvenile j
							 where j.member_no = m.member_no)),
	   (select a.city
	    from adult a
		where a.member_no = (select j.adult_member_no
						     from juvenile j
							 where j.member_no = m.member_no)),
	   (select a.state
	   from adult a
		where a.member_no = (select j.adult_member_no
						     from juvenile j
							 where j.member_no = m.member_no)),
	   (select a.zip
	    from adult a
		where a.member_no = (select j.adult_member_no
						     from juvenile j
							 where j.member_no = m.member_no)),
	   (select count(distinct l.isbn)
	    from loan l
		where l.member_no = m.member_no) + 
	   (select count(distinct lh.isbn)
	    from loanhist lh
		where lh.member_no = m.member_no) as 'no of borrowed books'
from member m
where m.member_no in (select j.member_no
					  from juvenile j)

--Wyswietl numery zamówien, których cena dostawy byla wieksza niz srednia cena za przesylke w tym roku
use northwind

select o.orderid,
	   o.freight, 
	   (select avg(o2.freight)
		from orders o2
		where year(o2.orderdate) = year(o.orderdate)) as 'avg freight'
from orders o
where o.freight > (select avg(o2.freight)
				   from orders o2
				   where year(o2.orderdate) = year(o.orderdate))

--Wyswietl ile każdy z przewoźników miał dostac wynagrodzenia w poszczególnych latach i miesiacach.
select s.shipperid,
	   s.companyname,
	   year(o.orderdate) as 'year',
	   month(o.orderdate) as 'month',
	   sum(o.freight)
from orders o
join shippers s on o.shipvia = s.shipperid
group by s.shipperid, s.companyname, year(o.orderdate), month(o.orderdate)

--Wypisz te produkty które kupilo conajmniej 2 klientów
select p.productid, p.productname, count(distinct o.customerid) as 'no of customers that bought that product'
from products p
join [order details] od on p.productid = od.productid
join orders o on od.orderid = o.orderid
group by p.productid, p.productname
having count(distinct o.customerid) >= 2

--Wypisac czytelników, ktorzy nie przeczytali zadnej ksiazki w 1996 roku
use library
select m.member_no,
	   m.firstname,
	   m.lastname
from member m
join adult a on m.member_no = a.member_no
left join loan l on m.member_no = l.member_no
left join loanhist lh on m.member_no = lh.member_no
where l.member_no is null and lh.member_no is null
union
select m.member_no,
	   m.firstname,
	   m.lastname
from member m
join juvenile j on m.member_no = j.member_no
left join loan l on m.member_no = l.member_no
left join loanhist lh on m.member_no = lh.member_no
where l.member_no is null and lh.member_no is null
order by 1

--Wypisac nazwy przewoznikow wraz z kwota jaka zarobili na przesylkach z rozbiciem na lata, miesiace
use northwind
select s.shipperid,
	   s.companyname,
	   year(o.orderdate) as 'year',
	   month(o.orderdate) as 'monnth',
	   sum(o.freight)
from shippers s
join orders o on s.shipperid = o.shipvia
group by s.shipperid, s.companyname, year(o.orderdate), month(o.orderdate)

-- Wypisac pozycje zamówienia, których cena z rabatem jest mniejsza od sredniej ceny z wszystkich pozycji zamówienia 
--(z podzapytaniem i bez).
select od.orderid,
	   od.productid,
	   od.unitprice,
	   od.quantity,
	   od.quantity * od.unitprice * (1 - od.discount) as 'price with discount',
	   (select avg(od2.quantity * od2.unitprice * (1 - od2.discount))
		from [order details] od2
		where od2.orderid = od.orderid) as 'avg unitprice of bought products'
from [order details] od
where od.quantity * od.unitprice * (1 - od.discount) < (select avg(od2.quantity * od2.unitprice * (1 - od2.discount))
														 from [order details] od2
														 where od2.orderid = od.orderid)

--Wypisac ceny produktów, których cena jednostkowa jest nie mniejsza od sredniej ceny produktów tej samej kategorii 
--(z podzapytaniem i bez).
select p.productid,
	   p.productname,
	   p.unitprice,
	   p.categoryid,
	   (select avg(p2.unitprice)
	    from products p2
		where p2.categoryid in (select ca.categoryid
								from categories ca
								where ca.categoryid = p.categoryid)
	   )
from products p
where p.unitprice >= (select avg(p2.unitprice)
					  from products p2
					  where p2.categoryid in (select ca.categoryid
										      from categories ca
										      where ca.categoryid = p.categoryid)
					  )
--
select p.productid,
	   p.productname,
	   p.unitprice,
	   p.categoryid,
	   avg(p2.unitprice)
from products p
join categories ca on p.categoryid = ca.categoryid
join products p2 on ca.categoryid = p2.categoryid
group by p.productid, p.productname, p.unitprice, p.categoryid
having p.unitprice >= avg(p2.unitprice)

--Wypisac imie i nazwisko pracownika, który obsluzyl lacznie zamówienia o najwiekszej wartosci w 1997.
select top 1 e.employeeid,
	   e.firstname,
	   e.lastname,
	   sum(od.quantity * od.unitprice * (1 - od.discount))
from employees e
join orders o on e.employeeid = o.employeeid and year(o.orderdate) = 1997
join [order details] od on o.orderid = od.orderid
group by e.employeeid, e.firstname, e.lastname
order by 4 desc

--Wypisac te zamownienia, które maja cene przesylki wyesza niz avg cen przesylke w danym roku
select o.orderid,
	   o.freight,
	   year(o.orderdate),
	   (select avg(o2.freight)
		from orders o2
		where year(o2.orderdate) = year(o.orderdate))
from orders o
where o.freight > (select avg(o2.freight)
				   from orders o2
				   where year(o2.orderdate) = year(o.orderdate))

--Wypisac czytelników, ktorzy nie przeczytali zadnej ksiazki w 1996 roku  (+ dane adresowe)
use library
select m.member_no,
	   m.firstname,
	   m.lastname,
	   a.street,
	   a.city,
	   a.state,
	   a.zip
from member m
join adult a on m.member_no = a.member_no
left join loan l on m.member_no = l.member_no and year(l.out_date) = 1996
left join loanhist lh on m.member_no = lh.member_no and year(l.out_date) = 1996
where l.member_no is null and lh.member_no is null
union
select m.member_no,
	   m.firstname,
	   m.lastname,
	   a.street,
	   a.city,
	   a.state,
	   a.zip
from member m
join juvenile j on m.member_no = j.member_no
join adult a on j.adult_member_no = a.member_no
left join loan l on m.member_no = l.member_no and year(l.out_date) = 1996
left join loanhist lh on m.member_no = lh.member_no and year(l.out_date) = 1996
where l.member_no is null and lh.member_no is null
order by 1
--
select m.member_no,
	   m.firstname,
	   m.lastname,
	   (select a.street
	    from adult a
		where a.member_no = m.member_no),
	   (select a.city
	    from adult a
		where a.member_no = m.member_no),
	   (select a.state
	    from adult a
		where a.member_no = m.member_no),
	   (select a.zip
	    from adult a
		where a.member_no = m.member_no),
		'adult'
from member m
where m.member_no in (select a.member_no
					  from adult a) and m.member_no not in (select l.member_no
															from loan l
														    where year(out_date) = 1996) and m.member_no not in (select lh.member_no
																											     from loanhist lh
																											     where year(out_date) = 1996)
union
select m.member_no,
	   m.firstname,
	   m.lastname,
	   (select a.street
	    from adult a
		where a.member_no = (select j.adult_member_no
							 from juvenile j
							 where j.member_no = m.member_no)),
	   (select a.city
	    from adult a
		where a.member_no = (select j.adult_member_no
							 from juvenile j
							 where j.member_no = m.member_no)),
	   (select a.state
	    from adult a
		where a.member_no = (select j.adult_member_no
							 from juvenile j
							 where j.member_no = m.member_no)),
	   (select a.zip
	    from adult a
		where a.member_no = (select j.adult_member_no
							 from juvenile j
							 where j.member_no = m.member_no)),
		'child'
from member m
where m.member_no in (select j.member_no
					  from juvenile j) and m.member_no not in (select l.member_no
															   from loan l
														       where year(out_date) = 1996) and m.member_no not in (select lh.member_no
																											        from loanhist lh
																											        where year(out_date) = 1996)
order by 1

--Wypisac nazwy przewoznikow wraz z kwota jaka zarobili na przesylkach z rozbiciem na lata, miesiace
use northwind
select s.shipperid,
	   s.companyname,
	   year(o.shippeddate),
	   month(o.shippeddate),
	   sum(o.freight)
from shippers s
join orders o on s.shipperid = o.shipvia
group by s.shipperid, s.companyname, year(o.shippeddate), month(o.shippeddate)

--Wypisac klientow wraz z wartoscia zamowien z uwzglednieniem przesylki.
select c.customerid,
	   c.companyname,
	   o.orderid,
	   sum(od.quantity * od.unitprice * (1 - od.discount)) + sum(o.freight)
from customers c
join orders o on c.customerid = o.customerid
join [order details] od on o.orderid = od.orderid
group by c.customerid, c.companyname, o.orderid
order by 1
--bez rozbicia na konkretne zamowienia
select c.customerid,
	   c.companyname,
	   sum(od.quantity * od.unitprice * (1 - od.discount)) + sum(o.freight)
from customers c
join orders o on c.customerid = o.customerid
join [order details] od on o.orderid = od.orderid
group by c.customerid, c.companyname
order by 1

--Wybierz nazwy i numery telefonów klientów, którzy nie kupili zadnego produktu z kategorii ‘Confections’. 
--Rozwiazac uzywajac mechanizmu podzapytan.
select c.customerid,
	   c.companyname,
	   c.phone
from customers c
where c.customerid not in (select o.customerid
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

select c.customerid,
	   c.companyname,
	   c.phone
from customers c
where not exists (select *
				  from orders o
				  where o.customerid = c.customerid and exists (select *
																from [order details] od
																where od.orderid = o.orderid and exists (select * 
																										 from products p
																										 where p.productid = od.productid and exists (select *
																																					  from categories ca
																																					  where ca.categoryid = p.categoryid and ca.categoryname like 'confections')
																										)
																)
				 )


--Dla kazdego produktu podaj jego nazwe kategorii, nazwe produktu, cene, 
--srednia cene wszystkich produktów danej kategorii oraz 
--róznice miedzy cena produktu a srednia cena wszystkich produktów danej kategorii.
select p.productid,
	   p.productname,
	   ca.categoryname,
	   p.unitprice,
	   (select avg(p.unitprice)
	    from products p
		where p.categoryid = ca.categoryid) as 'avg price of product from this category',
	   abs(p.unitprice - (select avg(p.unitprice)
						 from products p
						 where p.categoryid = ca.categoryid)) as 'price difference'
from products p
join categories ca on p.categoryid = ca.categoryid


--Dla kazdego pracownika wypisz ilosc zamówien, jakie obsluzyl w 1997 roku, 
--podaj takze date ostatniego obslugiwanego przez niego zamówienia (w 1997 r.).
--Interesuja nas pracownicy, którzy obsluzyli wiecej niz szesc zamówien.
select e.employeeid,
	   e.firstname,
	   e.lastname,
	   (select count(*)
	    from orders o
		where o.employeeid = e.employeeid and year(o.orderdate) = 1997) as 'orders processed in 1997',
	   (select top 1 o.orderdate
	    from orders o
		where o.employeeid = e.employeeid and year(o.orderdate) = 1997
		order by o.orderdate desc) as 'date of the last processed order in 1997'
from employees e
where (select count(*)
	    from orders o
		where o.employeeid = e.employeeid and year(o.orderdate) = 1997) > 6

--Dla kazdego klienta najczesciej zamiawiana kategorie w dwoch wersjach
select  c.customerid,
		c.companyname,
	   (select top 1 ca.categoryname
	    from categories ca
		where ca.categoryid in (select p.categoryid
							    from products p
							    where p.productid in (select od.productid
													  from [order details] od
													  where od.orderid in (select o.orderid
																	       from orders o
																		   where o.customerid = c.customerid)
													 )
							   )
		group by ca.categoryname
		order by count(*) desc)
from customers c
--
select c.customerid,
	   c.companyname,
	   (select top 1 ca.categoryname
	    from categories ca
		join products p on ca.categoryid = p.categoryid
		join [order details] od on p.productid = od.productid
		join orders o on od.orderid = o.orderid and o.customerid = c.customerid
		group by ca.categoryname
		order by count(*) desc)
from customers c

--Dla kazdego czytelnika imie, nazwisko, suma ksiazek wypozyczonych przez ta osobe i jej dzieci, ktory zyje w Arizonie i
--ma wiecej niz 2 dzieci lub kto zyje w kalifornii ma wiecej niz 3 dzieci
use library
select m.member_no,
       m.firstname,
	   m.lastname,
	   (select a.state
	    from adult a
		where a.member_no = m.member_no) as 'state',
	   (select count(*)
	    from juvenile j
		where j.adult_member_no = m.member_no) as 'no of children',
	   (select count(*)
	    from loan l
		where l.member_no = m.member_no) +
	   (select count(*)
	    from loanhist lh
		where lh.member_no = m.member_no) +
	   (select count(*)
	    from loan l
		where l.member_no in (select j.member_no
						      from juvenile j
							  where j.adult_member_no = m.member_no)) +
	   (select count(*)
	    from loanhist lh
		where lh.member_no in (select j.member_no
						       from juvenile j
							   where j.adult_member_no = m.member_no)) as 'no of loaned books',
	   'adult' as 'adult/child'
from member m
where ((select count(*)
	   from juvenile j
	   where j.adult_member_no = m.member_no) > 2 and (select a.state
													   from adult a
													   where a.member_no = m.member_no) like 'az') or 
	  ((select count(*)
	   from juvenile j
	   where j.adult_member_no = m.member_no) > 3 and (select a.state
													   from adult a
													   where a.member_no = m.member_no) like 'ca') or
	   (((select a.state
		  from adult a
		  where a.member_no = m.member_no) not like 'ca') and ((select a.state
															    from adult a
															    where a.member_no = m.member_no) not like 'az'))
union
select m.member_no,
       m.firstname,
	   m.lastname,
	   (select a.state
	    from adult a
		where a.member_no = (select j.adult_member_no
							 from juvenile j
							 where j.member_no = m.member_no)) as 'state',
	   0 as 'no of children',
	   (select count(*)
	    from loan l
		where l.member_no = m.member_no) +
	   (select count(*)
	    from loanhist lh
		where lh.member_no = m.member_no) as 'no of loaned books',
	   'child' as 'adult.child'
from member m
where m.member_no in (select j.member_no
					  from juvenile j)
order by 1

--Nazwy dostawcow (um, spedytorow?) ktorzy dostarczyli produkty w dniu 23/05/1997 oraz jesli obslugiwali te zamowienia
--pracownicy, ktorzy nie maja podwlanych, to ich wypisz (imie i nazwisko)
use northwind
select s.shipperid, s.companyname, e.firstname, e.lastname
from shippers s
join orders o on s.shipperid = o.shipvia and o.orderdate = '1997-05-23'
left join employees e on o.employeeid = e.employeeid and e.employeeid not in (select distinct e2.reportsto
																			  from employees e2)

--Dla kazdego pracownika wypisz wartosc(i?) zamowien obsluzonych przez niego w 1997, dodatkowo wypisz wartosci zamowien
--dla poszczegolnych klientow i dla poszczegolnych zamowien

select e.employeeid, e.firstname, e.lastname, c.companyname, o.orderid, sum(od.quantiry * od.unitprice * (1 - od.discount)) + o.freight as 'order value'
from employees e
left join orders o on e.employeeid = o.employeeid and year(o.orderdate) = 1997
left join [order details] od on o.orderid = od.orderid
group by e.employeeid, e.firstname, e.lastname, c.companyname, o.orderid, o.freight

--Dla kazdego dostawcy wyswietl sumaryczna wartosc wykonanych zamowien w okresie 1996-1998. Podziel ta
--informacje na lata i miesiace. Wyswietl tylko tych, ktorych sumaryczna wartosc wykonanych zamowien jest wieksza od
--sredniej wartosci wykonanych zamowien w danym okresie.
select s.shipperid, s.companyname, year(o.orderdate), month(o.orderdate), sum(od.quantity * od.unitprice * (1 - od.discount))
from shippers s
join orders o on s.shipperid = o.shipvia and year(o.orderdate) >= 1996 and year(o.orderdate) <=1998
join [order details] od on o.orderid = od.orderid
group by s.shipperid, s.companyname, year(o.orderdate), month(o.orderdate)
having sum(od.quantity * od.unitprice * (1 - od.discount)) > (select avg(od2.quantity * od2.unitprice * (1 - od2.discount))
															  from [order details] od2
															  where year(o2.orderdate) = year(o.orderdate) and month(o2.orderdate) = month(o.orderdate)

