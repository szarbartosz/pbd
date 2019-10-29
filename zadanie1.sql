use library

/*cwiczenie 1*/
select title, title_no
from title

select title
from title
where title_no = 10

select member_no, fine_assessed
from loanhist
where fine_assessed between 8 and 9

select title_no, author
from title
where author like 'charles dickens' or author like 'jane austen'

select title_no, title
from title
where title like '%adventures%'

select member_no, fine_assessed, fine_paid
from loanhist 
where isnull(fine_waived, 0) < fine_assessed - isnull(fine_paid,0)

select distinct city, state
from adult

/*cwiczenie2*/
select title
from title
order by title

select member_no, isbn, fine_assessed
from loanhist
where isnull(fine_assessed, 0) > 0

select fine_assessed, fine_assessed * 2 as double_fine
from loanhist
where isnull(fine_assessed, 0) > 0

select firstname + middleinitial + lastname as email_name
from member
where lastname like 'anderson'

select lower(firstname + middleinitial + substring(lastname, 1, 2) + '@2137.com')
from member

select 'The title is:' + title + ', ' + 'title number:' + cast(title_no as varchar)
from title

select 'The title is:' + title + ', ' + 'title number:' +  convert(varchar, title_no)
from title


