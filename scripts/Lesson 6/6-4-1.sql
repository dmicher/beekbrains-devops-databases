/* ЗАДАЧА 4
 * Пусть имеется любая таблица с календарным полем created_at.
 * Создайте запрос, который удаляет устаревшие записи из таблицы, 
 * оставляя только 5 самых свежих записей.
 */

-- Требуется инициализация баз данных по скрипту № 0 (создаёт shop & sample, shop заполняет данными)

-- Воссоздаёт условия задачи
USE sample_202007dak_homework;
DROP TABLE IF EXISTS some_days; -- таблица с некоторыми датами
CREATE TABLE some_days (
	id SERIAL PRIMARY KEY,
	created_at DATE NOT NULL
);
INSERT INTO some_days VALUES
	(NULL, NOW() - INTERVAL (RAND() * 30) DAY), -- несколько случайных дат от "сегодня" до 31 дня
	(NULL, NOW() - INTERVAL (RAND() * 30) DAY),
	(NULL, NOW() - INTERVAL (RAND() * 30) DAY),
	(NULL, NOW() - INTERVAL (RAND() * 30) DAY),
	(NULL, NOW() - INTERVAL (RAND() * 30) DAY),
	(NULL, NOW() - INTERVAL (RAND() * 30) DAY),
	(NULL, NOW() - INTERVAL (RAND() * 30) DAY),
	(NULL, NOW() - INTERVAL (RAND() * 30) DAY),
	(NULL, NOW() - INTERVAL (RAND() * 30) DAY),
	(NULL, NOW() - INTERVAL (RAND() * 30) DAY),
	(NULL, NOW() - INTERVAL (RAND() * 30) DAY),
	(NULL, NOW() - INTERVAL (RAND() * 30) DAY),
	(NULL, NOW() - INTERVAL (RAND() * 30) DAY),
	(NULL, NOW() - INTERVAL (RAND() * 30) DAY);

SELECT * FROM some_days ORDER BY id; -- все даты
SELECT * FROM some_days ORDER BY id DESC LIMIT 5; -- даты, которые должны остаться
SELECT @qw := MIN(id) from (SELECT * FROM some_days ORDER BY id DESC LIMIT 5, 1) as t group by id; -- id записи для удаления
DELETE FROM some_days WHERE id <= @qw; -- удаляет записи
SELECT *  FROM some_days ORDER BY id;