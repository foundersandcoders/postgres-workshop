/* Find the first name and surname of everyone. */

SELECT first_name, surname FROM people;

/* Sort everyone by surname and find the first three */

SELECT first_name, surname FROM people ORDER BY surname LIMIT 3;

/* Find everyone who is not in Nazareth */

SELECT * FROM people
WHERE location <> 'Nazareth';

/* Find everyone who has a location specified */

SELECT * FROM people WHERE location IS NOT NULL;

/* Find everyone with 'Wistle' in their surname. */

SELECT * FROM people WHERE surname LIKE '%Wistle%';

/* Case insensitive with Postgres-specific syntax */
SELECT * FROM people WHERE surname ILIKE '%Wistle%';
/* Case insensitive with standard syntax */
SELECT * FROM people WHERE LOWER(surname) LIKE LOWER('%Wistle%');

/* Find all the languages that Paul Jones knows. */

SELECT languages.name FROM languages
INNER JOIN knows
ON knows.language_id = languages.id
INNER JOIN people
ON knows.person_id = people.id
WHERE people.first_name = 'Paul' AND people.surname = 'Jones';

/* Show a list of everyone and the client-side languages they know (one row per language). */

SELECT people.first_name, people.surname, languages.name FROM languages
INNER JOIN knows
ON knows.language_id = languages.id
INNER JOIN people
ON knows.person_id = people.id
WHERE languages.environment = 'client';

/* Find everyone who knows at least three languages */

SELECT people.first_name, people.surname FROM people
INNER JOIN knows
ON knows.person_id = people.id
GROUP BY people.id
HAVING COUNT(knows.person_id) > 2;

/* Find the most popular five languages as measured by the sum of the ratings. */

SELECT languages.name, SUM(knows.rating) FROM languages
INNER JOIN knows
ON knows.language_id = languages.id
GROUP BY languages.name
ORDER BY SUM(knows.rating) DESC LIMIT 5;

/* Find the language(s) with the lowest rating */

SELECT languages.name, knows.rating FROM languages
INNER JOIN knows
ON knows.language_id = languages.id
WHERE knows.rating = (SELECT MIN(rating) FROM knows);

/* Find all languages released after 1st Jan 1996,
ordered by the number of people who know them. */

SELECT languages.name, COUNT(knows.language_id) FROM languages
INNER JOIN knows
ON knows.language_id = languages.id
WHERE languages.release_date > '01-Jan-96'
GROUP BY languages.name
ORDER BY COUNT(knows.language_id) DESC;

/* What's the most well-known server-side language? */

SELECT languages.name, COUNT(knows.language_id) FROM languages
INNER JOIN knows
ON knows.language_id = languages.id
WHERE languages.environment = 'server'
GROUP BY languages.name
ORDER BY COUNT(knows.language_id) DESC LIMIT 1;

/* What's the most well-known client-side language? */

SELECT languages.name, COUNT(knows.language_id) FROM languages
INNER JOIN knows
ON knows.language_id = languages.id
WHERE languages.environment = 'client'
GROUP BY languages.name
ORDER BY COUNT(knows.language_id) DESC LIMIT 1;
