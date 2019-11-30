/*powtorka - kolos sql 2019*/


/*podstawy_cw_kocowe - lab1*/


--cawiczenie 1 - wybieranie danych
use library

--1. Napisz polecenie select, za pomoc? którego uzyskasz tytu? i numer ksi??ki
select title, title_no
from title

--2. Napisz polecenie, które wybiera tytu? o numerze 10
select title
from title
where title_no = 10

--3. Napisz polecenie, które wybiera numer czytelnika i kar? dla tych czytelników, którzy maj? kary mi?dzy $8 a $9
select member_no, fine_assessed
from loanhist
where fine_assessed between 8 and 9

--4. Napisz polecenie select, za pomoc? którego uzyskasz numer ksi??ki i autora dla wszystkich ksi??ek, których
--autorem jest Charles Dickens lub Jane Austen
select title_no, author
from title
where author like 'charles dickens' or author like 'jane austen'

--5. Napisz polecenie, które wybiera numer tytu?u i tytu? dla wszystkich rekordów zawieraj?cych string „adventures” gdzie? w tytule.
select title_no, title
from title
where title like '%adventures%'

--6. Napisz polecenie, które wybiera numer czytelnika, kar? oraz zap?acon? kar? dla wszystkich, którzy jeszcze nie zap?acili.
select member_no, fine_assessed, fine_paid
from loanhist
where isnull(fine_assessed, 0) > isnull(fine_paid, 0) + isnull(fine_waived, 0)

--7. Napisz polecenie, które wybiera wszystkie unikalne pary miast i stanów z tablicy adult.
select distinct city, state
from adult


--cwiczenie 2 - manipulowanie zbiorem wynikowym
use library

--1. Napisz polecenie, które wybiera wszystkie tytu?y z tablicy title i wy?wietla je w porz?dku alfabetycznym.
select title
from title
order by title

--2. Napisz polecenie, które:
--		-wybiera numer cz?onka biblioteki, isbn ksi??ki i warto??
--		 naliczonej kary dla wszystkich wypo?ycze?, dla których naliczono kar?
--		-stwórz kolumn? wyliczeniow? zawieraj?c? podwojon? warto?? kolumny fine_assessed
--		-stwórz alias ‘double fine’ dla tej kolumny
select member_no, isbn, fine_assessed, 2 * fine_assessed as 'double fine'
from loanhist
where isnull(fine_assessed, 0) > 0

--3. Napisz polecenie, które
--		-generuje pojedyncz? kolumn?, która zawiera kolumny: imi?
--		 cz?onka biblioteki, inicja? drugiego imienia i nazwisko dla
--		 wszystkich cz?onków biblioteki, którzy nazywaj? si? Anderson
--		-nazwij tak powsta?? kolumn? „email_name”
--		-zmodyfikuj polecenie, tak by zwróci?o „list? proponowanych
--		 loginów e-mail” utworzonych przez po??czenie imienia cz?onka
--		 biblioteki, z inicja?em drugiego imienia i pierwszymi dwoma
--		 literami nazwiska (wszystko ma?ymi literami).
--			-wykorzystaj funkcj? SUBSTRING do uzyskania cz??ci kolumny
--			 znakowej oraz LOWER do zwrócenia wyniku ma?ymi literami
--			-wykorzystaj operator (+) do po??czenia stringów
select lower(firstname + middleinitial + substring(lastname,1,2)) as 'email_name'
from member
where lastname like 'anderson'

--4. Napisz polecenie, które wybiera title i title_no z tablicy title.
--		-Wynikiem powinna by? pojedyncza kolumna o formacie jak w przyk?adzie poni?ej:
--			The title is: Poems, title number 7
--		-Czyli zapytanie powinno zwraca? pojedyncz? kolumn? w oparciu
--		 o wyra?enie, które ??czy 4 elementy:
--			sta?a znakowa ‘The title is:’
--			warto?? kolumny title
--			sta?a znakowa ‘title number’
--			warto?? kolumny title_no
select 'the title is: ' + title + ', ' + 'title number '  + convert(varchar, title_no)
from title


