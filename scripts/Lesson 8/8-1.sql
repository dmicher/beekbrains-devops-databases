/* ЗАДАНИЕ 1
 * Создайте хранимую функцию hello(), которая будет возвращать приветствие, 
 * в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна 
 * возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать 
 * фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — 
 * "Доброй ночи".
 */

DROP DATABASE IF EXISTS shop_202007dak_homework;
CREATE DATABASE shop_202007dak_homework;
USE shop_202007dak_homework;

-- готовимся
SET GLOBAL log_bin_trust_function_creators = 1; -- игнорируем ошибку на бессмысленную функцию ERROR 1418 (HY000)

-- Создаём функцию
DELIMITER //
CREATE FUNCTION hello()
RETURNS TEXT
BEGIN
	DECLARE h INT DEFAULT HOUR(NOW());
	IF (h < 6) THEN
		RETURN 'Доброй ночи';
	ELSEIF (h < 12)  THEN
		RETURN 'Доброе утро';
	ELSEIF (h < 18) THEN
		RETURN  'Добрый день';
	ELSE
		RETURN'Добрый вечер';
	END IF;
END; //
DELIMITER ;

-- проверяем результат - вызываем функцию
SELECT hello() AS 'Приветствие';

-- Подчищаем хвосты
DROP DATABASE IF EXISTS shop_202007dak_homework;