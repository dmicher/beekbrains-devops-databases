/* ЗАДАНИЕ 3
 * Подсчитайте произведение чисел в столбце таблицы.
 */
 
 -- Создаёт базу с поддержкой UTF-8 кириллицы
DROP DATABASE IF EXISTS shop_lesson4_task3_04072020_dak;
CREATE DATABASE shop_lesson4_task3_04072020_dak CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE shop_lesson4_task3_04072020_dak;
SELECT DATABASE() AS base;

-- Формирует условия задачи
DROP TABLE IF EXISTS test;
CREATE TABLE test (
	nums INT COMMENT 'Некоторые целые числа для проведения операции'
) COMMENT = 'Таблица для умножения чисел';
INSERT INTO test VALUES	
	(1 + RAND() * 9), -- несколько случайных целых чисел от 1 до 10
	(1 + RAND() * 9),
	(1 + RAND() * 9),
	(1 + RAND() * 9),
	(1 + RAND() * 9);
SELECT * FROM test;

/* Выполняет задание:
 * Матан был давно, поэтому "гуглим". Поиск информации - это норма.
 * Нужный алгоритм находим, например, тут: https://devmark.ru/article/product-all-numbers
 * Только к статье есть замечания:
 * 1. В этой статье не отмечено, но это стоит знать: расчёт ln и exp не обеспечивают точность, 
 *    а также могут привести к переполнению формата числа. Но в пределах нашего примера это допустимо.
 * 2. Результат округляем до целого числа, поскольку произведение целых чисел - всегда целое число,
 *    а точность (как сказал в пункте 1) была потеряна, и число будет не целым.
 */
SELECT ROUND(EXP(SUM(LN(nums)))) AS product from test;

-- Чистит базу и выходит
DROP DATABASE shop_lesson4_task3_04072020_dak;
SELECT DATABASE() IS NULL AS `Clear`;