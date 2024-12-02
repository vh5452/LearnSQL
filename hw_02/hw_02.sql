-- Відображення всієї інформації з таблиці зі студентами та оцінками.
/*
 С помощью оператора SELECT и символа *
 получаем данные со всех колонок таблицы student_rating
 */

SELECT *
FROM student_rating;

-- Відображення ПІБ усіх студентів.
/*
 С помощью оператора SELECT получаем все данные из колонки student_fullname
 из таблицы student_rating
 */
SELECT student_fullname
FROM student_rating;

-- Відображення усіх середніх оцінок.
/*
 С помощью оператора SELECT получаем все данные из колонки average_rating
 из таблицы student_rating
 */
SELECT average_rating
FROM student_rating;

-- Показати країни студентів. Назви країн мають бути унікальними.
/*
 С помощью оператора SELECT получаем данные из колонки country из таблицы student_rating
 Уникальные записи получаем с помощью ключевого слова DISTINCT перед колонкой country
 */
SELECT DISTINCT country
FROM student_rating;

-- Показати міста студентів. Назви міст мають бути унікальними.
/*
 С помощью оператора SELECT получаем данные из колонки city из таблицы student_rating
 Уникальные записи получаем с помощью ключевого слова DISTINCT перед колонкой city
 */
SELECT DISTINCT city
FROM student_rating;

-- Показати назви груп. Назви груп мають бути унікальними.
/*
 С помощью оператора SELECT получаем данные из колонки group_name из таблицы student_rating
 Уникальные записи получаем с помощью ключевого слова DISTINCT перед колонкой group_name
 */
SELECT DISTINCT group_name
FROM student_rating;
