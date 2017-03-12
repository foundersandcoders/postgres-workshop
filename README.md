# Postgres Workshop

This workshop is designed to build your confidence in querying data using SQL. We will work through some examples as a group before you tackle the challenges in pairs.

## Loading the dataset

We will be working with the dataset in the `data.sql` file [to be written!]. Please download the file and navigate in the Terminal to its location.

Confirm that you have Postgres installed and running on your computer.

In a separate terminal window or tab run the command `psql --file=data.sql`. This will connect to your Postgres and run all of the SQL in `data.sql`. This will set up our database for us.

## The challenges

* Find all of the people.

* Find everyone who is not in Nazareth.

* Find everyone with 'Wistle' in their surname.

* Find everyone who knows at least three languages.

* Find the most popular five languages as measured by the sum of the ratings. Order them by name. Then make a separate query that orders by popularity.

* Find the language(s) with the lowest rating.

* Find all languages released after 1st Jan 1996, ordered by the number of people who know them.

* What's the most well-known server-side language? And client-side?

* Return a list of everyon with their most-liked language.