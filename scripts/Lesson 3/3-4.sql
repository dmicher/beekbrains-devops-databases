/* ЗАДАНИЕ 4
 * Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае.
 * Месяцы заданы в виде списка английских названий ('may', 'august')
 */

-- Создаёт базу с поддержкой UTF-8 кириллицы
DROP DATABASE IF EXISTS shop_lesson3_task4;
CREATE DATABASE shop_lesson3_task4 CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE shop_lesson3_task4;
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
	(DEFAULT, 'Ольга', '1991-08-01', '2020-06-12 19:30:23', '2020-06-12 19:30:23'), -- август
	(DEFAULT, 'Стас', '1988-10-24', '2020-06-12 19:30:23', '2020-06-12 19:30:23'),
	(DEFAULT, 'Юля', '1988-05-17', '2020-06-12 19:30:23', '2020-06-12 19:30:23'); -- май
SELECT * FROM users;

-- Выполняет задание
SELECT name, DATE_FORMAT(birthday, '%d.%m.%Y') as birthday
FROM users
WHERE
	CASE
		WHEN MONTH(birthday) =  1 THEN 'yanuary'
		WHEN MONTH(birthday) =  2 THEN 'february'
		WHEN MONTH(birthday) =  3 THEN 'march'
		WHEN MONTH(birthday) =  4 THEN 'april'
		WHEN MONTH(birthday) =  5 THEN 'may'
		WHEN MONTH(birthday) =  6 THEN 'june'
		WHEN MONTH(birthday) =  7 THEN 'july'
		WHEN MONTH(birthday) =  8 THEN 'august'
		WHEN MONTH(birthday) =  9 THEN 'september'
		WHEN MONTH(birthday) = 10 THEN 'october'
		WHEN MONTH(birthday) = 11 THEN 'november'
		WHEN MONTH(birthday) = 12 THEN 'dicember'
		ELSE NULL
	END
	IN ('may', 'august'); -- "в виде списка английских названий"

-- Чистит базу и выходит
DROP DATABASE shop_lesson3_task4;
SELECT DATABASE() IS NULL AS `Clear`;