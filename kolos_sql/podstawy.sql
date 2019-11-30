/*powtorka - kolos sql 2019*/


/*podstawy - lab1*/


--wybor kolumn
use northwind

--1. Wybierz nazwy i adresy wszystkich klientów
select companyname, address
from customers

--2. Wybierz nazwiska i numery telefonów pracowników
select lastname, homephone
from employees

--3. Wybierz nazwy i ceny produktów
select productname, unitprice
from products

--4. Pokaż nazwy i opisy wszystkich kategorii produktów
select categoryname, description
from categories

--5. Pokaż nazwy i adresy stron www dostawców
select companyname, homepage
from suppliers


--wykorzystanie klauzuli where do wyboru okreslonych wierszy
use northwind

--1. Wybierz nazwy i adresy wszystkich klientów mających siedziby w Londynie
select companyname, address
from customers
where city like 'london'

--2. Wybierz nazwy i adresy wszystkich klientów mających siedziby we Francji lub w Hiszpanii
select companyname, address
from customers
where country like 'france' or country like 'spain'

--3. Wybierz nazwy i ceny produktów o cenie jednostkowej pomiędzy 20 a 30
select productname, unitprice
from products
where unitprice between 20 and 30

--4. Wybierz nazwy i ceny produktów z kategorii ‘meat’
select productname, unitprice
from products
where categoryid = (select categoryid from categories where categoryname like '%meat%') 

--5. Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów dostarczanych przez firmę ‘Tokyo Traders’
select productname, unitsinstock
from products
where supplierid = (select supplierid from suppliers where companyname like 'tokyo traders')

--6. Wybierz nazwy produktów których nie ma w magazyni
select productname
from products
where unitsinstock = 0


--porownywanie napisow
use northwind

--Szukamy informacji o produktach sprzedawanych w butelkach (‘bottle’)
select *
from products
where quantityperunit like '%bottle%'

--2. Wyszukaj informacje o stanowisku pracowników, których nazwiska zaczynają się na literę z zakresu od B do L
select lastname, reportsto
from employees
where lastname like '[bl]%'

--3. Wyszukaj informacje o stanowisku pracowników, których nazwiska zaczynają się na literę B lub L
select lastname, reportsto
from employees
where lastname like 'b%' or lastname like 'l%'

--4. Znajdź nazwy kategorii, które w opisie zawierają przecinek
select categoryname
from categories
where description like '%,%'

--5. Znajdź klientów, którzy w swojej nazwie mają w którymś miejscu słowo ‘Store’
select companyname
from customers
where companyname like '%store%'


--zakres wartosci
use northwind

--1. Szukamy informacji o produktach o cenach mniejszych niż 10 lub większych niż 20
select *
from products
where unitprice not between 10 and 20

--2. Wybierz nazwy i ceny produktów o cenie jednostkowej pomiędzy 20.00 a 30.00
select productname, unitprice
from products
where unitprice between 20 and 30


--warunki logiczne
use northwind

--1. Wybierz nazwy i kraje wszystkich klientów mających siedziby w Japonii (Japan) lub we Włoszech (Italy)
select companyname
from customers
where country like 'japan' or country like 'italy'


--wartosci NULL
use northwind

--1. Napisz instrukcję select tak aby wybrać numer zlecenia, datę zamówienia, numer klienta dla wszystkich
--niezrealizowanych jeszcze zleceń, dla których krajem odbiorcy jest Argentyna
select orderid, orderdate, customerid
from orders
where shippeddate is null and shipcountry like '%argentina%'


--sortowanie danych
use northwind

--1. Wybierz nazwy i kraje wszystkich klientów, wyniki posortuj
--według kraju, w ramach danego kraju nazwy firm posortuj alfabetycznie
select companyname, country
from customers
order by country, companyname 

--2. Wybierz informację o produktach (grupa, nazwa, cena),
--produkty posortuj wg grup a w grupach malejąco wg cen
select productname, categoryid, unitprice
from products
order by categoryid, unitprice desc

--3. Wybierz nazwy i kraje wszystkich klientów mających
--siedziby w Wielkiej Brytanii (UK) lub we Włoszech (Italy),
--wyniki posortuj tak jak w pkt 1
select companyname, country
from customers
where country like 'uk' or country like 'italy'
order by country, companyname








