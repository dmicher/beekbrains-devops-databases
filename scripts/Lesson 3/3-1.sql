/* ЗАДАНИЕ 1
 * Пусть в таблице users поля created_at и updated_at оказались незаполненными.
 * Заполните их текущими датой и временем.
 */

-- Создаёт базу с поддержкой UTF-8 кириллицы
DROP DATABASE IF EXISTS shop_lesson3_task1;
CREATE DATABASE shop_lesson3_task1 CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE shop_lesson3_task1;
SELECT DATABASE() AS base;

-- Формирует условия задачи
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	name CHAR(255) COMMENT 'Полное имя покупателя',
	birthday DATE COMMENT 'Дата рождения',
	created_at DATETIME DEFAULT NULL COMMENT 'Дата создания записи о покупателе',
	updated_at DATETIME DEFAULT NULL COMMENT 'Дата последнего обновления записи о покупателе'
) COMMENT = 'Покупатель в магазине';
INSERT INTO users VALUES
	(DEFAULT, 'Игорь', '1988-01-13', '2020-06-12 19:30:23', '2020-06-12 19:30:23'),
	(DEFAULT, 'Ольга', '1991-07-01', NULL, NULL), -- ошибочные данные
	(DEFAULT, 'Стас', '1988-10-24', NULL, NULL), -- ошибочные данные
	(DEFAULT, 'Юля', '1988-03-01', NULL, NULL); -- ошибочные данные
SELECT * FROM users;

-- Выполняет задание
UPDATE users 
SET created_at = NOW(), updated_at = NOW() 
WHERE created_at IS NULL AND updated_at IS NULL;
SELECT * FROM users;

-- Чистит базу и выходит
DROP DATABASE shop_lesson3_task1;
SELECT DATABASE() IS NULL AS `Clear`;