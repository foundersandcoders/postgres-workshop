# Postgres Workshop

This workshop is designed to build your confidence in querying data using SQL. We will work through some examples as a group before you tackle the challenges in pairs.

## Set up

We will be working with the dataset in the `data.sql` file. This file contains a set of SQL commands that will create a set of tables and fill them with data. We will connect to the Postgres server running locally on our individual computers and tell it to run the file.

Postgres is made up of two elements: a server (postgresql) that processes requests and a client (psql) that generates them. Confirm that both programs are installed on your computer.

If you are using a Mac you can just download and run [this app](https://postgresapp.com/). It just works.

If you are using Ubuntu then it may be already installed on your computer. To check, run:

`which psql`

`which postgresql`

You should get the path to each program as output. If either of them doesn't show anything, run:

`sudo apt-get install postgresql-client postgresql postgresql-contrib`

## Loading the file

Please download the file and navigate in the Terminal to its location.

Make sure the Postgres server is running. On Mac using the app you'll see a little elephant in the menu bar. On Ubuntu, run:

`sudo service postgresql start`

Now run the command `psql --file=data.sql` in a new Terminal window/tab.

If it doesn't work try `psql -f data.sql`. If it still doesn't work then holler.

This will connect to your Postgres and run all of the SQL in `data.sql`, setting up our database for us.

## psql

We mentioned above that Postgres using a server-client model. Currently we're running both on the same machine but if we wanted to we could have the server bit running on a different computer and connect to it via the client. We will cover this soon.

Now that we're set up, we can connect to our newly-created database by running `psql`. If it gives an 'access denied' error, try `psql -U [your-user-name]`. Let's have a quick look at what we can do.

Slightly confusingly, `psql` has its own set of commands that are entirely different from SQL. You can identify them because they start with a backwards slash (\) and **don't** end in a semicolon.

Once you are in `psql` try some of the following commands:

`\d` - list all tables (know as 'relations' in psql)

`\d languages` - give information on a table (change 'languages' to the name of the table you're interested in)

`\l` - list all databases

## Syntax hints

Before we jump into the challenges, here are a few syntax points to be aware of:

Don't forget to use semicolons at the end of SQL commands. If you hit enter and you just get empty lines this is probably what you're missing.

In Postgres words in double quotes mean identifiers like the names of tables and columns. Single quotes are used for values. If you do something like:

`SELECT * FROM people WHERE first_name = "Sharon"`

You'll get an error because Postgres thinks "Sharon" is the name of a column. Use single quotes so that Postgres knows it's a value. You can optionally put double quotes around `people` and `first_name`, but single quotes won't work (because they are the names of identifiers within our database).

Note that a single equals is used for equality testing, not assignment.

SQL keywords like `SELECT`, `WHERE` etc can be in upper or lower case. The convention is upper case to distinguish them from identifiers and values but Postgres will understand either way.

SQL is pretty flexible with whitespace so you can spread your statements out on to as many lines as you want. Keeping things aligned can help make big statements easier to read. Just remember to end with a semicolon!

## The challenges

We will work through a couple of challenges as a group before you split into pairs and work through the others. Once everyone's done the introductory ones we will do a couple of harder ones together before working in pairs again.

Please don't feel that you have to get through all of them or be able to answer them all right away! The idea is to introduce you to the kind of queries we do regularly with SQL.

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
