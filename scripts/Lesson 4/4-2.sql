/* ЗАДАНИЕ 2
 * Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
 * Следует учесть, что необходимы дни недели текущего года, а не года рождения.
 */
 
 -- Создаёт базу с поддержкой UTF-8 кириллицы
DROP DATABASE IF EXISTS shop_lesson4_task2_04072020_dak;
CREATE DATABASE shop_lesson4_task2_04072020_dak CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE shop_lesson4_task2_04072020_dak;
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
	(DEFAULT, 'Игорь', '1990-01-01', DEFAULT, DEFAULT),
	(DEFAULT, 'Ольга', '1991-02-02', DEFAULT, DEFAULT),
	(DEFAULT, 'Сева', '1992-03-03', DEFAULT, DEFAULT),
	(DEFAULT, 'Ирина', '1993-04-04', DEFAULT, DEFAULT),
	(DEFAULT, 'Константин', '1994-05-05', DEFAULT, DEFAULT),
	(DEFAULT, 'Ульяна', '1995-06-10', DEFAULT, DEFAULT),
	(DEFAULT, 'Владислав', '1996-07-11', DEFAULT, DEFAULT),
	(DEFAULT, 'Марина', '1997-08-12', DEFAULT, DEFAULT),
	(DEFAULT, 'Егор', '1998-09-13', DEFAULT, DEFAULT),
	(DEFAULT, 'Татьяна', '1999-10-14', DEFAULT, DEFAULT),
	(DEFAULT, 'Василий', '2000-11-15', DEFAULT, DEFAULT),
	(DEFAULT, 'Нина', '2001-12-20', DEFAULT, DEFAULT);
SELECT id, name, birthday FROM users;

/* Выполняет задание:
WEEKDAY(DATE_FORMAT(birthday, CONCAT(YEAR(NOW()), '-%m-%d')))
 */
SELECT 
	CASE
		WHEN WEEKDAY(DATE_FORMAT(birthday, CONCAT(YEAR(NOW()), '-%m-%d'))) = 1 THEN 'Понедельник'
		WHEN WEEKDAY(DATE_FORMAT(birthday, CONCAT(YEAR(NOW()), '-%m-%d'))) = 2 THEN 'Вторник'
		WHEN WEEKDAY(DATE_FORMAT(birthday, CONCAT(YEAR(NOW()), '-%m-%d'))) = 3 THEN 'Среда'
		WHEN WEEKDAY(DATE_FORMAT(birthday, CONCAT(YEAR(NOW()), '-%m-%d'))) = 4 THEN 'Четверг'
		WHEN WEEKDAY(DATE_FORMAT(birthday, CONCAT(YEAR(NOW()), '-%m-%d'))) = 5 THEN 'Пятница'
		WHEN WEEKDAY(DATE_FORMAT(birthday, CONCAT(YEAR(NOW()), '-%m-%d'))) = 6 THEN 'Суббота'
		WHEN WEEKDAY(DATE_FORMAT(birthday, CONCAT(YEAR(NOW()), '-%m-%d'))) = 7 THEN 'Воскресенье'
		ELSE NULL
	END
	AS day_of_week,
	COUNT(*)
 FROM users
 GROUP BY day_of_week;
-- todo ЗАКОНЧИЛ ТУТ: доделать сортировку подням недели

-- Чистит базу и выходит
DROP DATABASE shop_lesson4_task2_04072020_dak;
SELECT DATABASE() IS NULL AS `Clear`;