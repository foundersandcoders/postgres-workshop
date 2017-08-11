**Author**: [@tbtommyb](https://github.com/tbtommyb)  

**Maintainer**: TBC

# PostgreSQL Workshop

This workshop is designed to build your confidence in querying data using SQL.

## Set up

We will be working with the dataset in the `data.sql` file. This file contains a set of SQL commands that will create a set of tables and fill them with data. We will connect to the PostgreSQL server running locally on our individual computers and tell it to run the file.

Make sure that you have correctly installed PostgreSQL according to [these instructions](https://github.com/macintoshhelper/learn-sql/blob/master/postgresql/setup.md). Check that you can connect to your locally-running database by running `psql` from the command line.

If you run into problems, on a Mac using Homebrew, run `brew services restart postgresql` and try to connect again. On Ubuntu, run `sudo service postgresql restart` and try to connect again.

## Loading the file

Please download the file and navigate in the Terminal to its location.

Now run the command `psql --file=data.sql` in a new Terminal window/tab.

If it doesn't work try `psql -f data.sql`. If it still doesn't work then holler.

This will connect to your PostgreSQL server and run all of the SQL in `data.sql`, setting up our database for us.

## psql

We mentioned above that PostgreSQL using a server-client model. Currently we're running both on the same machine but if we wanted to we could have the server running on a different computer and connect to it via the client. We will cover this soon.

Now that we're set up, we can connect to our newly-created database by running `psql` (if it gives an 'access denied' error, try `psql -U [your-user-name]`).

Slightly confusingly, `psql` has its own set of commands that are entirely different from SQL. You can identify them because they start with a backwards slash (\) and **don't** end in a semicolon.

Once you are in `psql` try some of the following commands:

`\d` - list all tables (know as 'relations' in psql)

`\d [table name]` - give information on a given table

`\l` - list all databases

## Syntax hints

Before we jump into the challenges, here are a few syntax points to be aware of:

Don't forget to use semicolons at the end of SQL commands. If you hit enter and you just get empty lines this is probably what you're missing.

In PostgreSQL words in double quotes mean identifiers like the names of tables and columns. Single quotes are used for values. If you do something like:

`SELECT * FROM authors WHERE first_name = "Sharon"`

You'll get an error because PostgreSQL thinks "Sharon" is the name of a column. Use single quotes so that PostgreSQL knows it's a value. You can optionally put double quotes around `authors` and `first_name`, but single quotes won't work (because they are the names of identifiers within our database).

Note that a single equals is used for equality testing, not assignment.

SQL keywords like `SELECT`, `WHERE` etc can be in upper or lower case. The convention is upper case to distinguish them from identifiers and values but PostgreSQL will understand either way.

SQL is pretty flexible with whitespace so you can spread your statements out on to as many lines as you want. Keeping things aligned can help make big statements easier to read. Just remember to end with a semicolon!

## Schema diagrams

Here are the schema diagrams to help:

### Authors
Column | Type | Modifiers
--- | --- | ---
id | integer | not null default
first_name | character varying(100) | not null
surname | character varying(100) | not null
location | character varying(100) |

### Books

Column | Type | Modifiers
--- | --- | ---
id | integer | not null default
name | character varying(100) | not null
release_date | date | not null
publisher_id | integer | foreign key (publishers.id)

### Publishers

Column | Type | Modifiers
--- | --- | ---
id | integer | not null default
name | character varying(100) | not null

### Book Authors

Column | Type | Modifiers
--- | --- | ---
book_id | integer | foreign key (books.id)
author_id | integer | foreign key (authors.id)


## The challenges

Please don't feel that you have to get through all of them or be able to answer them all right away! The idea is to introduce you to the kind of queries we do regularly with SQL.

### Introductory

These challenges cover the basics of SQL: selects, joins and conditions.

#### Find the first name and surname of every author

##### Expected result

first_name |    surname
--- | ---
Sharon     | Smith
Ted        | Burns
Stephen    | Wistle
Amanda     | Bertwistle
David      | Grewal
John       | White
Paul       | Hallam-Wistle
Paul       | Jones

#### Sort everyone by surname and find the first three

##### Expected result

id | first_name |  surname   | location
--- | --- | --- | ---
4 | Amanda     | Bertwistle | Nazareth
2 | Ted        | Burns      | London
5 | David      | Grewal     |

#### Find everyone who has a location specified

##### Expected result

id | first_name |    surname    | location
--- | --- | --- | ---
1 | Sharon     | Smith         | Nazareth
2 | Ted        | Burns         | London
4 | Amanda     | Bertwistle    | Nazareth
6 | John       | White         | London
7 | Paul       | Hallam-Wistle | London
8 | Paul       | Jones         | Nazareth

#### Find everyone who is not in Nazareth (including nulls)

##### Expected result

id | first_name |    surname    | location
--- | --- | --- | ---
2 | Ted        | Burns         | London
3 | Stephen    | Wistle        |
5 | David      | Grewal        |
6 | John       | White         | London
7 | Paul       | Hallam-Wistle | London

#### Find everyone with 'Wistle' in their surname (bonus points for case insensitivity)

##### Expected result

id | first_name |    surname    | location
--- | --- | --- | ---
3 | Stephen    | Wistle        |
4 | Amanda     | Bertwistle    | Nazareth
7 | Paul       | Hallam-Wistle | London

#### Find the name of the publisher who released 'Python Made Easy'

##### Expected result

'No Starch Press'

#### Find all the books published by 'No Starch Press'

##### Expected result

name | name
--- | ---
No Starch Press | Python Made Easy
No Starch Press | JavaScript: The Really Good Parts

#### Show a list of every book and their authors
Note: Only one author per row, so the book's name may need to be repeated.

##### Expected result

name | first_name | surname
--- | --- | ---
Python Made Easy                  | Sharon     | Smith
Python Made Easy                  | David      | Grewal
Python Made Easy                  | Amanda     | Bertwistle
SQL: Part 2                       | Sharon     | Smith
JavaScript: The Really Good Parts | Stephen    | Wistle
JavaScript: The Really Good Parts | David      | Grewal
Java in Japanese                  | Paul       | Jones
Java in Japanese                  | Ted        | Burns
Java in Japanese                  | Stephen    | Wistle
Java in Japanese                  | David      | Grewal
Java in Japanese                  | Amanda     | Bertwistle
Elm Street                        | David      | Grewal
Elm Street                        | John       | White
Elm Street                        | Sharon     | Smith
CSS: Cansei                       | Amanda     | Bertwistle
CSS: Cansei                       | Paul       | Hallam-Wistle
Ruby Gems                         | Ted        | Burns
Ruby Gems                         | Paul       | Hallam-Wistle
C++                               | Paul       | Jones
C++                               | John       | White
C++                               | David      | Grewal
C++                               | Paul       | Jones
CoffeeScript in Java              | Paul       | Hallam-Wistle
CoffeeScript in Java              | Paul       | Hallam-Wistle
Swift in 10 Days                  | Stephen    | Wistle
Swift in 10 Days                  | David      | Grewal

#### Find all the books that Ted Burns authored

##### Expected result

'Java in Japanese' and 'Ruby Gems'

### Intermediate

These slightly trickier challenges will require you to use [aggregate functions](https://www.postgresql.org/docs/9.6/static/tutorial-agg.html) and/or [subqueries](https://www.tutorialspoint.com/postgresql/postgresql_sub_queries.htm).

#### Find everyone who wrote at least three books

##### Expected result

first_name |    surname
--- | ---
Paul       | Jones
Stephen    | Wistle
Amanda     | Bertwistle
Sharon     | Smith
David      | Grewal
Paul       | Hallam-Wistle

#### Order the publishers by the number of books they have published.

##### Expected result

name | count
--- | ---
McGraw-Hill              |     4
The Big Publishing House |     3
No Starch Press          |     2
Mega Corp Ltd            |     1

#### Find all books released after 1st Jan 1996, ordered by the number of people who wrote them.

##### Expected result

name | count
--- | ---
Java in Japanese     |     5
C++                  |     4
Elm Street           |     3
Ruby Gems            |     2
CoffeeScript in Java |     2
Swift in 10 Days     |     2

#### What's the highest number of authors per book? The lowest?

##### Expected results

Highest: 'Java in Japanese'.
Lowest: 'SQL: Part 2'

#### Who wrote the most books? How many did they write?

##### Expected result

David Grewal, 6

### Hard

Doing these is not required! Only look at these if you have time at the end.

* I forgot to make a primary key for books_authors table. Alter the table to create a new column to contain a primary key made up of 'book_id' and 'author_id'.

* What's the average number of authors per book?

* Show every author who has only written for one publisher.

* Which location has the higher figure for books per author?

* Let's say you are the first developer at a new start up called 'Amazonia'. Your boss asks you to modify the database so that customers can add books to their shopping carts. What tables and associations would you need?
