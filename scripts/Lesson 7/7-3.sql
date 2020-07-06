/* ОЧИСТКА СЕРВЕРА ОТ МУСОРА */
-- скрипт выполнять от пользователя root
REVOKE ALL ON *.* FROM shop;
REVOKE ALL ON *.* FROM shop_read;
REVOKE ALL ON *.* FROM user_read;
DROP USER IF EXISTS shop;
DROP USER IF EXISTS shop_read;
DROP USER IF EXISTS user_read;
DROP DATABASE IF EXISTS shop_202007dak_homework;

SHOW DATABASES;
SELECT `user`, `host` FROM mysql.`user`;