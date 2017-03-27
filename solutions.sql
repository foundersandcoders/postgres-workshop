/* Find the first name and surname of every author. */

SELECT first_name, surname FROM authors;

/* Sort everyone by surname and find the first three */

SELECT first_name, surname FROM authors ORDER BY surname LIMIT 3;

/* Find everyone who is not in Nazareth (including nulls) */

SELECT * FROM authors
WHERE location <> 'Nazareth'
OR location IS NULL;

/* Find everyone who has a location specified */

SELECT * FROM authors WHERE location IS NOT NULL;

/* Find everyone with 'Wistle' in their surname. */

SELECT * FROM authors WHERE surname LIKE '%Wistle%';

/* Case insensitive with Postgres-specific syntax */
SELECT * FROM authors WHERE surname ILIKE '%Wistle%';
/* Case insensitive with standard syntax */
SELECT * FROM authors WHERE LOWER(surname) LIKE LOWER('%Wistle%');

/* Find the name of the publisher who released 'Python Made Easy'. */

SELECT publishers.name FROM publishers
INNER JOIN books
ON books.publisher_id = publishers.id
WHERE books.name = 'Python Made Easy';

/* Find all the books published by 'No Starch Press'. */

SELECT publishers.name, books.name FROM publishers
INNER JOIN books
ON books.publisher_id = publishers.id
WHERE publishers.name = 'No Starch Press';

/*Show a list of every book and their authors (one row per author). */

SELECT books.name, authors.first_name, authors.surname FROM books
INNER JOIN book_authors
ON book_authors.book_id = books.id
INNER JOIN authors
ON book_authors.author_id = authors.id
ORDER BY book_authors.book_id;

/* Find all the books authored by Ted Burns. */

SELECT books.name FROM books
INNER JOIN book_authors
ON book_authors.book_id = books.id
INNER JOIN authors
ON book_authors.author_id = authors.id
WHERE authors.first_name = 'Ted'
AND authors.surname = 'Burns';

/* Find everyone who wrote at least three books */

SELECT authors.first_name, authors.surname FROM authors
INNER JOIN book_authors
ON book_authors.author_id = authors.id
GROUP BY authors.id
HAVING COUNT(book_authors.author_id) > 2;

/* Order the publishers by the number of books they have published. */

SELECT publishers.name, COUNT(books.publisher_id) FROM publishers
INNER JOIN books
ON books.publisher_id = publishers.id
GROUP BY publishers.name
ORDER BY COUNT(books.publisher_id) DESC;

/* Find all languages released after 1st Jan 1996,
ordered by the number of people who wrote them. */

SELECT books.name, COUNT(book_authors.book_id) FROM books
INNER JOIN book_authors
ON books.id = book_authors.book_id
WHERE books.release_date > '01-Jan-96'
GROUP BY books.name
ORDER BY COUNT(book_authors.book_id) DESC;

/* What's the highest number of authors per book? */

SELECT books.name, COUNT(book_authors.book_id) FROM books
INNER JOIN book_authors
ON books.id = book_authors.book_id
GROUP BY books.name
ORDER BY COUNT(book_authors.book_id) DESC LIMIT 1;

/* What's the lowest number of authors per book? */

SELECT books.name, COUNT(book_authors.book_id) FROM books
INNER JOIN book_authors
ON books.id = book_authors.book_id
GROUP BY books.name
ORDER BY COUNT(book_authors.book_id) LIMIT 1;

/* Who wrote the most books? How many did they write? */

SELECT authors.first_name, authors.surname, COUNT(book_authors.author_id) AS total FROM authors
INNER JOIN book_authors
ON authors.id = book_authors.author_id
GROUP BY authors.first_name, authors.surname
ORDER BY total DESC LIMIT 1;
