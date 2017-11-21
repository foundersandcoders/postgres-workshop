BEGIN;

DROP TABLE IF EXISTS authors, books, publishers, book_authors CASCADE;

CREATE TABLE authors (
  id            serial        PRIMARY KEY,
  first_name    varchar(100)  NOT NULL,
  surname       varchar(100)  NOT NULL,
  location      varchar(100)
);

CREATE TABLE publishers (
  id      serial       PRIMARY KEY,
  name    varchar(100) NOT NULL
);

CREATE TABLE books (
  id           serial       PRIMARY KEY,
  name         varchar(100) NOT NULL,
  release_date date         NOT NULL,
  publisher_id integer	    REFERENCES publishers(id) ON UPDATE CASCADE
);

CREATE TABLE book_authors (
  book_id   integer REFERENCES books(id) ON UPDATE CASCADE,
  author_id integer REFERENCES authors(id) ON UPDATE CASCADE
);

INSERT INTO authors(first_name, surname, location) VALUES
  ('Sharon', 'Smith', 'Nazareth'),
  ('Ted', 'Burns', 'London'),
  ('Stephen', 'Wistle', NULL),
  ('Amanda', 'Bertwistle', 'Nazareth'),
  ('David', 'Grewal', NULL),
  ('John', 'White', 'London'),
  ('Paul', 'Hallam-Wistle', 'London'),
  ('Paul', 'Jones', 'Nazareth')
RETURNING ID;

INSERT INTO publishers(name) VALUES
  ('The Big Publishing House'),
  ('McGraw-Hill'),
  ('No Starch Press'),
  ('Mega Corp Ltd')
RETURNING ID;

INSERT INTO books(name, release_date, publisher_id) VALUES
  ('Python Made Easy', '26-Jan-94', 3),
  ('SQL: Part 2', '01-Jun-79', 1),
  ('JavaScript: The Really Good Parts', '18-Sep-95', 3),
  ('Java in Japanese', '23-Jan-96', 2),
  ('Elm Street', '01-Apr-12', 4),
  ('CSS: Cansei', '10-Oct-94', 1),
  ('Ruby Gems', '25-Dec-96', 2),
  ('C++', '06-Jul-17', 1),
  ('CoffeeScript in Java', '24-Dec-09', 2),
  ('Swift in 10 Days', '02-Jun-14', 2)
RETURNING ID;

/* We are hard-coding ID values because we know the tables will be empty and can start from 1.
   Don't do this! In Real Life you would write a script to build up the relations instead. */
INSERT INTO book_authors(book_id, author_id) VALUES
  (9, 7),
  (4, 4),
  (10, 3),
  (7, 2),
  (1, 1),
  (4, 8),
  (8, 8),
  (6, 4),
  (5, 6),
  (1, 5),
  (2, 1),
  (6, 7),
  (3, 5),
  (4, 3),
  (10, 5),
  (8, 6),
  (8, 1),
  (4, 5),
  (3, 3),
  (5, 1),
  (4, 2),
  (7, 7),
  (1, 4),
  (8, 5),
  (9, 3),
  (5, 5);

COMMIT;
