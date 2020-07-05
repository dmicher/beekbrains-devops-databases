/* ЗАДАНИЕ 3
 * Пусть имеется таблица с календарным полем created_at. 
 * В ней размещены разряженые календарные записи за август 2018 года
 * '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. 
 * Составьте запрос, который выводит полный список дат за август, 
 * выставляя в соседнем поле значение 1, если дата присутствует в 
 * исходном таблице и 0, если она отсутствует.
 */

-- Требуется инициализация баз данных по скрипту № 0 (создаёт shop & sample, shop заполняет данными)

-- Воссоздаёт условия задачи
USE sample_202007dak_homework;

DROP TABLE IF EXISTS some_days; -- таблица с некоторыми датами
CREATE TABLE some_days (
	created_at DATE NOT NULL
);

INSERT INTO some_days VALUES 
	('2018-08-01'),
	('2016-08-04'), -- здесь проверка на внимательность в задании: другой год (тоже должен попасть)
	('2018-08-16'),
	('2018-08-17');

-- РЕШЕНИЕ

DROP TABLE IF EXISTS all_august_days; -- создаёт временную таблицу
CREATE TEMPORARY TABLE all_august_days ( 
	`date` DATE NOT NULL,
	`any` INT DEFAULT 0
);

-- Следующее "колдунство" - это процедура (пройдём чуть позже). Она нужна мне, чтобы 
-- добавить и заполнить строки в таблице простым циклом. Можно вручную добавить даты, 
-- мне было лень, да и так надёжнее, а циклы нельзя использовать вне поцедур.

DROP PROCEDURE IF EXISTS insert_into_all_days;
DELIMITER //
CREATE PROCEDURE insert_into_all_days()
	BEGIN
		DECLARE end_day DATE;
		DECLARE current_day DATE;
		
		SET current_day = CONCAT(YEAR(NOW()), '-08-01');
		SET end_day = CONCAT(YEAR(NOW()), '-09-01');
		
		WHILE current_day < end_day DO
			INSERT INTO all_august_days (`date`) VALUES (current_day);
			SET current_day := current_day + INTERVAL 1 DAY;
		END WHILE;
	END; //
DELIMITER ;
-- delimiter-ом временно задали другой знак для конца ввода SQL запроса (потом, вернули назад),
-- чтобы знаки точки с запятой (;) преждевременно не прекращали ввод создаваемой процедуры в команду

CALL insert_into_all_days(); -- вызываем процедуру и удаляем её (она больше не нужна)
DROP PROCEDURE IF EXISTS insert_into_all_days;

-- Обновляет временную таблицу, чтобы все дни за все года попали в неё и подняли флаг на 1
UPDATE all_august_days SET `any` = 1 
WHERE `date` = ANY 
	(SELECT CONCAT(YEAR(NOW()), DATE_FORMAT(created_at, '-%m-%d')) -- привожу всё к текущему году
	FROM some_days);

-- сам запрос: выводит дату без года и "да", если хоть в один год есть совпадающая дата из some_days
SELECT 
	DATE_FORMAT(`date`, '%d.%m') AS 'Дата',
	IF(`any` = 1, 'Да', '') AS 'Есть?'
FROM all_august_days;

-- очищает базу от лишнего мусора
-- временная таблица all_august_days удалится после закрытия соединения