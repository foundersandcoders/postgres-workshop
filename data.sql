BEGIN;

DROP TABLE IF EXISTS people, languages, likes CASCADE;

CREATE TABLE people (
  id            serial        PRIMARY KEY,
  first_name    varchar(100)  NOT NULL,
  surname       varchar(100)  NOT NULL
);

CREATE TYPE context AS ENUM ('client', 'server', 'full-stack');

CREATE TABLE languages (
  id      serial       PRIMARY KEY,
  name    varchar(100) NOT NULL,
  context context      NOT NULL
);

CREATE TABLE likes (
  person_id   integer REFERENCES people(id) ON UPDATE CASCADE,
  language_id integer REFERENCES languages(id) ON UPDATE CASCADE,
  CONSTRAINT  like_pk PRIMARY KEY (person_id, language_id)
);

INSERT INTO people(first_name, surname) VALUES
  ('Shireen', 'Zoaby'),
  ('Tom', 'Barrett'),
  ('Steve', 'Hopkinson'),
  ('Emily', 'Bertwistle')
RETURNING ID;

INSERT INTO languages(name, context) VALUES
  ('Python', 'server'),
  ('SQL', 'server'),
  ('JavaScript', 'full-stack'),
  ('Java', 'server'),
  ('Elm', 'client'),
  ('CSS', 'client')
RETURNING ID;

INSERT INTO likes(person_id, language_id)
WITH
  person AS ( SELECT id FROM people WHERE people.first_name = 'Shireen' ),
  language AS ( SELECT id FROM languages WHERE languages.name = 'SQL')
SELECT person.id, language.id
FROM person, language;

INSERT INTO likes (
  SELECT
    people.id AS people_id,
    languages.id AS language_id
  FROM people
  JOIN (VALUES ('Tom', 'SQL')) vals ON people.first_name = vals.column1
  JOIN languages ON vals.column2 = languages.name
);

COMMIT;
