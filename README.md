# SQL-Anonymization
# ICS 499 - SQL Data Anonymization

## 1. Project Overview

This project is a Python program that anonymizes sensitive information in a SQL file.

The program reads an SQL file containing fictional test data and replaces names, addresses, email addresses, and phone numbers with realistic synthetic values.

The program is designed to:

* Anonymize names
* Anonymize addresses
* Anonymize email addresses
* Anonymize phone numbers
* Keep repeated values consistent
* Keep values consistent across multiple SQL tables
* Preserve the SQL structure
* Preserve non-sensitive information
* Generate a separate anonymized SQL file

The input file is:

```text
original.sql
```

The generated output file is:

```text
anonymized.sql
```

---

# 2. Programming Language and Technologies

The program was written in:

* Python 3
* Faker
* hashlib
* SQL

Python was selected because it provides simple file and string-processing capabilities and supports libraries such as Faker for generating realistic synthetic data.

---

# 3. External Libraries

## Faker

The main external library used is the **Faker** Python library.

Faker generates realistic synthetic information such as:

* Names
* Addresses
* Email addresses
* Phone numbers

Faker was selected because the assignment requires realistic synthetic data rather than simple placeholders such as `NAME001` or `ADDRESS001`.

Faker is installed with:

```text
python -m pip install Faker
```

## hashlib

The program also uses Python's built-in `hashlib` module.

`hashlib` does not need to be installed separately because it is included with Python.

The program uses SHA-256 hashing to create a deterministic seed from each original value.

The hash itself is not placed into the anonymized SQL file. Instead, it is used to seed Faker so that the same original value can consistently generate the same synthetic value.

---

# 4. Installation

Python 3 must be installed.

After Python is installed, open a terminal in the project folder and run:

```text
python -m pip install Faker
```

No additional external libraries are required.

---

# 5. How to Run the Program

The project should contain the following files:

```text
original.sql
anonymizer.py
```

Open PowerShell or another terminal in the project directory and run:

```text
python anonymizer.py
```

The program will read `original.sql`, anonymize the sensitive values, and automatically create:

```text
anonymized.sql
```

The program also displays:

```text
Anonymized SQL file created successfully!
```

when the output file has been created.

---

# 6. Expected Input

The program expects an SQL file named:

```text
original.sql
```

The test file contains four tables:

* `customers`
* `orders`
* `contacts`
* `shipping`

The SQL file contains names, addresses, email addresses, and phone numbers that are intentionally repeated across different tables.

The program uses lists of the known names, addresses, emails, and phone numbers from the test SQL file to identify the values that need to be anonymized.

---

# 7. Generated Output

The program generates:

```text
anonymized.sql
```

The output contains the same general SQL structure as the original file, but the specified PII values have been replaced with synthetic values.

For example, an original name such as:

```text
Daniel Carter
```

can be replaced with a synthetic name such as:

```text
Wendy Jones
```

If the same original name appears multiple times, the same synthetic name is used each time.

The same approach is used for addresses, emails, and phone numbers.

---

# 8. How the Program Works

The program follows these steps.

### Step 1: Create mapping dictionaries

The program creates four dictionaries:

```text
name_mapping
address_mapping
email_mapping
phone_mapping
```

These dictionaries store the relationship between an original value and its synthetic replacement.

### Step 2: Read the SQL file

The program opens `original.sql` using UTF-8 encoding and reads the contents into the variable `sql_content`.

### Step 3: Identify sensitive values

The program contains lists of the names, addresses, email addresses, and phone numbers that appear in the test SQL file.

These lists tell the program which values should be anonymized.

### Step 4: Create a deterministic seed

For each original value, the program uses SHA-256 hashing:

```text
original value → SHA-256 hash → numeric seed
```

The seed is limited to a value that Faker can use.

### Step 5: Generate synthetic data

A Faker object is created and given the deterministic seed.

Faker then generates a synthetic value.

Different Faker methods are used for different types of information:

* `fake.name()` for names
* `fake.address()` for addresses
* `fake.email()` for emails
* `fake.numerify("###-###-####")` for phone numbers

### Step 6: Store the replacement

The generated synthetic value is saved in the appropriate mapping dictionary.

For example:

```text
Daniel Carter → Wendy Jones
```

### Step 7: Replace the original value

The program uses Python's string replacement function to replace the original value in the SQL content.

### Step 8: Create the output file

After all replacements are completed, the program writes the modified SQL content to:

```text
anonymized.sql
```

---

# 9. Anonymization Strategy

The program uses **realistic synthetic data generation, deterministic seeding, and mapping dictionaries**.

The goal is to replace PII while maintaining the relationships between repeated values.

For each category of PII, a separate mapping dictionary is used.

For example:

```text
name_mapping
Daniel Carter → Wendy Jones
```

If `Daniel Carter` appears again, the program checks the dictionary first.

If the original value is already present, the program returns the existing synthetic value instead of generating another one.

This prevents the same original value from receiving multiple replacements during the program execution.

---

# 10. How Consistency Is Maintained

Consistency is maintained through the mapping dictionaries and deterministic seeding.

For example, suppose the original SQL contains:

```text
Daniel Carter
```

The program generates:

```text
Wendy Jones
```

and stores:

```text
Daniel Carter → Wendy Jones
```

If `Daniel Carter` appears again, the program uses `Wendy Jones` again.

The same process is used for:

* Names
* Addresses
* Email addresses
* Phone numbers

This is especially important because the same customer's information appears in multiple tables.

---

# 11. Consistency Across Tables

The SQL file contains information that is repeated across:

```text
customers
orders
contacts
shipping
```

For example, the same customer name, email, phone number, or address can appear in more than one table.

Because the program uses the same mappings throughout the SQL file, repeated original values are replaced consistently.

For example:

```text
customers:
Wendy Jones
rramos@example.org

orders:
Wendy Jones
rramos@example.org

contacts:
Wendy Jones
rramos@example.org

shipping:
Wendy Jones
```

The original relationships are therefore preserved while the original PII is removed.

---

# 12. Synthetic Data Generation

The program uses Faker to generate realistic synthetic data.

Instead of replacing information with generic placeholders such as:

```text
NAME001
ADDRESS001
EMAIL001
PHONE001
```

the program generates values that resemble realistic data.

For example:

```text
Wendy Jones
2449 Gamble Lake Suite 991, Lake Kimberly, CA 79132
rramos@example.org
634-520-7615
```

The synthetic values are generated for testing purposes and are not intended to represent the original individuals.

---

# 13. Research Component

Several data anonymization concepts were considered before selecting the implementation approach.

## Data Masking

Data masking hides or changes part of sensitive information while often leaving some of the original value visible.

For example:

```text
612-555-1101
```

could be displayed as:

```text
612-XXX-XXXX
```

Masking was not selected because the assignment requires realistic synthetic replacement values rather than partially hidden values.

## Anonymization

Anonymization transforms or removes identifying information so that the original individuals cannot be identified from the resulting data.

This is the main goal of this project.

Names, addresses, email addresses, and phone numbers are replaced with synthetic values.

## Pseudonymization

Pseudonymization replaces identifying information with another value while maintaining a way to associate the replacement with the original value.

The mapping dictionaries in this project have some characteristics of pseudonymization because they create relationships between original values and replacement values during processing.

However, the final SQL output contains synthetic values rather than the original PII.

## Synthetic Data

Synthetic data is artificially generated data that resembles realistic data but is not directly copied from the original dataset.

Synthetic data is appropriate for this assignment because the resulting SQL should remain realistic and useful for testing.

Faker is used to generate the synthetic data.

## Hashing

Hashing converts an input into a fixed-length value.

This project uses SHA-256 hashing to create deterministic seeds for Faker.

The hash is not used as the visible replacement value.

Instead:

```text
Original value
      ↓
SHA-256
      ↓
Deterministic seed
      ↓
Faker
      ↓
Synthetic value
```

## Tokenization

Tokenization replaces sensitive information with a token or placeholder.

For example:

```text
Daniel Carter
```

could become:

```text
TOKEN_001
```

Tokenization was not selected because the assignment requires realistic synthetic data. A token would not look like a realistic name, address, email, or phone number.

---

# 14. Why This Approach Was Selected

This approach was selected because it satisfies the main requirements of the assignment.

### Realistic values

Faker generates realistic-looking names, addresses, emails, and phone numbers.

### Consistency

Mapping dictionaries allow repeated values to use the same synthetic replacement.

### Deterministic generation

SHA-256 hashing is used to create a deterministic seed from the original value.

### Preservation of SQL

The program modifies the SQL as text instead of rebuilding the SQL statements. This helps preserve the original SQL structure.

### Simple implementation

The approach is straightforward to understand, implement, and test.

The assignment states that performance is not the main concern, so the program prioritizes correctness and consistency.

---

# 15. Handling Apostrophes

The test SQL file contains a name with an apostrophe represented using SQL escaping.

The program includes the SQL-formatted value in its list of names:

```text
Robert O''Connor
```
The replacement is performed on the complete string, allowing the SQL structure around the value to remain intact.
This was included because the assignment specifically requires testing the handling of apostrophes and special characters.

---

# 16. Preserving SQL Structure
The program reads the entire SQL file as text and performs targeted replacements.It does not intentionally modify SQL commands or non-sensitive values.

The following are preserved:

* `DROP TABLE` statements
* `CREATE TABLE` statements
* `INSERT` statements
* `UPDATE` statements
* `DELETE` statements
* Column names
* Customer IDs
* Order IDs
* Dates
* Product names
* Quantities
* Amounts
* Loyalty levels
* Boolean values
* Contact types
* Notes
* Shipping carriers
* Tracking statuses

The program also preserves the two different `INSERT` statement styles in the test file.

---

# 17. Testing
Testing was performed using the provided synthetic SQL test data. Correctness was prioritized over performance. The following tests were performed.

### Names
The original names were replaced with synthetic names. Repeated names were checked to make sure they received the same synthetic replacement.

### Addresses
The original addresses were replaced with synthetic addresses.Repeated addresses were checked for consistency.

### Emails
The original email addresses were replaced with synthetic email addresses. Repeated emails were checked to make sure the same replacement was used.

### Phone Numbers
The original phone numbers were replaced with synthetic phone numbers. The generated phone numbers were checked to make sure they followed a reasonable phone-number format.

### Original PII
The generated `anonymized.sql` file was checked to make sure the original names, addresses, email addresses, and phone numbers were removed.

### Repeated Values
Repeated values were checked within the SQL file to make sure the same original value received the same synthetic replacement.

### Multiple Tables
Values appearing in `customers`, `orders`, `contacts`, and `shipping` were checked for consistency.
### Synthetic Formats
The generated values were checked to make sure they had reasonable formats.
Examples include:
* Names that look like names
* Addresses that look like addresses
* Emails that follow an email format
* Phone numbers that follow a phone-number format

### SQL Structure
The generated SQL file was checked to make sure the SQL statements remained intact.

### Non-sensitive Values
Non-sensitive values were checked to make sure they were not unnecessarily changed.
Examples include:
```text
Gold
Silver
Bronze
TRUE
FALSE
Wireless Keyboard
UPS
FedEx
USPS
Delivered
In Transit
Processing
```

These values remain unchanged.

---

# 18. Testing Results

| Requirement                              | Result |
| ---------------------------------------- | ------ |
| Names anonymized                         | PASS   |
| Addresses anonymized                     | PASS   |
| Emails anonymized                        | PASS   |
| Phone numbers anonymized                 | PASS   |
| Original PII removed                     | PASS   |
| Repeated values consistent               | PASS   |
| Consistency across tables                | PASS   |
| Synthetic values have reasonable formats | PASS   |
| SQL structure preserved                  | PASS   |
| Non-sensitive values preserved           | PASS   |

---

# 19. Known Limitations
The program has several limitations.

### Predefined PII lists
The program currently identifies sensitive values using predefined lists of names, addresses, emails, and phone numbers from the assignment's test SQL file. Therefore, it is not a completely general-purpose SQL anonymization tool.
A more advanced program could automatically detect PII based on column names, SQL schema information, or pattern matching.

### Independent synthetic fields
The fake names and fake email addresses are generated independently using Faker.
The program does not create an email address specifically from the generated person's fake name.

### Text replacement
The program uses Python string replacement instead of a full SQL parser.
This keeps the implementation simple but means that a more advanced solution could provide more precise field-level SQL processing.

### Mapping storage
The mappings are stored in memory while the program runs. They are not saved to a separate mapping file.
The mapping is therefore intended for the anonymization process rather than for recovering the original data.

---

# 20. Project Files

The completed project contains:
SQL-Anonymization/
│
├── anonymizer.py
├── original.sql
├── anonymized.sql
└── README.md
```

### `anonymizer.py`
The Python program that performs the anonymization.

### `original.sql`
The original synthetic SQL test file provided for the assignment.

### `anonymized.sql`
The SQL file generated by the Python program after replacing the specified PII.

### `README.md`
The project documentation explaining the technology, anonymization strategy, design decisions, installation, execution, and testing.

# 21. Conclusion
This project demonstrates a Python-based approach to SQL data anonymization using Faker, SHA-256 hashing, and mapping dictionaries. The program replaces names, addresses, email addresses, and phone numbers with realistic synthetic values while maintaining consistency when the same values appear multiple times or across different SQL tables. The approach was selected because it provides realistic synthetic data, consistent replacements, and preservation of the existing SQL structure. Testing focused on verifying that the original PII was removed, repeated values remained consistent, synthetic values had reasonable formats, SQL structure was preserved, and non-sensitive information was not unnecessarily modified.
The final result is an `anonymized.sql` file that remains useful for testing while no longer exposing the original names, addresses, email addresses, or phone numbers.
