-- ЗАДАНИЕ 1

-- исходные данные: заполненная таблица
INSERT IGNORE INTO catalogs VALUES
	(DEFAULT, 'Процессоры'),
	(DEFAULT, NULL),
	(DEFAULT, NULL),
	(DEFAULT, 'Материнские платы'),
	(DEFAULT, 'Видеокарты'),
	(DEFAULT, NULL);
SELECT * FROM catalogs;

-- из-за ключа unique_name будет 1 замена (без IGNORE 0 замен)
UPDATE IGNORE catalogs SET name = 'empty' WHERE name IS NULL;
SELECT * FROM catalogs;
-- избавляется от контроля уникальности, проводит остальные замены
ALTER TABLE catalogs DROP INDEX unique_name;
UPDATE catalogs SET name = 'empty' WHERE name IS NULL;
SELECT * FROM catalogs;


