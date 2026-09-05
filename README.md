SQL Data Anonymization

Project Overview

For this assignment, I created a Python program that takes an SQL file and replaces personal information with fake information. The SQL file contains names, addresses, email addresses, and phone numbers. My program replaces those values with synthetic data generated using the Faker library. One of the important parts of this assignment was making sure that repeated information stays consistent. For example, if the same customer name appears in both the customers and orders tables, it should be replaced with the same fake name in both places.

The program creates a new file called anonymized.sql instead of changing the original SQL file.
The main things the program does are:
* Replaces names
* Replaces addresses
* Replaces email addresses
* Replaces phone numbers
* Keeps repeated values consistent
* Keeps values consistent between tables
* Leaves non-sensitive information alone
* Creates a separate anonymized SQL file

Technologies Used

I used Python for this project. The main external library I used was Faker. Faker generates realistic-looking fake information such as names, addresses, emails, and phone numbers. I also used Python’s built-in hashlib library. I used SHA-256 from hashlib to create a consistent seed for Faker.
The project uses:
* Python 3
* Faker
* hashlib
* SQL
I chose Python because it made it fairly simple to read the SQL file, find the information that needed to be changed, and write the anonymized version to a new file.

Faker

Faker is the main external library used in my program. It can generate different types of fake information, including names, addresses, emails, and phone numbers. I used it because the assignment asks for realistic synthetic data. Using something like NAME001 or PHONE001 would work as a replacement, but it would not look like realistic test data.

I installed Faker using the command: python -m pip install Faker
The hashlib library does not need to be installed because it is already included with Python.

How to Run the Program

The project folder should contain the following files:
original.sql
anonymizer.py

Open PowerShell or another terminal in the project folder and run: python anonymizer.py
The program reads original.sql, replaces the specified personal information, and creates anonymized.sql.
If everything works, the program prints: Anonymized SQL file created successfully!

Input and Output

The input file for the program is original.sql.
The SQL file contains four tables:

* customers
* orders
* contacts
* shipping
  
Some of the same customer information appears in more than one table. This makes it possible to test whether the anonymized information stays consistent. The output file is anonymized.sql.
The original SQL structure stays in place, but the names, addresses, emails, and phone numbers are replaced.
For example, one of the original names, Daniel Carter, can become Wendy Jones. If Daniel Carter appears somewhere else in the SQL file, it will also become Wendy Jones. The same idea is used for addresses, emails, and phone numbers.

How My Program Works

The program starts by creating four dictionaries:
* name_mapping
* address_mapping
* email_mapping
* phone_mapping
These dictionaries keep track of the original values and the fake values that were created for them.

The program then reads the entire original.sql file.

I have lists in the Python program containing the names, addresses, email addresses, and phone numbers from the test SQL file. These lists tell the program which values should be replaced. For each value, the program creates a SHA-256 hash of the original value. That hash is turned into a number and used as the seed for Faker. The basic process is: Original value → SHA-256 hash → Seed → Faker → Fake value

Faker then generates the replacement.

The program uses fake names for names, fake.address() for addresses, fake.email() for emails, and fake.numerify(“###-###-####”) for phone numbers. The generated value is saved in the appropriate dictionary. The program then uses Python’s replace function to replace the original value in the SQL text. After all of the replacements are finished, the modified SQL is written to anonymized.sql.

Keeping the Data Consistent

Consistency was one of the main things I needed to make sure worked correctly. For example, if the original SQL contains Daniel Carter, the program might generate Wendy Jones.
The mapping is then saved as: Daniel Carter → Wendy Jones
If Daniel Carter appears again, the program checks the mapping first and uses Wendy Jones instead of creating another fake name. The same idea is used for addresses, emails, and phone numbers. The SHA-256 seed also helps with consistency. Since the seed comes from the original value, the same original value can produce the same Faker result.

Consistency Between Tables

The SQL file was set up so that some information is repeated between tables. For example, information for the same customer can appear in customers, orders, contacts, and shipping. The program uses the same mappings while processing the whole SQL file. Because of this, the same original name, address, email, or phone number gets the same replacement wherever it appears. This is important because changing the information differently in each table could break the relationships between the records.

Synthetic Data

The replacement information is generated by Faker. It is not meant to represent the original people. Instead of using placeholders such as NAME001, ADDRESS001, EMAIL001, and PHONE001, the program creates values that look more like actual data. The purpose is to make the anonymized SQL file still useful for testing while removing the original personal information. One limitation is that the fake name and fake email are generated independently. The program does not specifically create an email from the fake person’s name. Both are still synthetic, but they do not necessarily match each other.

Anonymization Concepts I Looked At

Before choosing my approach, I looked at several common ways of handling sensitive data.

Data Masking

Data masking hides part of the original information. For example, a phone number such as 612-555-1101 could be displayed as 612-XXX-XXXX. I did not use masking because the assignment calls for realistic replacement data, not just partially hidden data.

Anonymization

Anonymization is the process of changing or removing identifying information so that the original person cannot be identified from the resulting data. This is the main goal of my project. I replace names, addresses, email addresses, and phone numbers with synthetic values.

Pseudonymization

Pseudonymization replaces identifying information with another value while keeping some way of connecting the replacement to the original value. My program has some similarities to this because it creates mappings between the original values and their replacements while it is running. However, the final SQL file contains the synthetic values instead of the original personal information.

Synthetic Data

Synthetic data is data that is artificially generated instead of being copied directly from the original data. This is what I used for the replacement values. Faker creates the new names, addresses, emails, and phone numbers.

Hashing

Hashing converts information into a fixed-length value. I use SHA-256 hashing in this project to create a deterministic seed for Faker. I am not putting the SHA-256 hash into the SQL file.
The process is:
Original value → SHA-256 → Seed → Faker → Synthetic value

Tokenization

Tokenization replaces sensitive information with a token. For example, Daniel Carter could become TOKEN_001.
I did not use tokenization because the assignment asks for realistic synthetic data. A token such as TOKEN_001 would not look like an actual name or address.

Why I Chose This Approach

I chose this approach because it covers the main requirements of the assignment without making the program unnecessarily complicated. Faker gives me realistic-looking replacement data, while the mapping dictionaries make sure repeated values stay consistent. Using SHA-256 as the seed also makes the generated replacements deterministic. This means the same original value can produce the same synthetic value. I also chose to work with the SQL file as text instead of using a full SQL parser. For this assignment, the test data is known and performance is not the main concern. The simpler approach was easier to implement and test.

Handling Apostrophes

The SQL file includes a name containing an apostrophe: Robert O’'Connor. The two apostrophes are how the apostrophe is escaped inside an SQL string. I included the SQL-formatted version in the list of names that the program replaces. The program replaces the complete value instead of trying to change individual characters. This was useful for testing whether special characters in the data could be handled without changing the surrounding SQL.

Preserving the SQL

The program does not rebuild the SQL statements. It reads the original file as text and replaces only the values that are in the anonymization lists.
Because of this, things such as the following are left alone:
* SQL commands
* Column names
* Customer IDs
* Order IDs
* Dates
* Product names
* Quantities
* Prices
* Loyalty levels
* TRUE and FALSE
* Contact types
* Shipping companies
* Tracking statuses
* Other non-sensitive information
The DROP TABLE, CREATE TABLE, INSERT, UPDATE, and DELETE statements are also left in place. The goal is for anonymized.sql to still have the same basic structure and relationships as the original file.

Testing

I tested the program using the SQL test file provided for the assignment.
I checked that the original names were replaced with fake names.
I checked that the original addresses were replaced with synthetic addresses.
I checked that the original email addresses were replaced with fake email addresses.
I checked that the original phone numbers were replaced and that the generated numbers followed a normal phone-number format.
I also checked the generated anonymized.sql file to make sure the original names, addresses, emails, and phone numbers were no longer present.
Repeated values were checked to make sure the same original value received the same replacement.
I also checked information that appeared in more than one table to make sure the replacements stayed consistent.
The SQL statements were checked to make sure they were still present after the replacements.
Finally, I checked that information that did not need to be anonymized was not unnecessarily changed.

For example, values such as Gold, Silver, Bronze, TRUE, FALSE, Wireless Keyboard, UPS, FedEx, USPS, Delivered, In Transit, and Processing remain unchanged.

Testing Results

Column 1	Column 2
Test	Result
Names replaced	PASS
Addresses replaced	PASS
Emails replaced	PASS
Phone numbers replaced	PASS
Original PII removed	PASS
Repeated values stay consistent	PASS
Values consistent across tables	PASS
Synthetic data has reasonable formats	PASS
SQL structure preserved	PASS
Non-sensitive data preserved	PASS
Apostrophe case tested	PASS


Limitations

There are a few limitations to my current program. First, the program uses predefined lists of the names, addresses, emails, and phone numbers from the assignment’s test file. It is not an automatic PII detection system. If a completely different SQL file were used, I would need to update those lists. Second, the fake names and emails are generated independently. The program does not make an email based on the generated fake name. Third, the program uses string replacement rather than a SQL parser. This works for the provided test file, but a larger or more complicated SQL file could require a more advanced approach. Finally, the mapping dictionaries only exist while the program is running. They are not saved to a separate file.

Project Files

The project contains four main files:

* anonymizer.py — The Python program that performs the anonymization.
* original.sql — The original SQL test file.
* anonymized.sql — The SQL file created by the Python program after replacing the specified personal information.
* README.md — This documentation explaining the project, how it works, how to run it, and how it was tested.

Conclusion

For this assignment, I created a Python program that replaces names, addresses, email addresses, and phone numbers in an SQL file with synthetic data. I used Faker to generate the replacements and SHA-256 hashing to create consistent seeds. I also used mapping dictionaries so that repeated information gets the same replacement throughout the SQL file. The final anonymized.sql file keeps the original SQL structure and non-sensitive information while removing the original personal information. My testing also showed that repeated values stay consistent and that the generated information has reasonable formats. The main limitation is that the program currently works with the known PII values in the assignment’s test file rather than automatically finding every possible piece of PII in any SQL file.
