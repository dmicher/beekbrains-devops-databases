/* ЗАДАНИЕ 2
 * Таблица users была неудачно спроектирована. 
 * Записи created_at и updated_at были заданы типом VARCHAR и 
 * в них долгое время помещались значения в формате "20.10.2017 8:10". 
 * Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
 */

-- Создаёт базу с поддержкой UTF-8 кириллицы
DROP DATABASE IF EXISTS shop_lesson3_task2;
CREATE DATABASE shop_lesson3_task2 CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE shop_lesson3_task2;
SELECT DATABASE() AS base;

-- Формирует условия задачи
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	name CHAR(255) COMMENT 'Полное имя покупателя',
	birthday DATE COMMENT 'Дата рождения',
	created_at VARCHAR(32) COMMENT 'Дата создания записи о покупателе', -- ошибочный столбец
	updated_at VARCHAR(32) COMMENT 'Дата последнего обновления записи о покупателе' -- ошибочный столбец
) COMMENT = 'Покупатель в магазине';
INSERT INTO users VALUES
	(DEFAULT, 'Игорь', '1988-01-13', '21.10.2017 8:09', '20.10.2017 8:10'),
	(DEFAULT, 'Ольга', '1991-07-01', '20.10.2017 8:10', '21.10.2017 9:10'),
	(DEFAULT, 'Стас', '1988-10-24', '18.10.2017 8:11', '22.10.2017 10:10'),
	(DEFAULT, 'Юля', '1988-03-01', '19.10.2017 8:12', '23.10.2017 11:10'); 
SELECT * FROM users;

-- Выполняет задание
ALTER TABLE users ADD created_at_tmp DATETIME; -- промежуточные таблицы
ALTER TABLE users ADD updated_at_tmp DATETIME;

UPDATE IGNORE users -- парсит в новые столбцы ранее введённые данные по формату задания
SET created_at_tmp = STR_TO_DATE(created_at, '%d.%m.%Y %H:%i'),
	updated_at_tmp = STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i');

ALTER TABLE users DROP created_at; -- удаляет ошибочные столбца
ALTER TABLE users DROP updated_at;
ALTER TABLE users CHANGE COLUMN created_at_tmp -- форматирует столбцы (в том числе названия)
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP
	COMMENT 'Дата создания записи о покупателе';
ALTER TABLE users CHANGE COLUMN updated_at_tmp 
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP 
	ON UPDATE CURRENT_TIMESTAMP 
	COMMENT 'Дата последнего обновления записи о покупателе';

INSERT INTO users VALUES -- вставляет новое значение для проверки работы
	(DEFAULT, 'Денис', '2001-01-01', DEFAULT, DEFAULT);

SELECT * FROM users;

-- Чистит базу и выходит
DROP DATABASE shop_lesson3_task2;
SELECT DATABASE() IS NULL AS `Clear`;