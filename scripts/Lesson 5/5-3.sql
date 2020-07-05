/* ЗАДАНИЕ 3
 * Есть таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
 * Поля from, to и label содержат английские названия городов, поле name — русское. 
 * Выведите список рейсов (flights) с русскими названиями городов.
 */
 
-- Создаёт условия задачи
DROP DATABASE IF EXISTS shop_202007dak_homework_addon;
CREATE DATABASE shop_202007dak_homework_addon CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE shop_202007dak_homework_addon;
SELECT DATABASE() AS 'БАЗА ДАННЫХ';

CREATE TABLE cities (
	label CHAR(3) PRIMARY KEY COMMENT 'Метка города (на английском)',
	name CHAR(64) NOT NULL COMMENT 'Название города на русском'
) COMMENT 'Города для полётов';

INSERT INTO cities VALUES 
	('msk', 'Москва'),
	('spb', 'Санкт-Петербург'),
	('nyc', 'Нью-Йорк'),
	('prs', 'Париж'),
	('pkn', 'Пекин');
	
CREATE TABLE flights (
	id SERIAL PRIMARY KEY,
	`from` CHAR(3) NOT NULL COMMENT 'Метка города вылета',
	`to` CHAR(3) NOT NULL COMMENT 'Метка города прилёта',
	CONSTRAINT fk_flights_to_from_label FOREIGN KEY (`from`) REFERENCES cities(label),
	CONSTRAINT fk_flights_to_to_label FOREIGN KEY (`to`) REFERENCES cities(label)
) COMMENT 'Зарегистрированные полёты';

INSERT INTO flights VALUES
	(NULL, 'msk', 'spb'),
	(NULL, 'spb', 'msk'),
	(NULL, 'msk', 'nyc'),
	(NULL, 'nyc', 'msk'),
	(NULL, 'msk', 'prs'),
	(NULL, 'prs', 'msk'),
	(NULL, 'msk', 'pkn'),
	(NULL, 'pkn', 'msk');

-- получает рейсы
SELECT 
	f.id AS 'Рейс №', 
	cf.name AS 'Из города', 
	ct.name AS 'В город'
FROM flights f
	INNER JOIN cities cf ON f.`from` = cf.label
	INNER JOIN cities ct ON f.`to` = ct.label
ORDER BY f.id;





















