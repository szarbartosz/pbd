/*powtorka - kolos sql 2019*/


/*podstawy_cw_kocowe - lab1*/


--cwiczenie 1 - wybieranie danych
use library

--1. Napisz polecenie select, za pomocą którego uzyskasz tytuł i numer książki
select title, title_no
from title

--2. Napisz polecenie, które wybiera tytuł o numerze 10
select title
from title
where title_no = 10

--3. Napisz polecenie, które wybiera numer czytelnika i karę dla tych czytelników, którzy mają kary między $8 a $9
select member_no, fine_assessed
from loanhist
where fine_assessed between 8 and 9

--4. Napisz polecenie select, za pomocą którego uzyskasz numer książki i autora dla wszystkich książek, których
--autorem jest Charles Dickens lub Jane Austen
select title_no, author
from title
where author like 'charles dickens' or author like 'jane austen'

--5. Napisz polecenie, które wybiera numer tytułu i tytuł dla wszystkich rekordów zawierających string „adventures” gdzieś w tytule.
select title_no, title
from title
where title like '%adventures%'

--6. Napisz polecenie, które wybiera numer czytelnika, karę oraz zapłaconą karę dla wszystkich, którzy jeszcze nie zapłacili.
select member_no, fine_assessed, fine_paid
from loanhist
where isnull(fine_assessed, 0) > isnull(fine_paid, 0) + isnull(fine_waived, 0)

--7. Napisz polecenie, które wybiera wszystkie unikalne pary miast i stanów z tablicy adult.
select distinct city, state
from adult


--cwiczenie 2 - manipulowanie zbiorem wynikowym
use library

--1. Napisz polecenie, które wybiera wszystkie tytuły z tablicy title i wyświetla je w porządku alfabetycznym.
select title
from title
order by title

--2. Napisz polecenie, które:
--		-wybiera numer członka biblioteki, isbn książki i wartość
--		 naliczonej kary dla wszystkich wypożyczeń, dla których naliczono karę
--    -stwórz kolumnę wyliczeniową zawierającą podwojoną wartość kolumny fine_assessed
--		-stwórz alias ‘double fine’ dla tej kolumny
select member_no, isbn, fine_assessed, 2 * fine_assessed as 'double fine'
from loanhist
where isnull(fine_assessed, 0) > 0

--3. Napisz polecenie, które
--		-generuje pojedynczą kolumnę, która zawiera kolumny: imię
--		 członka biblioteki, inicjał drugiego imienia i nazwisko dla
--		 wszystkich członków biblioteki, którzy nazywają się Anderson
--		-nazwij tak powstałą kolumnę „email_name”
--		-zmodyfikuj polecenie, tak by zwróciło „listę proponowanych
--		 loginów e-mail” utworzonych przez połączenie imienia członka
--		 biblioteki, z inicjałem drugiego imienia i pierwszymi dwoma
--		 literami nazwiska (wszystko małymi literami).
--			-wykorzystaj funkcję SUBSTRING do uzyskania części kolumny
--			 znakowej oraz LOWER do zwrócenia wyniku małymi literami
--			-wykorzystaj operator (+) do połączenia stringów
select lower(firstname + middleinitial + substring(lastname,1,2)) as 'email_name'
from member
where lastname like 'anderson'

--4. Napisz polecenie, które wybiera title i title_no z tablicy title.
--		-Wynikiem powinna być pojedyncza kolumna o formacie jak w przykładzie poniżej:
--			The title is: Poems, title number 7
--		-Czyli zapytanie powinno zwracać pojedynczą kolumnę w oparciu
--		 o wyrażenie, które łączy 4 elementy:
--			stała znakowa ‘The title is:’
--			wartość kolumny title
--			stała znakowa ‘title number’
--			wartość kolumny title_no
select 'the title is: ' + title + ', ' + 'title number '  + convert(varchar, title_no)
from title


