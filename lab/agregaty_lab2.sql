use northwind

select top 5 orderid, productid, quantity 
from [order details]
order by quantity desc

select top 5 with ties orderid, productid, quantity
from [order details]
order by quantity desc

select count(*)
from employees

select count(reportsto)
from employees

--srednia cena jednostkowa dla wszystkich produktów:
select avg(unitprice) as 'avg unitprice'
from products

--sumaryczna ilosc sprzedanych produktow
select sum(quantity)
from [order details]

--podaj liczbe produktow o cenach mniejszych
--niz 10 lub wiekszych niz 20
select count(*)
from products
where unitprice < 10 or unitprice > 20

--podaj maksymalna cene produktu dla produktów
--o cench ponizej 20
select top 1 unitprice
from products
where unitprice < 20
order by unitprice desc

--podaj max, min i avg cene produktów dla 
--produktów sprzedawanych w butelkach
select max(unitprice)
from products
where quantityperunit like '%bottle%'

select min(unitprice)
from products
where quantityperunit like '%bottle%'

select avg(unitprice)
from products
where quantityperunit like '%bottle%'

--wypisz informacje o wszystkich produktach
--o cenie powyzej sredniej
select *
from products
where unitprice > (select avg(unitprice) from products)

--podaj wartosc zamowienia o numerze 10250
select sum(unitprice * (1 - discount))
from [order details]
where orderid = 10250

--GROUP BY, GROUP BY HAVING

select productid, orderid, quantity
from orderhist

select productid, sum(quantity) as 'total quantity'
from orderhist
group by productid

select productid, sum(quantity) as 'total quantity'
from orderhist
where productid = 2
group by productid

select productid, sum(quantity) as 'total quantity'
from [order details]
group by productid

--podaj max cene zamawianego produktu dla kazdego zamowienia
--posortuj zamówienie wg max ceny produktu
select orderid, max(unitprice) as 'highest unitprice'
from [order details]
group by orderid
order by 'highest unitprice' desc

--podaj max i min cene zamawianego produktu
--dla kazdego zamowienia
select orderid, max(unitprice) as 'highest price', min(unitprice) as 'lowest unitprice'
from [order details]
group by orderid

--podaj liczbe zamówien dostarczanych przez poszczegolnych spedytorow
select shipvia, count(orderid)
from orders
group by shipvia

--który ze spedytorów byl najaktywniejszy w 1997?
select top 1 shipvia as 'id spedytora', count(*) as'liczba dostarczonych zamowien'
from orders
where year(shippeddate) = 1997
group by shipvia
order by 2 desc

select productid, orderid, quantity
from orderhist

select productid, sum(quantity) as total_quantity
from orderhist
group by productid
having sum(quantity) >= 30

--wyswietl liste identyfikatorow produktow i ilosc dla 
--tych produktow, ktorych zamowiono ponad 1200 jednostek
select productid, sum(quantity) as total_quantity
from [order details]
group by productid
having sum(quantity) > 1200

--wyswietl zamowienia dla ktorych liczba pozycji zamowienia > 5
select orderid, count(*)
from [order details]
group by orderid
having count(*) > 5

--wyswietl klientow, dla ktorych w 1998 roku zrealizowano wiecej
--niz 8 zamówien (wyniki posortuj malejaco wg lacznej kwoty za
--dostarczenie zamówien do kazdego z klientów
select customerid, count(*) as total_no_of_orders
from orders
where year(shippeddate) = 1998
group by customerid
having count(*) > 8
order by sum(freight) desc

select productid, orderid, sum(quantity) as total_quantity
from orderhist
group by productid, orderid
with rollup
order by productid, orderid

select orderid, productid, sum(quantity) as total_quantity
from [order details]
where orderid < 10250
group by orderid, productid
order by orderid, productid

select orderid, productid, sum(quantity) as total_quantity
from [order details]
where orderid < 10250
group by orderid, productid
with rollup
order by orderid, productid

select productid, orderid, sum(quantity) as total_quantity
from [order details]
where orderid < 10250
group by productid, orderid
with cube
order by orderid, productid


select orderid, grouping(orderid), 
productid, grouping(productid), sum(quantity) as total_quantity
from [order details]
where orderid < 10250
group by orderid, productid
with cube
order by orderid, productid

select productid, orderid, quantity
from orderhist
order by productid, orderid
compute sum(quantity) by productid
compute sum(quantity)








