--1. Определить количество стран-участниц чемпионата мира.
/*
 Предложение SELECT - функцией count считаем количество значений колонки country
                     DISTINCT может быть и лишнее, но лучше перестраховаться (а вдруг дубликаты),
                     если бы ограничение стояло бы на поле UNIQUE, тогда DISTINCT не нужен
 Предложение FROM - данные из таблицы Teams
 */
SELECT
    N'Кількість країн учасників' AS N'Показник',
    N'одиниць' AS 'Одиниця виміру або значення',
    count(DISTINCT Teams.country) AS N'Значення'
FROM Teams;


--2. Определить количество стран, становившихся чемпионами мира.
/*
Предложение SELECT - функцией count считаем количество значений колонки country
Предложение FROM - данные из таблицы Teams
Предложение WHERE - выбираем только где значение Champion больше или равно 1
 */
SELECT
    N'Країни - чемпіони світу' AS N'Показник',
    N'одиниць' AS 'Одиниця виміру або значення',
    count(DISTINCT Teams.country) AS N'Значення'
FROM Teams
WHERE Teams.Champion >= 1; -- или не равно нулю


--3. Определить количество стран-участниц чемпионата мира, в которых официальным языком является испанский язык.
/*
Предложение SELECT - функцией count считаем количество значений колонки country
Предложение FROM - данные из таблицы Teams
Предложение WHERE - выбираем только где значение Language в нижнем регистре равно "испанский"
 */
SELECT
    N'Країни - чемпіони світу, з офіційною мовою іспанська' AS N'Показник',
    N'одиниць' AS 'Одиниця виміру або значення',
    count(DISTINCT Teams.country) AS N'Значення'
FROM Teams
WHERE lower(Teams.Language) = N'испанский';

--4. Определить количество дебютантов чемпионата мира.
/*
Предложение SELECT - функцией count считаем количество значений колонки country
Предложение FROM - данные из таблицы Teams
Предложение WHERE - выбираем только где значение Debut равно 1
 */
SELECT
    N'Дебютанти чемпіонату світу' AS N'Показник',
    N'одиниць' AS N'Одиниця виміру або значення',
    count(DISTINCT Teams.country) AS N'Значення'
FROM Teams
WHERE Teams.Debut = 1;

--5. Определить наибольшую территорию из всех стран-участниц. (2 варианта)

-- ВАРИАНТ 1 с помощью ограничения выборки TOP и сортировки по убыванию DESC
/*
Предложение SELECT - выбираем только первую запись из набора с помощью TOP
Предложение FROM - данные из таблицы Teams
Предложение ORDER BY - Territory сортируем по убыванию
 */
SELECT TOP 1
    N'Країни з найбільшою територією (варіант 1)' AS N'Показник',
    Teams.Country AS N'Одиниця виміру або значення',
    Teams.Territory AS N'Значення'
FROM Teams
ORDER BY Teams.Territory DESC;
-- ВАРИАНТ 2 с помощью функции MAX
/*
Предложение FROM - данные из таблицы Teams
Предложение WHERE - выбираем только где значение Territory равно максимальному значению, полученному подзапросом
                    в подзапросе получаем функцией max максимальное значение Territory
 */
SELECT
    N'Країни з найбільшою територією (варіант 2)' AS N'Показник',
    Teams.country AS N'Одиниця виміру або значення',
    Teams.Territory AS N'Значення'
FROM Teams
WHERE Teams.Territory = (SELECT max(Teams.Territory) FROM Teams);

--6. Определить наибольшую территорию из всех европейских стран-участниц. (2 варианта)

-- ВАРИАНТ 1 с помощью ограничения выборки TOP и сортировки по убыванию DESC
/*
Предложение SELECT - выбираем только первую запись из набора с помощью TOP
Предложение FROM - данные из таблицы Teams
Предложение WHERE - выбираем только те записи где в нижнем регистре Continent равен "европа"
Предложение ORDER BY - Territory сортируем по убыванию
 */
SELECT TOP 1
    N'Європейські країни з найбільшою територією (варіант 1)' AS 'indicator',
    Teams.Country AS N'Одиниця виміру або значення',
    Teams.Territory AS N'Значення'
FROM Teams
WHERE lower(Teams.Continent) = N'европа'
ORDER BY Teams.Territory DESC;

-- ВАРИАНТ 2 с помощью функции MAX
/*
Предложение FROM - данные из таблицы Teams
Предложение WHERE - выбираем только где значение Territory равно максимальному значению, полученному подзапросом
                    в подзапросе получаем функцией max максимальное значение Territory
                    и где в нижнем регистре Continent равен "европа"
 */
SELECT
    N'Європейські країни з найбільшою територією (варіант 2)' AS 'indicator',
    Teams.country AS N'Одиниця виміру або значення',
    Teams.Territory AS N'Значення'
FROM Teams
WHERE Teams.Territory = (SELECT max(Teams.Territory) FROM Teams WHERE lower(Teams.Continent) = N'европа');

--7. Определить суммарное количество чемпионских титулов, выигранных странами участницами.
/*
Предложение SELECT - с помощью функции sum суммируем все значения колонки Champion
Предложение FROM - данные из таблицы Teams
 */
SELECT
    N'Сумарна кількість чемпіонських титулів' AS N'Одиниця виміру або значення',
    N'одиниць' AS N'Одиниця виміру або значення',
    sum(Teams.Champion) AS N'Значення'
FROM Teams;

--8. Определить суммарное количество чемпионских титулов, выигранных европейскими странами участницами.
/*
Предложение SELECT - с помощью функции sum суммируем все значения колонки Champion
Предложение FROM - данные из таблицы Teams
Предложение WHERE - выбираем где в нижнем регистре Continent равен "европа"
 */
SELECT
    N'Сумарна кількість чемпіонських титулів європейських країн' AS N'Одиниця виміру або значення',
    N'одиниць' AS N'Одиниця виміру або значення',
    sum(Teams.Champion) AS N'Значення'
FROM Teams
WHERE lower(Teams.Continent) = N'европа';

--9. Определить наименьшую территорию из всех американских стран-участниц. (2 варианта)
-- ВАРИАНТ 1 с помощью ограничения выборки TOP и сортировки по убыванию ASC
/*
Предложение SELECT - выбираем только первую запись из набора с помощью TOP
Предложение FROM - данные из таблицы Teams
Предложение WHERE - выбираем только те записи где в нижнем регистре Continent содержит в любом месте "америка"
Предложение ORDER BY - Territory сортируем по возрастанию
 */
SELECT TOP 1
    N'Американська країна з найменшою територією (варіант 1)' AS N'Показник',
    Teams.country AS 'Одиниця виміру або значення',
    Teams.Territory 'Значення'
FROM Teams
WHERE lower(Teams.Continent) LIKE N'%америка%'
ORDER BY Teams.Territory ASC;

-- ВАРИАНТ 2 с помощью функции MIN
/*
Предложение FROM - данные из таблицы Teams
Предложение WHERE - выбираем только где значение Territory равно минимальному значению, полученному подзапросом
                    в подзапросе получаем функцией min минимальное значение Territory
                    и где в нижнем регистре Continent содержит в любом месте "америка"
 */
SELECT
    N'Американська країна з найменшою територією (варіант 2)' AS N'Показник',
    Teams.country AS 'Одиниця виміру або значення',
    Teams.Territory 'Значення'
FROM Teams
WHERE Teams.Territory = (SELECT min(Teams.Territory)
                         FROM Teams
                         WHERE lower(Teams.Continent) LIKE N'%америка%');

--10. Определить среднее значение территории среди африканских стран.
/*
Предложение SELECT - используя функцию avg получаем среднее значение колонки Territory
                    и округляем до 1 знака после запятой с помощью функции round
Предложение FROM - данные из таблицы Teams
Предложение WHERE - выбираем только те записи где в нижнем регистре Continent содержит в любом месте "африка"
 */
SELECT
    N'Середнє значення території африканських країн' AS N'Показник',
    N'км2' AS N'Одиниця виміру або значення',
    round(avg(Teams.Territory), 1) AS N'Значення'
FROM Teams
WHERE lower(Teams.Continent) LIKE N'%африка%';

--------------------

/*
 С помощью UNION объединяем все в один сводный отчет
 Union берет для названия выходных колонок названия колонок первого запроса,
 но мы оставляем везде названия колонок для читабельности всего кода
 В отчет мы включаем только те варианты заданий, в которых нет ORDER BY,
 поскольку в UNION ORDER BY можно включить только в самом конце и только один раз
 */
SELECT
    N'01. Кількість країн учасників' AS N'Показник',
    N'одиниць' AS 'Одиниця виміру або значення',
    count(DISTINCT Teams.country) AS N'Значення'
FROM Teams
UNION
SELECT
    N'02. Країни - чемпіони світу' AS N'Показник',
    N'одиниць' AS 'Одиниця виміру або значення',
    count(DISTINCT Teams.country) AS N'Значення'
FROM Teams
WHERE Teams.Champion >= 1
UNION
SELECT
    N'03. Країни - чемпіони світу, з офіційною мовою іспанська' AS N'Показник',
    N'одиниць' AS 'Одиниця виміру або значення',
    count(DISTINCT Teams.country) AS N'Значення'
FROM Teams
WHERE lower(Teams.Language) = N'испанский'
UNION
SELECT
    N'04. Дебютанти чемпіонату світу' AS N'Показник',
    N'одиниць' AS N'Одиниця виміру або значення',
    count(DISTINCT Teams.country) AS N'Значення'
FROM Teams
WHERE Teams.Debut = 1
UNION
SELECT
    N'05. Країни з найбільшою територією (варіант 2)' AS N'Показник',
    Teams.country AS N'Одиниця виміру або значення',
    Teams.Territory AS N'Значення'
FROM Teams
WHERE Teams.Territory = (SELECT max(Teams.Territory) FROM Teams)
UNION
SELECT
    N'06. Європейські країни з найбільшою територією (варіант 2)' AS 'indicator',
    Teams.country AS N'Одиниця виміру або значення',
    Teams.Territory AS N'Значення'
FROM Teams
WHERE Teams.Territory = (SELECT max(Teams.Territory) FROM Teams WHERE lower(Teams.Continent) = N'европа')
UNION
SELECT
    N'07. Сумарна кількість чемпіонських титулів' AS N'Одиниця виміру або значення',
    N'одиниць' AS N'Одиниця виміру або значення',
    sum(Teams.Champion) AS N'Значення'
FROM Teams
UNION
SELECT
    N'08. Сумарна кількість чемпіонських титулів європейських країн' AS N'Одиниця виміру або значення',
    N'одиниць' AS N'Одиниця виміру або значення',
    sum(Teams.Champion) AS N'Значення'
FROM Teams
WHERE lower(Teams.Continent) = N'европа'
UNION
SELECT
    N'09. Американська країна з найменшою територією (варіант 2)' AS N'Показник',
    Teams.country AS 'Одиниця виміру або значення',
    Teams.Territory 'Значення'
FROM Teams
WHERE Teams.Territory = (SELECT min(Teams.Territory)
                         FROM Teams
                         WHERE lower(Teams.Continent) LIKE N'%америка%')
UNION
SELECT
    N'10. Середнє значення території африканських країн' AS N'Показник',
    N'км2' AS N'Одиниця виміру або значення',
    round(avg(Teams.Territory), 1) AS N'Значення'
FROM Teams
WHERE lower(Teams.Continent) LIKE N'%африка%';