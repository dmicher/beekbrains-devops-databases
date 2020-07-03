/* ЗАДАНИЕ 3
 * В таблице складских запасов storehouses_products в поле value могут встречаться
 * самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. 
 * Необходимо отсортировать записи таким образом, чтобы они выводились в порядке 
 * увеличения значения value. Нулевые запасы должны выводиться в конце, после всех записей.
 */

-- Создаёт базу с поддержкой UTF-8 кириллицы
DROP DATABASE IF EXISTS shop_lesson3_task3;
CREATE DATABASE shop_lesson3_task3 CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE shop_lesson3_task3;
SELECT DATABASE() AS base;

-- Формирует условия задачи
DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
	id SERIAL PRIMARY KEY,
	storehouse_id INT UNSIGNED COMMENT 'Склад, на котором расположен указанный товар',
	product_id INT UNSIGNED COMMENT 'Товар, расположенный на указанном складе',
	`value` INT UNSIGNED COMMENT 'Количество указаннных товаров на указанном складе',
	created DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи об остатке товара на складе',
	updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления записи об остатке товара на складе',
	INDEX index_of_value(value)
) COMMENT = 'Остатки товаров на складах (связывает склады и товары на них)';
INSERT INTO storehouses_products VALUES 
	(DEFAULT, 1, 1, 12, DEFAULT, DEFAULT), -- для просторы внешних таблиц и ключей к ним нет
	(DEFAULT, 1, 2, 0, DEFAULT, DEFAULT),
	(DEFAULT, 1, 3, 7, DEFAULT, DEFAULT),
	(DEFAULT, 1, 4, 20, DEFAULT, DEFAULT),
	(DEFAULT, 1, 5, 19, DEFAULT, DEFAULT),
	(DEFAULT, 2, 5, 0, DEFAULT, DEFAULT),
	(DEFAULT, 2, 4, 6, DEFAULT, DEFAULT),
	(DEFAULT, 2, 3, 1, DEFAULT, DEFAULT),
	(DEFAULT, 2, 2, 10, DEFAULT, DEFAULT),
	(DEFAULT, 2, 1, 2, DEFAULT, DEFAULT);
SELECT '' as `start `, storehouse_id AS s_id, product_id AS p_id, `value` AS `count`
FROM storehouses_products;

-- Выполняет задание
SELECT '' as `result`, storehouse_id AS s_id, product_id AS p_id, `value` AS `count`
FROM storehouses_products
ORDER BY `value` = 0, -- 'false' = 0 (что-то осталось), затем: 'true' = 1 (остатоков нет)
		`value`; -- остальные значения сортирует по возрастанию

-- Чистит базу и выходит
DROP DATABASE shop_lesson3_task3;
SELECT DATABASE() IS NULL AS `Clear`;