from faker import Faker
import hashlib

name_mapping = {}
address_mapping = {}
email_mapping = {}
phone_mapping = {}

def get_fake_name(original_name):
    if original_name in name_mapping:
        return name_mapping[original_name]

    seed = int(
        hashlib.sha256(original_name.encode()).hexdigest(),
        16
    ) % (2**32)

    fake = Faker()
    fake.seed_instance(seed)

    fake_name = fake.name()

    name_mapping[original_name] = fake_name

    return fake_name
def get_fake_address(original_address):
    # If we already created a fake address, use it again
    if original_address in address_mapping:
        return address_mapping[original_address]

    # Create a consistent seed from the original address
    seed = int(
        hashlib.sha256(original_address.encode()).hexdigest(),
        16
    ) % (2**32)

    # Create a Faker object with that seed
    fake = Faker()
    fake.seed_instance(seed)

    # Generate the fake address
    fake_address = fake.address().replace("\n", ", ")

    # Save the mapping
    address_mapping[original_address] = fake_address

    return fake_address
def get_fake_email(original_email):
    # If we already created a fake email, use it again
    if original_email in email_mapping:
        return email_mapping[original_email]

    # Create a consistent seed from the original email
    seed = int(
        hashlib.sha256(original_email.encode()).hexdigest(),
        16
    ) % (2**32)

    # Create a Faker object with that seed
    fake = Faker()
    fake.seed_instance(seed)

    # Generate a fake email
    fake_email = fake.email()

    # Save the mapping
    email_mapping[original_email] = fake_email

    return fake_email
def get_fake_phone(original_phone):
    # If we already created a fake phone number, use it again
    if original_phone in phone_mapping:
        return phone_mapping[original_phone]

    # Create a consistent seed from the original phone number
    seed = int(
        hashlib.sha256(original_phone.encode()).hexdigest(),
        16
    ) % (2**32)

    # Create a Faker object with that seed
    fake = Faker()
    fake.seed_instance(seed)

    # Generate a fake phone number
    fake_phone = fake.numerify("###-###-####")

    # Save the mapping
    phone_mapping[original_phone] = fake_phone

    return fake_phone

# Read SQL file
with open("original.sql", "r", encoding="utf-8") as file:
    sql_content = file.read()


# Names to anonymize
names = [
    "Daniel Carter",
    "Priya Nair",
    "Michael Rodriguez",
    "Emily Chen",
    "Samuel Johnson",
    "Aisha Khan",
    "Robert O''Connor",
    "Lakshmi Rao",
    "James Wilson",
    "Sophia Martinez",
    "Arjun Patel",
    "Olivia Brown",
    "David Kim",
    "Grace Thompson",
    "Mohammed Ali"
]

addresses = [
    "1824 Cedar Lane, Minneapolis, MN 55403",
    "744 Summit Avenue, St. Paul, MN 55105",
    "915 Lake Street, Minneapolis, MN 55408",
    "412 Oak Ridge Drive, Eden Prairie, MN 55344",
    "301 River Road, Maple Grove, MN 55369",
    "88 Highland Parkway, Bloomington, MN 55420",
    "1777 Grand Avenue, St. Paul, MN 55105",
    "5620 Penn Avenue S, Minneapolis, MN 55419",
    "230 Birch Street, Roseville, MN 55113",
    "991 Prairie Center Drive, Eden Prairie, MN 55344",
    "1432 France Avenue, Edina, MN 55424",
    "640 University Avenue, St. Paul, MN 55104",
    "2200 Hennepin Avenue, Minneapolis, MN 55405",
    "70 Central Avenue, Wayzata, MN 55391",
    "8450 Zane Avenue N, Brooklyn Park, MN 55443"
]
emails = [
    "daniel.carter@example.com",
    "priya.nair@example.com",
    "michael.rodriguez@example.com",
    "emily.chen@example.com",
    "samuel.johnson@example.com",
    "aisha.khan@example.com",
    "robert.oconnor@example.com",
    "lakshmi.rao@example.com",
    "james.wilson@example.com",
    "sophia.martinez@example.com",
    "arjun.patel@example.com",
    "olivia.brown@example.com",
    "david.kim@example.com",
    "grace.thompson@example.com",
    "mohammed.ali@example.com"
]
phones = [
    "612-555-1101",
    "651-555-2202",
    "763-555-3303",
    "952-555-4404",
    "763-555-5505",
    "952-555-6606",
    "651-555-7707",
    "612-555-8808",
    "651-555-9909",
    "952-555-1010",
    "952-555-1111",
    "651-555-1212",
    "612-555-1313",
    "952-555-1414",
    "763-555-1515"
]
# Replace names
for original_name in names:
    fake_name = get_fake_name(original_name)
    sql_content = sql_content.replace(original_name, fake_name)

# Replace addresses
for original_address in addresses:
    fake_address = get_fake_address(original_address)
    sql_content = sql_content.replace(original_address, fake_address)
 
# Replace emails
for original_email in emails:
    fake_email = get_fake_email(original_email)
    sql_content = sql_content.replace(original_email, fake_email)

# Replace phone numbers
for original_phone in phones:
    fake_phone = get_fake_phone(original_phone)
    sql_content = sql_content.replace(original_phone, fake_phone)

# Save the anonymized SQL to a new file
with open("anonymized.sql", "w", encoding="utf-8") as file:
    file.write(sql_content)

print("Anonymized SQL file created successfully!")
