/* ЗАДАНИЕ 2
 *  Создайте SQL-запрос, который помещает в таблицу users миллион записей.
 */

-- Требуется инициализация базы данных скриптом № 1

USE shop_202007dak_homework;

DROP PROCEDURE IF EXISTS create_million_users;

DELIMITER //

CREATE PROCEDURE create_million_users()
BEGIN
	DECLARE i INT DEFAULT 0;
	WHILE i < 1000 DO
		INSERT INTO users (name) VALUES -- ниже находится 1000 записей: это позволит запросу выполниться быстрее, чем вызов INSERT "по одному"
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'),
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'),
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'),
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'),
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'),
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'),
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'),
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'),
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'),
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), 
			('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'), ('user'); 
		SET i = i + 1;
	END WHILE;
END; //
DELIMITER ;

SELECT 'Этот запрос может выполняться несолько минут (около 2-3)' AS 'А ТЕПЕРЬ НАБЕРИТЕСЬ ТЕРПЕНИЯ';
SELECT NOW() AS 'Старт процедуры', COUNT(*) AS 'Количество пользователей' FROM users;

CALL create_million_users();

SELECT NOW() AS 'Пересчёт пользователей';
SELECT NOW() AS 'Конец сприпта', COUNT(*) AS 'Количество пользователей'  FROM users;

DROP PROCEDURE IF EXISTS create_million_users;