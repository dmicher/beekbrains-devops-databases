-- ЗАДАНИЕ 3

-- в базе sample чем-то заполненаня таблица
DROP TABLE IF EXISTS sample.cat;
CREATE TABLE sample.cat (
	-- Усложним задачу: таблицы совпадают не полностью
	name CHAR(128),
	id SERIAL PRIMARY KEY,
	`comment` CHAR(24) DEFAULT NULL
);
INSERT INTO sample.cat VALUES ('Название под замену', DEFAULT, 'Какой-то комментарий');
SELECT * FROM sample.cat;

-- ожидаем, что задание 1 урока 2 выполнено:
SELECT * FROM shop.catalogs;

-- вставка с заменой по дублированным значениям:
INSERT INTO sample.cat 
SELECT name, id, NULL -- NULL для последнего столбца sample.cat
FROM shop.catalogs
ON DUPLICATE KEY UPDATE sample.cat.name = shop.catalogs.name;

SELECT * FROM sample.cat;