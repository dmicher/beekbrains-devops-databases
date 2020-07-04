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
	(DEFAULT, 'Игорь',		'1991-01-01', DEFAULT, DEFAULT),
	(DEFAULT, 'Ольга',		'1992-02-02', DEFAULT, DEFAULT),
	(DEFAULT, 'Сева',		'1993-03-03', DEFAULT, DEFAULT),
	(DEFAULT, 'Ирина',		'1994-04-04', DEFAULT, DEFAULT),
	(DEFAULT, 'Константин',	'1995-05-05', DEFAULT, DEFAULT),
	(DEFAULT, 'Ульяна',		'1996-06-06', DEFAULT, DEFAULT),
	(DEFAULT, 'Владислав',	'1997-07-07', DEFAULT, DEFAULT),
	(DEFAULT, 'Марина',		'1998-08-08', DEFAULT, DEFAULT),
	(DEFAULT, 'Егор',		'1999-09-09', DEFAULT, DEFAULT),
	(DEFAULT, 'Татьяна',	'2000-10-10', DEFAULT, DEFAULT),
	(DEFAULT, 'Василий',	'2001-11-11', DEFAULT, DEFAULT),
	(DEFAULT, 'Нина',		'2002-12-12', DEFAULT, DEFAULT);
SELECT id, name, birthday FROM users;

/* Выполняет задание:
 * 1. определяет день недели, как дату, полученную от склейки строки, остоящей из:
 *    - года текущего времени-даты,
 *    - месяца и даты дня рождения каждого пользвоателя;
 * Преобразует полученное числовое значение в кириллическое название дня недели;
 * 2. группирует результат по дням недели, подсчитывая количество соответствующих записей;
 * 3. также выводит всех пользователей с днями рождения в эти дни в одной строке;
 * 4. сортирует данные по дням недели в соответствии с естетсвенным расположением их в неделе.
 */
SELECT 
	CASE -- 1
		WHEN WEEKDAY(DATE_FORMAT(birthday, CONCAT(YEAR(NOW()), '-%m-%d'))) = 1 THEN 'Понедельник'
		WHEN WEEKDAY(DATE_FORMAT(birthday, CONCAT(YEAR(NOW()), '-%m-%d'))) = 2 THEN 'Вторник'
		WHEN WEEKDAY(DATE_FORMAT(birthday, CONCAT(YEAR(NOW()), '-%m-%d'))) = 3 THEN 'Среда'
		WHEN WEEKDAY(DATE_FORMAT(birthday, CONCAT(YEAR(NOW()), '-%m-%d'))) = 4 THEN 'Четверг'
		WHEN WEEKDAY(DATE_FORMAT(birthday, CONCAT(YEAR(NOW()), '-%m-%d'))) = 5 THEN 'Пятница'
		WHEN WEEKDAY(DATE_FORMAT(birthday, CONCAT(YEAR(NOW()), '-%m-%d'))) = 6 THEN 'Суббота'
		WHEN WEEKDAY(DATE_FORMAT(birthday, CONCAT(YEAR(NOW()), '-%m-%d'))) = 7 THEN 'Воскресенье'
		ELSE NULL
	END AS week_day,
	COUNT(*) AS `birthdays`, -- 2
	GROUP_CONCAT(name ORDER BY name SEPARATOR ', ') AS `users` -- 3
 FROM users
 GROUP BY week_day  -- 2
 ORDER BY FIELD(week_day, 'Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота', 'Воскресенье'); -- 4

-- Чистит базу и выходит
DROP DATABASE shop_lesson4_task2_04072020_dak;
SELECT DATABASE() IS NULL AS `Clear`;