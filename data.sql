BEGIN;

DROP TABLE IF EXISTS people, languages, knows CASCADE;
DROP TYPE IF EXISTS environment;

CREATE TABLE people (
  id            serial        PRIMARY KEY,
  first_name    varchar(100)  NOT NULL,
  surname       varchar(100)  NOT NULL,
  location      varchar(100)
);

CREATE TYPE environment AS ENUM ('client', 'server', 'full-stack');

CREATE TABLE languages (
  id           serial       PRIMARY KEY,
  name         varchar(100) NOT NULL,
  environment  environment  NOT NULL,
  release_date date         NOT NULL,
  created_by   integer	    REFERENCES people(id) ON UPDATE CASCADE
);

CREATE TABLE knows (
  person_id   integer REFERENCES people(id) ON UPDATE CASCADE,
  language_id integer REFERENCES languages(id) ON UPDATE CASCADE,
  rating      integer NOT NULL,
  CONSTRAINT  like_pk PRIMARY KEY (person_id, language_id)
);

INSERT INTO people(first_name, surname, location) VALUES
  ('Sharon', 'Smith', 'Nazareth'),
  ('Ted', 'Burns', 'London'),
  ('Stephen', 'Wistle', NULL),
  ('Amanda', 'Bertwistle', 'Nazareth'),
  ('David', 'Grewal', NULL),
  ('John', 'White', 'London'),
  ('Paul', 'Hallam-Wistle', 'London'),
  ('Paul', 'Jones', 'Nazareth')
RETURNING ID;

INSERT INTO languages(name, environment, release_date, created_by) VALUES
  ('Python', 'server', '26-Jan-94', 3),
  ('SQL', 'server', '01-Jun-79', 1),
  ('JavaScript', 'full-stack', '18-Sep-95', 5),
  ('Java', 'full-stack', '23-Jan-96', 8),
  ('Elm', 'client', '01-Apr-12', 8),
  ('CSS', 'client', '10-Oct-94', 8),
  ('Ruby', 'server', '25-Dec-96', 3),
  ('C++', 'server', '01-Oct-85', 1),
  ('CoffeeScript', 'client', '24-Dec-09', 2),
  ('Swift', 'full-stack', '02-Jun-14', 8)
RETURNING ID;

/* We are hard-coding ID values because we know the tables will be empty and can start from 1.
   Don't do this! In Real Life you would write a script to build up the relations instead. */
INSERT INTO knows(person_id, language_id, rating) VALUES
  (1, 9, 7),
  (1, 4, 9),
  (1, 10, 3),
  (1, 7, 2),
  (2, 1, 1),
  (2, 4, 8),
  (3, 8, 8),
  (3, 6, 4),
  (3, 5, 8),
  (3, 1, 2),
  (3, 2, 9),
  (4, 6, 7),
  (4, 3, 5),
  (5, 4, 9),
  (5, 10, 5),
  (5, 8, 6),
  (6, 8, 8),
  (6, 4, 5),
  (7, 3, 0),
  (7, 5, 1),
  (7, 4, 2),
  (7, 7, 7),
  (8, 1, 9),
  (8, 8, 5),
  (8, 9, 7),
  (8, 5, 5);

COMMIT;
