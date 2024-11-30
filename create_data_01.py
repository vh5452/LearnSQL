# Создание фейковых данных для ДЗ01

from faker import Faker
import random

fake = Faker(locale='uk-UA')
fake_data = []

for i in range(9):
    student_fullname = fake.name()
    city = fake.city()
    country = fake.country()
    date_of_birth = fake.date_of_birth().isoformat()
    email = fake.email()
    phone = fake.msisdn()
    group_name = random.choice(['BackEnd', 'FrontEnd', 'DataScience', 'QA'])
    average_rating = random.randint(5000, 9999) / 100
    min_average_subject = random.choice(['HTML', 'SQL', 'Python', 'Network', 'Mathematics', 'JavaScript'])
    max_average_subject = random.choice(['HTML', 'SQL', 'Python', 'Network', 'Mathematics', 'JavaScript'])

    fake_item = f"(N'{student_fullname}', N'{city}', N'{country}', '{date_of_birth}', '{email}', '{phone}', '{group_name}', {average_rating}, '{min_average_subject}', '{max_average_subject}')"
    fake_data.append(fake_item)


for i in fake_data:
    print(i)
