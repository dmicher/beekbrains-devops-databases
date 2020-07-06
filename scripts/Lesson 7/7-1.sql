/* ЗАДАНИЕ 1
 *  Создайте двух пользователей которые имеют доступ к базе данных shop.
 * Первому пользователю shop_read должны быть доступны только запросы на чтение данных, 
 * второму пользователю shop — любые операции в пределах базы данных shop.
 */

-- Требуется инициализация базы данных shop_202007dak_homework скриптом № 0
-- скрипт выполнять от пользователя root
use shop_202007dak_homework;

CREATE USER IF NOT EXISTS shop IDENTIFIED WITH sha256_password BY 'qwerty123';
CREATE USER IF NOT EXISTS shop_read IDENTIFIED WITH sha256_password BY 'qwerty123';

GRANT USAGE, SELECT, INSERT, DELETE, UPDATE ON shop_202007dak_homework.* TO shop; -- все операции, кроме изменения структуры таблиы (для этого есть пользователь root)
GRANT USAGE, SELECT ON shop_202007dak_homework.* TO shop_read; -- только чтение

/* КОМАНДЫ И ЧАСТИЧНЫЙ ВЫВОД КОНСОЛИ ДЛЯ ПРОВЕРКИ ЗАДАНИЯ:
 * mysql> show grants for shop@'%';
 * +-----------------------------------------------------------------------------------+
 * | Grants for shop@%                                                                 |
 * +-----------------------------------------------------------------------------------+
 * | GRANT USAGE ON *.* TO `shop`@`%`                                                  |
 * | GRANT SELECT, INSERT, UPDATE, DELETE ON `shop_202007dak_homework`.* TO `shop`@`%` |
 * +-----------------------------------------------------------------------------------+
 * 2 rows in set (0.00 sec)
 *
 * mysql > \q
 * Bye
 * 
 * ..> mysql shop_202007dak_homework -u shop -p
 * Enter password: *********
 * Welcome to the MySQL... 
 * 
 * mysql> select user();
 * +----------------+
 * | user()         |
 * +----------------+
 * | shop@localhost |
 * +----------------+
 * 1 row in set (0.00 sec)
 * 
 * mysql> select id, name from users;
 * +----+----------------------------------------------------------------------------+
 * | id | name                                                                       |
 * +----+----------------------------------------------------------------------------+
 * |  1 | Иванов Иван Иванович                                                       |
 * |  2 | Александровна Александра Александровна                                     |
 * |  3 | Евгениев Евгений Евгениевич                                                |
 * |  4 | Олегова Ольга Олеговна                                                     |
 * |  5 | Тимофеев Тимофей Тимофеевич                                                |
 * |  6 | Юлианова Юлия Юлиановна                                                    |
 * +----+----------------------------------------------------------------------------+
 * 6 rows in set (0.00 sec)
 * 
 * mysql> insert into users (name, birthday) values ('Кошемиров Кошемир Кошемирович', '2001-01-01');
 * Query OK, 1 row affected (0.00 sec)
 * 
 * mysql> select id, name from users where id > 6;
 * +----+----------------------------------------------------------+
 * | id | name                                                     |
 * +----+----------------------------------------------------------+
 * |  7 | Кошемиров Кошемир Кошемирович                            |
 * +----+----------------------------------------------------------+
 * 1 row in set (0.00 sec)
 * 
 * mysql > \q
 * Bye
 * 
 * mysql shop_202007dak_homework -u shop_read -p
 * Enter password: *********
 * Welcome to the MySQL ...
 * 
 * mysql> select user();
 * +---------------------+
 * | user()              |
 * +---------------------+
 * | shop_read@localhost |
 * +---------------------+
 * 1 row in set (0.00 sec)
 * 
 * mysql> select id, name from users where id > 6;
 * +----+----------------------------------------------------------+
 * | id | name                                                     |
 * +----+----------------------------------------------------------+
 * |  7 | Кошемиров Кошемир Кошемирович                            |
 * +----+----------------------------------------------------------+
 * 1 row in set (0.00 sec)
 * 
 * mysql> delete from users where id > 6;
 * ERROR 1142 (42000): DELETE command denied to user 'shop_read'@'localhost' for table 'users'
 *  
 */