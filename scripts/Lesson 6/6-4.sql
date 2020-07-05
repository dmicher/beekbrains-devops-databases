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
	find INT NOT NULL, -- флаг, что день не старше 5 дней (не будет использован в запросе - только для удобства чтения)
	created_at DATE NOT NULL
);
INSERT INTO some_days VALUES
	(1, NOW() - INTERVAL (5 + RAND() * 365) DAY), -- несколько старых дней: случайные даты старше 5 и моложе 366 дней
	(1, NOW() - INTERVAL (5 + RAND() * 365) DAY),
	(1, NOW() - INTERVAL (5 + RAND() * 365) DAY),
	(1, NOW() - INTERVAL (5 + RAND() * 365) DAY),
	(1, NOW() - INTERVAL (5 + RAND() * 365) DAY),
	(1, NOW() - INTERVAL (5 + RAND() * 365) DAY),
	(1, NOW() - INTERVAL (5 + RAND() * 365) DAY),
	(1, NOW() - INTERVAL (5 + RAND() * 365) DAY),
	(1, NOW() - INTERVAL (5 + RAND() * 365) DAY),
	(1, NOW() - INTERVAL (5 + RAND() * 365) DAY),
	(0, NOW() - INTERVAL (RAND() * 4) DAY), -- не старые дни: случайные даты от сегодня до 5 дней
	(0, NOW() - INTERVAL (RAND() * 4) DAY),
	(0, NOW() - INTERVAL (RAND() * 4) DAY),
	(1, NOW() - INTERVAL (5 + RAND() * 365) DAY), -- и ещё несколько старых дней
	(1, NOW() - INTERVAL (5 + RAND() * 365) DAY),
	(1, NOW() - INTERVAL (5 + RAND() * 365) DAY),
	(1, NOW() - INTERVAL (5 + RAND() * 365) DAY);

SELECT 
	IF(find = 0, '', 'Да') AS 'Старый?',
	created_at AS 'Дата'
FROM some_days;

-- Выполняет задание
DELETE FROM some_days
WHERE created_at + INTERVAL 5 DAY < DATE_FORMAT(NOW(), '%Y-%m-%d');

SELECT 
	IF(find = 0, '', 'Да') AS 'Старый?',
	created_at AS 'Дата'
FROM some_days;