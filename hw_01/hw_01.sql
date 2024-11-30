/*
База данных MS SQL создана на windows хостинге на Windows Web Server 2019 с помощью GUI интерфейса на хостинге
Сервер базы данных - SQL Server 2019 Web Edition
 */

/*
Создание таблицы с оценками студентов
Первичный ключ - поле id с авто инкрементом с шагом 1, старт с 1
На всех полях ограничение NOT NULL, кроме поля email (его может не быть у студента)
Поля student_fullname, city, country с помощью префикса N хранят данные в кодировке UNICODE
Для средней оценки average_rating использован десятичный тип данных DECIMAL с точностью 4 и масштабом 2
(Оценка студентов взята в интервале от 0 до 100)
 */
CREATE TABLE student_rating (
    id INTEGER IDENTITY (1,1) PRIMARY KEY,
    student_fullname NVARCHAR(150) NOT NULL,
    city NVARCHAR(50) NOT NULL,
    country NVARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(50),
    phone VARCHAR(12) NOT NULL,
    group_name VARCHAR(50) NOT NULL,
    average_rating DECIMAL(4,2) NOT NULL,
    min_average_subject NVARCHAR(50) NOT NULL,
    max_average_subject NVARCHAR(50) NOT NULL
);

/*
Фейковые данные созданы с помощью скрипта Python пакетом Faker
С помощью предложения INSERT INTO вставляем 10 строк данных во все поля кроме id
 */
INSERT INTO student_rating
    (student_fullname, city, country,
     date_of_birth, email, phone,
     group_name, average_rating, min_average_subject, max_average_subject)
VALUES
    (N'Тетяна Їжакевич', N'місто Бахмач', N'Іспанія', '1966-05-13', 'zakharfartushniak@example.net', '524124440213', 'BackEnd', 83.71, 'Mathematics', 'Network'),
    (N'Златослава Голик', N'хутір Бобринець', N'Оман', '1949-12-21', 'zhrytsenko@example.com', '039521545972', 'BackEnd', 67.78, 'Network', 'Python'),
    (N'Герман Гайворонський', N'селище Сокаль', N'Того', '2012-01-21', 'iderkach@example.net', '696009313094', 'BackEnd', 66.19, 'JavaScript', 'Python'),
    (N'добродійка Соломія Бабʼяк', N'місто Дружківка', N'Куба', '1991-02-27', 'sahalavhustyn@example.org', '885121883603', 'FrontEnd', 80.57, 'Python', 'JavaScript'),
    (N'Ростислав Коваленко', N'селище Ковель', N'Казахстан', '2019-02-07', 'lubenetsserhii@example.net', '101331833094', 'BackEnd', 87.78, 'Python', 'JavaScript'),
    (N'Мартин Дахно', N'селище Коростень', N'Велика Британія', '1918-10-04', 'vasylenkoalina@example.net', '098220360777', 'BackEnd', 62.23, 'SQL', 'Network'),
    (N'Ярослав Ребрик', N'село Алмазна', N'Ефіопія', '1973-08-19', 'tymofii03@example.org', '338384197591', 'QA', 98.8, 'HTML', 'JavaScript'),
    (N'Богуслава Бабко', N'село Почаїв', N'Сербія', '1971-07-08', 'marko52@example.net', '913515315125', 'BackEnd', 93.91, 'HTML', 'SQL'),
    (N'Ґерус Роман Єлисейович', N'село Гуляйполе', N'Домініканська Республіка', '1996-01-15', 'davyd23@example.org', '722766597991', 'BackEnd', 81.35, 'Mathematics', 'SQL');

/*
С помощью оператора SELECT получаем первые 5 записей таблицы student_rating
 */
SELECT TOP 5 *
FROM student_rating;
