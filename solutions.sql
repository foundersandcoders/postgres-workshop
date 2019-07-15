/* 1. Find the first name and surname of every author. */

SELECT first_name, surname FROM authors;

/* 2. Sort everyone by surname and find the first three */

SELECT * FROM authors ORDER BY surname LIMIT 3;

/* 3a. Find everyone who has a location specified */

SELECT * FROM authors WHERE location IS NOT NULL;

/* 3b. Find how many authors live in london and nazareth*/

SELECT COUNT(location), location FROM authors WHERE location IS NOT NULL GROUP BY location;

/* 4. Find everyone who is not in Nazareth (including nulls) */

SELECT * FROM authors
WHERE location <> 'Nazareth'
OR location IS NULL;

/* 5. Find everyone with 'Wistle' in their surname. */

SELECT * FROM authors WHERE surname LIKE '%Wistle%';

/* Case insensitive with Postgres-specific syntax */
SELECT * FROM authors WHERE surname ILIKE '%Wistle%';
/* Case insensitive with standard syntax */
SELECT * FROM authors WHERE LOWER(surname) LIKE LOWER('%Wistle%');

/* 6. Find the name of the publisher who released 'Python Made Easy'. */

SELECT publishers.name FROM publishers
INNER JOIN books
ON books.publisher_id = publishers.id
WHERE books.name = 'Python Made Easy';

/* 7. Find all the books published by 'No Starch Press'. */

SELECT publishers.name, books.name FROM publishers
INNER JOIN books
ON books.publisher_id = publishers.id
WHERE publishers.name = 'No Starch Press';

/* 8. Show a list of every book and their authors (one row per author). */

SELECT books.name, authors.first_name, authors.surname FROM books
INNER JOIN book_authors
ON book_authors.book_id = books.id
INNER JOIN authors
ON book_authors.author_id = authors.id
ORDER BY book_authors.book_id;

/* 9. Find all the books authored by Ted Burns. */

SELECT books.name FROM books
INNER JOIN book_authors
ON book_authors.book_id = books.id
INNER JOIN authors
ON book_authors.author_id = authors.id
WHERE authors.first_name = 'Ted'
AND authors.surname = 'Burns';

/* 10. Find everyone who wrote at least three books */

SELECT authors.first_name, authors.surname FROM authors
INNER JOIN book_authors
ON book_authors.author_id = authors.id
GROUP BY authors.id
HAVING COUNT(book_authors.author_id) > 2;

/* 11. Order the publishers by the number of books they have published. */

SELECT publishers.name, COUNT(books.publisher_id) FROM publishers
INNER JOIN books
ON books.publisher_id = publishers.id
GROUP BY publishers.name
ORDER BY COUNT(books.publisher_id) DESC;

/* 12. Find all languages released after 1st Jan 1996,
ordered by the number of people who wrote them. */

SELECT books.name, COUNT(book_authors.book_id) FROM books
INNER JOIN book_authors
ON books.id = book_authors.book_id
WHERE books.release_date > '01-Jan-96'
GROUP BY books.name
ORDER BY COUNT(book_authors.book_id) DESC;

/* 13.1 What's the highest number of authors per book? */

SELECT books.name, COUNT(book_authors.book_id) FROM books
INNER JOIN book_authors
ON books.id = book_authors.book_id
GROUP BY books.name
ORDER BY COUNT(book_authors.book_id) DESC LIMIT 1;

/* 13.2 What's the lowest number of authors per book? */

SELECT books.name, COUNT(book_authors.book_id) FROM books
INNER JOIN book_authors
ON books.id = book_authors.book_id
GROUP BY books.name
ORDER BY COUNT(book_authors.book_id) LIMIT 1;

/* 14. Who wrote the most books? How many did they write? */

SELECT authors.first_name, authors.surname, COUNT(book_authors.author_id) AS total FROM authors
INNER JOIN book_authors
ON authors.id = book_authors.author_id
GROUP BY authors.first_name, authors.surname
ORDER BY total DESC LIMIT 1;

-- I forgot to make a primary key for books_authors table. Alter the table to
-- create a new column to contain a primary key made up of 'book_id' and 'author_id'.

ALTER TABLE book_authors ADD book_author_id VARCHAR(20);
UPDATE book_authors SET book_author_id = (Cast(book_id AS VARCHAR(20)) || '-' || Cast(author_id AS VARCHAR(20)));
ALTER TABLE book_authors ADD PRIMARY KEY (book_author_id);


-- What's the average number of authors per book?

SELECT AVG(count)
FROM (SELECT book_authors.book_id, COUNT(book_authors.author_id)
FROM book_authors
GROUP BY book_authors.book_id) AS avg;

-- Show every author who has only written for one publisher.

SELECT authors.first_name, authors.surname, authors.id
FROM authors
INNER JOIN book_authors
ON authors.id = book_authors.author_id
INNER JOIN books
ON books.id = book_authors.book_id
INNER JOIN publishers
ON publishers.id = books.publisher_id
GROUP BY authors.first_name, authors.surname, authors.id
HAVING COUNT(DISTINCT books.publisher_id) = 1;


-- Which location has the higher figure for books per author?

SELECT location, AVG(books) FROM (SELECT authors.location, authors.first_name, authors.surname, COUNT(book_authors.book_id) AS books
FROM authors
INNER JOIN book_authors
ON authors.id = book_authors.author_id
GROUP BY authors.location, authors.first_name, authors.surname
ORDER BY authors.location) AS average
GROUP BY location
ORDER BY avg DESC;


-- Let's say you are the first developer at a new start up called 'Amazonia'.
-- Your boss asks you to modify the database so that customers can add books to their shopping carts.
-- What tables and associations would you need?
