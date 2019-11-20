use northwind

/*cwiczenie 1*/
select orderid, sum(unitprice * quantity * (1 - discount)) as 'total sum'
from [order details]
group by orderid
order by 2 desc

select top 10 orderid, sum(unitprice * quantity * (1 - discount)) as 'total sum'
from [order details]
group by orderid
order by 2 desc

select top 10 with ties orderid, sum(unitprice * quantity * (1 - discount)) as 'total sum'
from [order details]
group by orderid
order by 2 desc

/*cwiczenie 2*/
select productid, sum(quantity) as 'product quantity'
from [order details]
where productid < 3
group by productid

select productid, sum(quantity) as 'product quantity'
from [order details]
group by productid

select orderid, sum(unitprice * quantity * (1 - discount)) as 'order value'
from [order details]
group by orderid
having sum(quantity) > 250

/*cwiczenie 3*/
select orderid, productid, sum(quantity)
from [order details]
group by orderid, productid
with rollup
order by orderid, productid

select orderid, productid, sum(quantity)
from [order details]
where productid = 50
group by orderid, productid
with rollup
order by productid, orderid

--znaczenie wartosci null w kolumnie productid i orderid:
--null w productid - ilosc zamowionych produktow w danym zamowieniu
--null w orderid - ilosc danego produktu we wszystkich zamowieniach
--null w obu - suma zamowionych produktow we wszystkich zamowieniach

select orderid, grouping(orderid), productid, grouping(productid), sum(quantity)
from [order details]
group by orderid, productid
with cube
order by orderid, productid

--podsumowania:
--podsumowaniem sa wiersze z nullem/nullami
--podsumowaniem sa wiersze z 1 w komorce grouping
--podsumowanie wg produktu: null w orderid
--podsumowanie wg zamowienia: null w productid
