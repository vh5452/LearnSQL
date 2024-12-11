-- 1. Отобразить страну, которая чаще других становилась чемпионом мира.
/*
 Получаем страну, где количество равно (подзапрос - выбираем максимальное количество чемпионских титулов)
 */
SELECT Country.Name
FROM Country
WHERE Country.Champion = (SELECT max(Country.Champion)
                  FROM Country);

-- 2. Отобразить количество стран, представленное каждым континентом на чемпионате мира.

-- ВАРИАНТ 1
/*
 В левой таблице получаем все континенты
 В правой таблице группируем континенты и получаем количество записей соответствующих каждому континенту
 Объединяем INNER JOIN
 */
SELECT
    Continent.Name AS Continent,
    count(*) AS "Quantity of countries"
FROM Country
JOIN Continent
    ON Country.ContinentId = Continent.Id
GROUP BY Continent.Name;

-- ВАРИАНТ 2
/*
 Первый столбец - получаем континенты
 Второй столбец с помощью коррелирующего подзапроса получаем количество записей соответствующих каждому континенту
 */
SELECT Continent.Name AS "Quantity of countries",
        (SELECT count(*) FROM Country WHERE Country.ContinentId = Continent.Id) AS "Quantity of countries"
FROM Continent
ORDER BY Continent.Name;


-- 3. Отобразить европейскую страну, которая чаще других становилась чемпионом мира.

-- ВАРИАНТ 1
/*
 По-моему перемудрил
 */
SELECT
    Continent.Name AS Continent,
    Country.Name AS Country,
    Country.Champion AS "Number of championship titles"
FROM Country
JOIN Continent
    ON Country.ContinentId = Continent.Id
WHERE Country.Champion = (SELECT max(Country.Champion)
                          FROM Country
                          JOIN Continent
                              ON Country.ContinentId = Continent.Id
                          WHERE lower(Continent.Name) LIKE N'%европа%')
    AND lower(Continent.Name) LIKE N'%европа%';

-- ВАРИАНТ 2
/*
 Левая таблица - получаем страны
 Правая таблица - получаем континенты, нужна для поиска по шаблону
 В подзапросе (коррелирующий) используем копию таблицы Country где считаем количество чемпионских титулов
 Сортирует по убыванию чтобы TOP-ом показать максимального чемпиона
 */
SELECT TOP 3 C1.Name,
       (SELECT sum(C2.Champion) FROM Country AS C2 WHERE C1.Id = C2.Id) AS Number
FROM Country AS C1
JOIN Continent ON
    C1.ContinentId = Continent.Id
WHERE Continent.Name LIKE N'%европа%'
ORDER BY Number DESC;

-- 4. Отобразить страну, территория которой наибольшая.

/*
 Выбираем страну где площадь является максимальной
 Максимальную площадь получаем некоррелирующим запросом с помощью функции max для столбца Territory
 */
SELECT
    Country.Name AS Country,
    Country.Territory AS Territory
FROM Country
WHERE Country.Territory = (SELECT max(Country.Territory)
                           FROM Country);


-- 5. Отобразить европейскую страну, территория которой наибольшая.
/*
 Выбираем страну с континентом Id1 где площадь является максимальной
 Максимальную площадь получаем некоррелирующим запросом с помощью функции max для столбца Territory и континент = Id1
 */
SELECT
    Country.Name AS Country,
    Country.Territory AS Territory
FROM Country
WHERE Country.Territory = (SELECT max(Country.Territory)
                           FROM Country
                           WHERE Country.ContinentId = 1) AND
    Country.ContinentId = 1;

-- 6. Отобразить по каждому континенту количество стран, которые становились чемпионами мира.

/*
 первый столбец - получаем отсортированный список континентов
 второй столбец - с помощью коррелирующего запроса получаем количество стран с титулами больше 0
 */
SELECT Continent.Name,
       (SELECT count(*)
        FROM Country
        WHERE Country.ContinentId = Continent.Id AND
              Country.Champion > 0)
FROM Continent
ORDER BY Continent.Name;

-- 7. Отобразить для каждого континента суммарное количество чемпионских титулов.
/*
 левая таблица - список континентов
 правая таблица группируем по континентам и получаем количество чемпионских титулов
 */
SELECT
    Continent.Name AS Continent,
    sum(Country.Champion) AS "Number of champions"
FROM Country
JOIN Continent
    ON Country.ContinentId = Continent.Id
GROUP BY Continent.Name;

-- 8. Определить по каждому континенту среднее значение территории для стран, входящих в этот континент.
/*
 левая таблица - список континентов
 правая тадлица - группируем по континентам и функцией avg  получаем среднее столбца Territory. округляем до одного знака
 */
SELECT
    Continent.Name AS Continent,
    round(avg(Country.Territory), 1) AS "Territory average"
FROM Country
JOIN Continent
    ON Country.ContinentId = Continent.Id
GROUP BY Continent.Name;

-- 9. Отобразить количество стран-дебютантов для каждого континента.
/*
 первый столбец - список континентов
 второй столбец - коррелирующий запрос выбираем соответственно где дебютант равен true
 */
SELECT Continent.Name,
       (SELECT count(*)
        FROM Country
        WHERE Country.ContinentId = Continent.Id AND
              Country.Debut = 1)
FROM Continent
ORDER BY Continent.Name;

-- 10. Отобразить для каждого языка количество стран, в которых этот язык является официальным.
/*
 левая таблица - группируем по языку
 правая таблица - countом получаем количество стран
 */
SELECT Name, count(*)
FROM Language
JOIN CountryLanguage
ON Language.Id = CountryLanguage.LanguageId
GROUP BY Name
ORDER BY Name;

-- 11. Отобразить африканскую страну, территория которой наименьшая.
/*
 Присоединяем таблицу континентов для получения их названий
 Первый столбец - страна где континент по шаблону равен африка
 Минимальное значение территории получаем с помощью min
 */
SELECT Country.Name, Country.Territory
FROM Country
JOIN Continent ON
    Country.ContinentId = Continent.Id
WHERE Continent.Name LIKE N'%африка%' AND
      Country.Territory = (SELECT min(Country.Territory)
                            FROM Country
                            JOIN Continent ON
                                Country.ContinentId = Continent.Id
                            WHERE lower(Continent.Name) LIKE N'%африка%')

-- 12. Отобразить для каждой валюты количество стран, в которых эта валюта является национальной.
/*
 Левая таблица - группируем названия валют
 Правая таблица - количество стран
 */
SELECT Currency.Name, count(*)
FROM Currency
JOIN Country ON
    Currency.Id = Country.CurrencyId
GROUP BY Currency.Name
ORDER BY Currency.Name

-- 13. Отобразить наиболее распространенный язык и указать количество стран, в которых он является официальным.
/*
 Объединяем три таблицы Language и Country с помощью промежуточной CountryLanguage
 Группируем по языку и считаем количество стран с помощью count
 TOP выдает первые три записи с распространенными языками
 */
SELECT TOP 3 Language.Name, count(*) AS "Number of countries"
FROM Language
JOIN CountryLanguage ON
    Language.Id = CountryLanguage.LanguageId
JOIN Country ON
    CountryLanguage.CountryId = Country.Id
GROUP BY Language.Name
ORDER BY "Number of countries" DESC;

-- 14. Отобразить континент, у которого самый высокий суммарный показатель по чемпионским титулам.
/*
 Левая таблица - сумма титулов - второй столбец
 Правая таблица - получаем сгруппированные континенты
 Топом выводим максимум по титулам
 */
SELECT TOP 1 Continent.Name, sum(Country.Champion) AS "Numbers of champion"
FROM Country
JOIN Continent ON
    Country.ContinentId = Continent.Id
GROUP BY Continent.Name
ORDER BY "Numbers of champion" DESC ;

-- 15. Отобразить наиболее распространенный язык среди стран европейского и африканского континентов.
/*
 Объединяем 4 таблицы
 Language - получаем имена языков
 CountryLanguage - промежуточная связь с Country
 Country - количество стран
 Continent - для получения имен континентов
 Фильтрация - для поиска европы и африки по шаблону
 Группируем по имени языка и коунтом получаем количество стран
 Топом выводим самый распространенный язык
 */
SELECT TOP 1 Language.Name, count(*) AS "Number of countries"
FROM Language
JOIN CountryLanguage ON
    Language.Id = CountryLanguage.LanguageId
JOIN Country ON
    CountryLanguage.CountryId = Country.Id
JOIN Continent ON
    Country.ContinentId = Continent.Id
WHERE Continent.Name LIKE N'%европа%' OR Continent.Name LIKE N'%африка%'
GROUP BY Language.Name
ORDER BY "Number of countries" DESC;
