/* ЗАДАНИЕ 2
 * В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
 * Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное 
 * значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля 
 * были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.
 */

-- Воссоздаём задание
DROP DATABASE IF EXISTS shop_202007dak_homework;
CREATE DATABASE shop_202007dak_homework;
USE shop_202007dak_homework;

DROP TABLE IF EXISTS products;
CREATE TABLE products (
	id SERIAL PRIMARY KEY,
	name CHAR(255) COMMENT 'Название товара',
	description TEXT COMMENT 'Подробное описание товара'
) COMMENT = 'Товарные позиции';

-- Выполняем задание
DROP TRIGGER IF EXISTS before_insert_into_products;
DROP TRIGGER IF EXISTS before_update_products;

DELIMITER //
CREATE TRIGGER before_insert_into_products BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF (NEW.name IS NULL && NEW.description IS NULL) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Недопустимые значения вставки';
	END IF;
END; //

CREATE TRIGGER before_update_products BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
	IF (NEW.name IS NULL && NEW.description IS NULL) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Недопустимые значения обновления';
	END IF;
END; //
DELIMITER ;

-- Проверяем работу задания
INSERT INTO products (name, description) 
	VALUES ('Продукт 1', 'Описание продукта 1');	-- 1 нормально
INSERT INTO products (name, description)
	VALUES ('Продукт 2', NULL);						-- 2 нормально
INSERT INTO products (name, description)
	VALUES (NULL, 'Описание продукта 3');			-- 3 нормально
INSERT IGNORE INTO products (name, description) 
	VALUES (NULL, NULL);							-- ошибка

SELECT * FROM products;

UPDATE products SET name = NULL WHERE id = 1; -- нормально
UPDATE products SET name = NULL WHERE id = 2; -- ошибка
UPDATE products SET name = NULL WHERE id = 3; -- нормально

SELECT * FROM products;

-- чистим сервер
DROP DATABASE IF EXISTS shop_202007dak_homework;