/* ЗАДАНИЕ 1
 * Подсчитайте средний возраст пользователей в таблице users.
 */
 
 -- Создаёт базу с поддержкой UTF-8 кириллицы
DROP DATABASE IF EXISTS shop_lesson4_task1_04072020_dak;
CREATE DATABASE shop_lesson4_task1_04072020_dak CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE shop_lesson4_task1_04072020_dak;
SELECT DATABASE() AS base;

-- Формирует условия задачи
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	name CHAR(255) COMMENT 'Полное имя покупателя',
	birthday DATE COMMENT 'Дата рождения',
	created DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи о покупателе',
	updated DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата последнего обновления записи о покупателе',
	INDEX index_of_birthday(birthday)
) COMMENT = 'Покупатель в магазине';
INSERT INTO users VALUES
	(DEFAULT, 'Игорь',		'1990-01-01', DEFAULT, DEFAULT),
	(DEFAULT, 'Ольга',		'1991-02-02', DEFAULT, DEFAULT),
	(DEFAULT, 'Сева',		'1992-03-03', DEFAULT, DEFAULT),
	(DEFAULT, 'Ирина',		'1993-04-04', DEFAULT, DEFAULT),
	(DEFAULT, 'Константин',	'1994-05-05', DEFAULT, DEFAULT),
	(DEFAULT, 'Ульяна',		'1995-06-10', DEFAULT, DEFAULT),
	(DEFAULT, 'Владислав',	'1996-07-11', DEFAULT, DEFAULT),
	(DEFAULT, 'Марина',		'1997-08-12', DEFAULT, DEFAULT),
	(DEFAULT, 'Егор',		'1998-09-13', DEFAULT, DEFAULT),
	(DEFAULT, 'Татьяна',	'1999-10-14', DEFAULT, DEFAULT),
	(DEFAULT, 'Василий',	'2000-11-15', DEFAULT, DEFAULT),
	(DEFAULT, 'Нина',		'2000-12-20', DEFAULT, DEFAULT);
SELECT id, name, birthday FROM users;

/* Выполняет задание:
 * - получает разницу между двумя датами в количестве дней;
 * - превращает её в разницу дат по формату ГГГГ-ММ-ДД;
 * - вытаскивает оттуда количество годов;
 * - находит среднее значение;
 * - округляет его до первого знака после запятой.
 */
SELECT ROUND(AVG(YEAR(FROM_DAYS(DATEDIFF(NOW(), birthday)))), 1) AS averege_age FROM users;


-- Чистит базу и выходит
DROP DATABASE shop_lesson4_task1_04072020_dak;
SELECT DATABASE() IS NULL AS `Clear`;