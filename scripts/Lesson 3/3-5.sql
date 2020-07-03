/* ЗАДАНИЕ 5
 * Из таблицы catalogs извлекаются записи при помощи запроса: 
 * SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
 * Отсортируйте записи в порядке, заданном в списке IN.
 */

-- Создаёт базу с поддержкой UTF-8 кириллицы
DROP DATABASE IF EXISTS shop_lesson3_task5;
CREATE DATABASE shop_lesson3_task5 CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE shop_lesson3_task5;
SELECT DATABASE() AS base;

-- Формирует условия задачи
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
	id SERIAL PRIMARY KEY,
	name CHAR(128) COMMENT 'Название раздела',
	UNIQUE unique_name(name(10))
) COMMENT = 'Разделы товаров';
INSERT INTO catalogs VALUES
	(DEFAULT, 'Процессоры'), 
	(DEFAULT, 'Материнские платы'), 
	(DEFAULT, 'Оперативная память'), 
	(DEFAULT, 'Жёсткие диски'), 
	(DEFAULT, 'Блоки питания');
SELECT '' as `start`, id, name FROM catalogs WHERE id IN (5, 1, 2);

-- Выполняет задание
SELECT '' as `result`, id, name FROM catalogs WHERE id IN (5, 1, 2) -- по заданию
ORDER BY FIELD(id, 5, 1, 2); -- ответ

-- Чистит базу и выходит
DROP DATABASE shop_lesson3_task5;
SELECT DATABASE() IS NULL AS `Clear`;