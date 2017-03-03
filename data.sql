BEGIN;

DROP TABLE IF EXISTS people, languages, likes CASCADE;

DECLARE
  last_person_id   people.id%TYPE;
  last_language_id languages.id%TYPE;

CREATE TABLE people (
  id            serial        PRIMARY KEY,
  first_name    varchar(100)  NOT NULL,
  surname       varchar(100)  NOT NULL
);

CREATE TYPE context AS ENUM ('client', 'server', 'full-stack');

CREATE TABLE languages (
  id      serial       PRIMARY KEY,
  name    varchar(100) NOT NULL,
  context context      NOT NULL,
);

CREATE TABLE likes (
  person_id   integer REFERENCES people(id) ON UPDATE CASCADE,
  language_id integer REFERENCES language(id) ON UPDATE CASCADE,
  CONSTRAINT  like_pk PRIMARY KEY (person_id, language_id)
);

INSERT INTO people(first_name, surname) VALUES
  ('Shireen', 'Zoaby'),
  ('Tom', 'Barrett'),
  ('Steve', 'Hopkinson'),
  ('Emily', 'Bertwistle')
RETURNING ID INTO last_person_id;

INSERT INTO languages(name, context) VALUES
  ('Python', 'server'),
  ('SQL', 'server'),
  ('JavaScript', 'full-stack'),
  ('Java', 'server'),
  ('Elm', 'client'),
  ('CSS', 'client')
RETURNING ID INTO last_language_id;

COMMIT;
