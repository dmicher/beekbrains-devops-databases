/* ЗАДАНИЕ 3
 * Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
 * Числами Фибоначчи называется последовательность в которой число равно 
 * сумме двух предыдущих чисел. Вызов функции FIBONACCI(10) должен 
 * возвращать число 55.
 */

-- Почитал про алгоритмы вычисления чисел Фибоначчи. https://habr.com/ru/post/261159/
-- Буду реализовывать самое простое.

DROP DATABASE IF EXISTS shop_202007dak_homework;
CREATE DATABASE shop_202007dak_homework;
USE shop_202007dak_homework;
DROP FUNCTION IF EXISTS fibonacci;

DELIMITER //
CREATE FUNCTION fibonacci (num INT)
RETURNS BIGINT
BEGIN
	DECLARE a BIGINT DEFAULT 0;
	DECLARE b BIGINT DEFAULT 1;
	DECLARE res BIGINT DEFAULT 0;
	DECLARE i INT DEFAULT 1;
	
	IF num < 0 || num > 92 THEN -- убираем отрицательные и те, что вызывают преполнение BIGINT
		RETURN -1;
	ELSEIF num = 0 THEN -- результат для 0 и 1 - по определению известны
		RETURN 0;
	ELSEIF num <= 1 THEN
		RETURN 1;
	ELSE  -- остальное - считаем в цикле
		WHILE i < num DO
			SET res = a + b;
			SET a = b;
			SET b = res;
			SET i = i + 1;
		END WHILE;
		RETURN res;
	END IF;
END; //
DELIMITER ;

-- выводим результаты
SELECT fibonacci(-1);
SELECT fibonacci(0);
SELECT fibonacci(1);
SELECT fibonacci(2);
SELECT fibonacci(10);
SELECT fibonacci(50);
SELECT fibonacci(90);
SELECT fibonacci(100);

-- чистим сервер
DROP DATABASE IF EXISTS shop_202007dak_homework;