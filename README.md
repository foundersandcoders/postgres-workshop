# Postgres Workshop

This workshop is designed to build your confidence in querying data using SQL. We will work through some examples as a group before you tackle the challenges in pairs.

## Loading the dataset

We will be working with the dataset in the `data.sql` file [to be written!]. Please download the file and navigate in the Terminal to its location.

Confirm that you have Postgres installed and running on your computer.

In a separate terminal window or tab run the command `psql --file=data.sql`. This will connect to your Postgres and run all of the SQL in `data.sql`. This will set up our database for us.

## Syntax hints

Don't forget to use semicolons at the end of commands.

[Cover distinction between single- and double-quotes]

## The challenges

TODO - change SQL so that some tasks only require a single join. It's a bit much to jump straight into multiple joins but hard to think of relatively simple tasks with the way the tables are setup now.

### Introductory

These challenges cover the basics of SQL: selects, joins and conditions.

* Find the first name and surname of everyone.

* Sort everyone by surname and find the first three.

* Find everyone who is not in Nazareth.

* Find everyone who has a location specified.

* Find everyone with 'Wistle' in their surname (bonus points for case insensitivity).

* Find the first name and surname of the person who created Python.

* Find all the languages that Paul Jones created.

* Find all the languages that Paul Jones knows.

* Show a list of everyone and the client-side languages they know (one row per language).

### Intermediate

These slightly trickier challenges will require you to use [aggregate functions](https://www.tutorialspoint.com/postgresql/postgresql_useful_functions.htm) and/or [subqueries](http://www.postgresqltutorial.com/postgresql-subquery/)

* Find everyone who knows at least three languages.

* Find the most popular five languages as measured by the sum of the ratings.

* Find the language(s) with the lowest rating.

* Find all languages released after 1st Jan 1996, ordered by the number of people who know them.

* What's the most well-known server-side language? And client-side?

### Hard

Doing these is not required! Only look at these if you have time at the end.

* Show each person and their favourite language.

* Show the first name and surname of each person who has created a language along with the name of their most popular language. Try calculating popularity as the sum of the language's ratings and then using its average rating to see if they give different results.
