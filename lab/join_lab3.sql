use joindb

--bez aliasu nazwy tabel
select buyer_name, sales.buyer_id, qty
from buyers, sales
where buyers.buyer_id = sales.buyer_id

--z aliasem nazwy tabel
select buyer_name, s.buyer_id, qty
from buyers as b, sales as s
where b.buyer_id = s.buyer_id

--przyklad 1 -> join
select buyer_name, sales.buyer_id, qty
from buyers inner join sales
on buyers.buyer_id = sales.buyer_id

--przyklad 2 -> join
select buyer_name, s.buyer_id, qty
from buyers as b inner join sales as s
on b.buyer_id = s.buyer_id

--iloczyn kartezjanski
select b.buyer_name as [b.buyer_name],
	   b.buyer_id as [b.buyer_id],
	   s.buyer_id as [s.buyer_id],
	   qty as [s.qty]
from buyers as b, sales as s
where b.buyer_name like 'adam barr'

select b.buyer_name as [b.buyer_name],
	   b.buyer_id as [b.buyer_id],
	   s.buyer_id as [s.buyer_id],
	   qty as [s.qty]
from buyers as b, sales as s
where s.buyer_id = b.buyer_id

--inner join
select buyer_name, sales.buyer_id, qty
from buyers inner join sales
on buyers.buyer_id = sales.buyer_id

--polecenie zwracajace nazwy produktow i firmy je dostarczajace
--produkty bez dostarczycieli i dostarczyciele
--bez produktow nie powinni pojawic sie w wyniku
use northwind
select productname, companyname
from products inner join suppliers
on products.supplierid = products.supplierid

--polecenie zwracajace nazwy klientow, ktorzy zlozyli zamowienia po 1 marca 1998
use northwind
select companyname, orderdate
from customers inner join orders
on customers.customerid = orders.customerid
where orderdate > '3/1/98'

--outer join
use joindb
select buyer_name, sales.buyer_id, qty
from buyers left outer join sales
on buyers.buyer_id = sales.buyer_id

--polecenie zwracajace wszystkich klientow z datami zamowien
use northwind
select companyname, orderdate
from customers left outer join orders
on customers.customerid = orders.customerid

--polecenie zwracajace liste dzieci bedacych czlonakmi biblioteki
--imie, nazwisko, data urodzenia
use library
select firstname, lastname, birth_date
from member left outer join juvenile
on member.member_no = juvenile.member_no

--polecenie zwracajace tytuly aktualnie wypozyczonych ksiazek
use library
select distinct title
from loan left outer join title
on title.title_no = loan.title_no

--polecenie zwracajace informacje o karach zaplaconych za przetrzymywanie ksiazki
--o tytule 'tao teh king'
--data oddania, ile dni byla przetrzymywana, zaplacona kara
use library
select in_date, datediff(day, due_date, in_date), fine_paid, fine_assessed, fine_waived
from loanhist inner join title
on loanhist.title_no = title.title_no
where title like 'tao teh king' and in_date > due_date

--polecenie zwracajace liste ksiazek(numery isbn)
--zarezaerwowanych przez osobe o nazwisku: Stephen a. Graff
use library
select isbn
from member inner join reservation
on member.member_no = reservation.member_no
where firstname like 'stephen' and middleinitial like 'a' and lastname like 'graff'

--polecenie zwracajace nazwy i ceny produktow o cenie
--jednostkowej pomiedzy 20 a 30, dla kazdego produktu podac dane adresowe dostawcy
use northwind
select productname, unitprice, address
from products inner join suppliers
on products.supplierid = suppliers.supplierid
where unitprice between 20 and 30

--polecenie zwracajace nazwy produktow oraz informacje o stanie magazynu dla produktow
--dostarczanych przez firme 'Tokyo Traders'
use northwind
select productname, unitsinstock
from products inner join suppliers
on products.supplierid = suppliers.supplierid
where companyname like 'tokyo traders'

--czy sa klienci ktorzy nie zlozyli zadnego zamowienia w 1997?
--jesli tak ro pokaz ich dane adresowe
use northwind
select companyname, address
from customers left outer join orders
on customers.customerid = orders.customerid and year(orderdate) = 1997
where orderdate is null

--wybierz nazwy i numery telefonow dostawcow,
--dostarczajacych produkty ktorych aktualne nie ma w magazynie
use northwind
select companyname, phone
from products left outer join suppliers
on products.supplierid = suppliers.supplierid
where unitsinstock = 0

--cross join - iloczyn kartezjanski
use joindb
select buyer_name, qty
from buyers cross join sales

--polecenie wyswietlajace cross join miedzy shippers i suppliers'
--listuje wszystkie mozliwe sposoby na ktore dostawcy moga dostarczac swoje produkty
use northwind
select suppliers.companyname, shippers.companyname
from suppliers cross join shippers

--laczenie wiecej niz dwoch tabel
use joindb
select buyer_name, prod_name, qty
from buyers inner join sales
on buyers.buyer_id = sales.buyer_id
inner join produce
on sales.buyer_id = produce.prod_id

--polecenie zwracajace liste produktow zamawianych w dniu 1996-07-08
use northwind
select orderdate, productname
from products inner join [order details]
on products.productid = [order details].productid
inner join orders
on [order details].orderid = orders.orderid
where orderdate = '7/8/96'

--wybierz nazwy produktow o cenie jednostkowej pomiedzy 20 a 30
--dla kazdego produktu podaj dane adresowe dostawcy
--interesuja nas tylko produkty z kategorii 'meat/poultry'
use northwind
select productname, categoryname, unitprice, address
from products inner join categories
on products.categoryid = categories.categoryid
inner join suppliers
on products.supplierid = suppliers.supplierid
where categoryname like 'meat/poultry' and unitprice between 20 and 30

--wybierz nazwy i ceny produktow z kategorii 'confections'
--dla kazdego produktu podaj nazwe dostawcy
use northwind
select productname, unitprice, companyname
from products inner join categories
on products.categoryid = categories.categoryid
inner join suppliers
on products.supplierid = suppliers.supplierid
where categoryname like 'confections'

--wybierz nazwy i numery telefonow klientow,
--ktorym w 1997 roku przesylki dostarczala firma 'united package'
use northwind
select customers.companyname, customers.phone
from customers inner join orders
on customers.customerid = orders.customerid
inner join shippers
on shipperid = shipvia
where year(shippeddate) = 1997 and shippers.companyname like 'united package'

--wybierz nazwy i numery telefonow klientow,
--ktorzy kupowali produkty z kategorii 'confections'
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

--polecenie, ktore wyswietla liste dzieci bedacych czlonkami biblioteki
--imie, nazwisko, data urodzenia, adres
use library
select member.member_no, firstname, lastname, birth_date, street, city, state, zip
from member left outer join adult
on member.member_no = adult.member_no
left outer join juvenile
on juvenile.member_no = member.member_no

--polecenie, ktore wyswielta lise dzieci bedacych czlonkami biblioteki
--imie nazwisko, data urodzenia, adres zamieszkania dziecka, imie i nazwisko rodzica
use library
select firstname, lastname, birth_date, street, city, state, zip, phone_no
from member left outer join adult
on member.member_no = adult.member_no
left outer join juvenile
on juvenile.member_no = member.member_no

--laczenie tabeli samej ze soba -> self join
use joindb
select a.buyer_id as buyer1, a.prod_id, b.buyer_id as buyer2
from sales as a inner join sales as b
on a.prod_id = b.prod_id
where a.buyer_id < b.buyer_id

--polecenie, ktore wyswietla liste wszystkich kupujacych te same produkty
use joindb
select a.buyer_id as buyer1, a.prod_id, b.buyer_id as buyer2
from sales as a inner join sales as b
on a.prod_id = b.prod_id

--poprzedni przyklad bez duplikatow
use joindb
select a.buyer_id as buyer1, a.prod_id, b.buyer_id as buyer2
from sales as a inner join sales as b
on a.prod_id = b.prod_id
where a.buyer_id < b.buyer_id

--polecenie, ktore pokazuje pary pracownikow zajmujacych to samo stanowisko
use northwind
select a.employeeid, a.lastname, a.title, b.employeeid, b.lastname, b.title
from employees as a inner join employees as b
on a.title = b.title
where a.employeeid < b.employeeid

--polecenie, ktore wyswietla pracownikow oraz ich podwladnych
use northwind 
select a.firstname as podwladny_imie, a.lastname as podwladny_nazwiskoa,
	   b.firstname as szef_imie, b.lastname as szef_nazwisko
from employees as a inner join employees as b
on a.reportsto = b.employeeid

--polecenie, ktore wyswietla pracownikow oraz ich podwladnych z podzapytaniem
use northwind 
select a.employeeid, (select lastname from employees where employeeid = a.reportsto) as 'boss', b.employeeid, b.lastname as 'subordinate'
from employees as a inner join employees as b
on a.employeeid = b.employeeid

--polecenie, ktore wyswitla pracownikow, ktorzy nie maja podwladnych
use northwind 
select a.firstname as podwladny_imie, a.lastname as podwladny_nazwiskoa,
	   b.firstname as szef_imie, b.lastname as szef_nazwisko
from employees as a right outer join employees as b
on a.reportsto = b.employeeid
where a.employeeid is null

--laczenie kilku zbiorow wynikowych
use northwind
select (firstname + ' ' + lastname) as name, city, postalcode, 'pracownik'
from employees
union
select companyname, city, postalcode, 'klient'
from customers

use northwind
select (firstname + ' ' + lastname) as name, city, postalcode, 'pracownik'
from employees
intersect --czesc wspolna
select companyname, city, postalcode, 'klient'
from customers

use northwind
select (firstname + ' ' + lastname) as name, city, postalcode, 'pracownik'
from employees
except --roznica
select companyname, city, postalcode, 'klient'
from customers

--polecenie, ktore zwraca czlonkow biblioteki mieszkajacych w arizonie, ktorzy maja wiecej
--niz 2 dzieci zapisanych do biblioteki
use library
select a.firstname, a.lastname, count(b.member_no)
from member as a inner join adult as c
on a.member_no = c.member_no
inner join juvenile as b
on b.adult_member_no = a.member_no
where c.state ='az'
group by a.member_no, a.firstname, a.lastname
having count(b.member_no) > 2
 
 --dla kazdej kategorii produktu(nazwa), podaj laczna liczbe zamowionych przez klienta jednostek
 use northwind
 select categoryname, sum(quantity)
 from categories inner join products
 on categories.categoryid = products.categoryid
 inner join [order details]
 on products.productid = [order details].productid
 group by categoryname

  --dla kazdej kategorii produktu(nazwa), podaj laczna liczbe zamowionych przez klienta jednostek, nazwe firmy
 use northwind
 select categoryname, sum(quantity), companyname
 from categories inner join products
 on categories.categoryid = products.categoryid
 inner join [order details]
 on products.productid = [order details].productid
 inner join orders
 on orders.orderid = [order details].orderid
 inner join customers
 on customers.customerid = orders.customerid
 group by categoryname, companyname
 order by 1, 3

 --dla kazdego zamowienia podaj laczna liczbe zamowionych jednostek oraz nazwe klienta
 use northwind
 select orders.orderid, customers.companyname, sum([order details].quantity) as [units ordered]
 from orders 
 inner join customers on orders.customerid = customers.customerid
 inner join [order details] on orders.orderid = [order details].orderid
 group by orders.orderid, customers.companyname
 order by orders.orderid

 --poprzedin przyklad, pokazane tylko zamowienia dla ktorych laczna liczba jednostek jest wieksza niz 250
 use northwind
 select orders.orderid, customers.companyname, sum([order details].quantity) as [units ordered]
 from orders 
 inner join customers on orders.customerid = customers.customerid
 inner join [order details] on orders.orderid = [order details].orderid
 group by orders.orderid, customers.companyname
 having sum([order details].quantity) > 250
 order by orders.orderid

 --dla kazdego klienta(nazwa) podaj wartosc poszczegolnych zamowien;
 --gdy klient nic nie zamowil tez powinna pojawic sie informacja
 use northwind
 select orders.orderid, companyname, sum(quantity * unitprice * (1 - discount))
 from orders
 inner join [order details] on [order details].orderid = orders.orderid
 right outer join customers on orders.customerid = customers.customerid
 group by orders.orderid, companyname
 order by 2, 1

 --podaj czytelnikow(imie i nazwisko), ktorzy nigdy nie pozyczyli zadnej ksiazki
 use library
 select firstname, lastname, loan.due_date, loanhist.due_date
 from member
 left outer join loan on member.member_no = loan.member_no
 left outer join loanhist on member.member_no = loanhist.member_no
 where loan.due_date is null and loanhist.due_date is null


