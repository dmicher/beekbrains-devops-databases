/* ЗАДАНИЕ 2
 * Есть таблица (accounts), включающая в себя три столбца: id, name, password, 
 * которые содержат первичный ключ, имя пользователя и его пароль. 
 * Создайте представление username таблицы accounts, предоставляющее доступ к 
 * столбцам id и name. Создайте пользователя user_read, который бы не имел доступа к 
 * таблице accounts, однако мог извлекать записи из представления username.
 */

-- Требуется инициализация базы данных shop_202007dak_homework скриптом № 0
-- скрипт выполнять от пользователя root
USE shop_202007dak_homework;

-- воссоздаёт условия
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
	id SERIAL PRIMARY KEY,
	name CHAR(32) NOT NULL COMMENT 'Имя пользователя',
	password CHAR(32) NOT NULL COMMENT 'Пароль пользователя'
) COMMENT 'Учётные записи пользователей';

INSERT INTO accounts (name, password) VALUES 
	('Иванов Иван Иванович', '111'),
	('Елизаветова Елизавета Елизаровна', '222'),
	('Самсонов Самсон Самсонович', '333');

-- представление данных о пользователях
CREATE VIEW username (`user`, id) AS SELECT name, id FROM accounts;
SELECT * FROM username;

-- выделяет права доступа к представлению, не содержащему пароли, с правом чления, но без права записи
CREATE USER IF NOT EXISTS user_read IDENTIFIED WITH sha256_password BY 'qwerty123';
GRANT SELECT ON username TO user_read;

/* КОМАНДЫ И ЧАСТИЧНЫЙ ВЫВОД КОНСОЛИ ДЛЯ ПРОВЕРКИ ЗАДАНИЯ:
 * mysql> show grants for user_read@'%';
 * +-------------------------------------------------------------------------+
 * | Grants for user_read@%                                                  |
 * +-------------------------------------------------------------------------+
 * | GRANT USAGE ON *.* TO `user_read`@`%`                                   |
 * | GRANT SELECT ON `shop_202007dak_homework`.`username` TO `user_read`@`%` |
 * +-------------------------------------------------------------------------+
 * 2 rows in set (0.00 sec)
 *
 * mysql> \q
 * Bye
 * 
 * ...> mysql shop_202007dak_homework -u user_read -p
 * Enter password: *********
 * Welcome to the MySQL...
 * 
 * mysql> select user(), database();
 * +---------------------+-------------------------+
 * | user()              | database()              |
 * +---------------------+-------------------------+
 * | user_read@localhost | shop_202007dak_homework |
 * +---------------------+-------------------------+
 * 1 row in set (0.00 sec)
 * 
 * mysql> select * from accounts;
 * ERROR 1142 (42000): SELECT command denied to user 'user_read'@'localhost' for table 'accounts'
 * 
 * mysql> select * from username;
 * +----------------------------------------------------------------+----+
 * | user                                                           | id |
 * +----------------------------------------------------------------+----+
 * | Иванов Иван Иванович                                           |  1 |
 * | Елизаветова Елизавета Елизаровна                               |  2 |
 * | Самсонов Самсон Самсонович                                     |  3 |
 * +----------------------------------------------------------------+----+
 * 3 rows in set (0.00 sec)
 * 
 * mysql> insert into username values ('Ольгова Ольга Олеговна', null);
 * ERROR 1142 (42000): INSERT command denied to user 'user_read'@'localhost' for table 'username'
 */