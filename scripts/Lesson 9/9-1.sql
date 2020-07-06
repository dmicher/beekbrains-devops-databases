/*
==============================================================================================
							СОЗДАНИЕ БАЗЫ ДАННЫХ
==============================================================================================
*/

DROP DATABASE IF EXISTS shop_202007dak_homework;
CREATE DATABASE shop_202007dak_homework CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE shop_202007dak_homework;
SELECT DATABASE() AS 'БАЗА ДАННЫХ';

/*
==============================================================================================
							ФОРМИРОВАНИЕ СТРУКТУРЫ БАЗЫ ДАННЫХ 
==============================================================================================
*/

-- категории таваров
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
	id SERIAL PRIMARY KEY,
	name CHAR(128) NOT NULL COMMENT 'Название раздела',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи о покупателе',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата последнего обновления записи о покупателе'
) COMMENT = 'Разделы товаров';

-- данные о покупателе
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	name CHAR(255) NOT NULL COMMENT 'Полное имя покупателя',
	birthday DATE COMMENT 'Дата рождения',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи о покупателе',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата последнего обновления записи о покупателе',
	INDEX index_of_name(name(32))
) COMMENT = 'Покупатель в магазине';

-- товары
DROP TABLE IF EXISTS products;
CREATE TABLE products (
	id SERIAL PRIMARY KEY,
	name CHAR(255) COMMENT 'Название товара',
	description TEXT COMMENT 'Подробное описание товара',
	price DECIMAL(11,2) COMMENT 'Цена товара',
	catalog_id BIGINT UNSIGNED COMMENT 'Раздел товаров, к которому этот товар относится',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи о товаре',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления записи о товаре',
	CONSTRAINT fk_from_products_to_catalog_id FOREIGN KEY(catalog_id) REFERENCES catalogs(id) ON DELETE SET NULL ON UPDATE CASCADE
) COMMENT = 'Товарные позиции';

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

-- складские помещения (склады)
DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
	id SERIAL PRIMARY KEY,
	name CHAR(225) NOT NULL COMMENT 'Название склада',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи о складе',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления записи о складе'
) COMMENT = 'Складские помещения';

-- расположение товаров на складах
DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
	id SERIAL PRIMARY KEY,
	storehouse_id BIGINT UNSIGNED COMMENT 'Склад, на котором расположен указанный товар',
	product_id BIGINT UNSIGNED COMMENT 'Товар, расположенный на указанном складе',
	product_count INT UNSIGNED COMMENT 'Количество указаннных товаров на указанном складе',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи об остатке товара на складе',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления записи об остатке товара на складе',
	CONSTRAINT fk_from_storehouses_products_to_storehouse_id FOREIGN KEY (storehouse_id) REFERENCES storehouses(id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fk_from_storehouses_products_to_product_id FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE RESTRICT ON UPDATE CASCADE
) COMMENT = 'Остатки товаров на складах (связывает склады и товары на них)';

-- заказы
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED COMMENT 'Идентификатор покупателя, к которому относится этот заказ',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи о заказе',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления записи о заказе',
	CONSTRAINT fk_from_orders_to_user_id FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE NO ACTION ON UPDATE CASCADE
) COMMENT = 'Заказы покупателей';

-- покупки в заказе
DROP TABLE IF EXISTS order_products;
CREATE TABLE order_products (
	id SERIAL PRIMARY KEY,
	order_id BIGINT UNSIGNED COMMENT 'Заказ для сопоставления с товаром',
	product_id BIGINT UNSIGNED COMMENT 'Товар для сопоставления с заказом',
	product_count INT UNSIGNED DEFAULT 1 COMMENT 'Количество товара, указанного в записи, заказанное покупателем',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи о товарах в заказе',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления записи о товарах в заказе',
	CONSTRAINT fk_from_order_products_to_order_id FOREIGN KEY(order_id) REFERENCES orders(id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fk_from_order_products_to_product_id FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE SET NULL ON UPDATE CASCADE
) COMMENT 'Отдельные товарные позиции в заказе (связывает заказ и товары в нём)';

-- скидки
DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED COMMENT 'Покупатель, которому предоставляется скидка',
	product_id BIGINT UNSIGNED COMMENT 'Товар, на который предоставляется скидка',
	amount FLOAT COMMENT 'Размер скидки в значении от 0.0 до 1.0',
	starts DATETIME NULL COMMENT '(оционально) Дата начала действия скидки',
	ends DATETIME NULL COMMENT '(опционально) Дата завершения действия скидки',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи о скидке',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления записи о скидке',
	CONSTRAINT fk_from_discounts_to_user_id FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE NO ACTION ON UPDATE CASCADE,
	CONSTRAINT fk_from_discounts_to_product_id FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE SET NULL ON UPDATE CASCADE
) COMMENT = 'Скидки на товары для определённых покупателей';

-- архивная таблица
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	table_name CHAR(32) COMMENT 'Название таблицы',
	table_value_id BIGINT UNSIGNED COMMENT 'Идентификатор первичного ключа в таблице',
	table_value_name CHAR(225) COMMENT 'Содержимое поле \"имя\" в таблице ',
	created_at DATETIME
) COMMENT 'Таблица логов' ENGINE=ARCHIVE;

DROP TRIGGER IF EXISTS after_insert_users_to_archive;
DROP TRIGGER IF EXISTS after_insert_products_to_archive;
DROP TRIGGER IF EXISTS after_insert_catalogs_to_archive;

DELIMITER //
CREATE TRIGGER after_insert_users_to_archive AFTER INSERT ON users
FOR EACH ROW
BEGIN 
	INSERT INTO logs (table_name, table_value_id, table_value_name, created_at)
	SELECT 'users', id, name, created_at FROM users ORDER BY id DESC LIMIT 1;
END; //

CREATE TRIGGER after_insert_products_to_archive AFTER INSERT ON products
FOR EACH ROW
BEGIN 
	INSERT INTO logs (table_name, table_value_id, table_value_name, created_at)
	SELECT 'products', id, name, created_at FROM products ORDER BY id DESC LIMIT 1;
END; //

CREATE TRIGGER after_insert_catalogs_to_archive AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN 
	INSERT INTO logs (table_name, table_value_id, table_value_name, created_at)
	SELECT 'catalogs', id, name, created_at FROM catalogs ORDER BY id DESC LIMIT 1;
END; //
DELIMITER ;

SELECT 'ВОССОЗДАНА' AS 'СТРУКТУРА БАЗЫ ДАННЫХ';

/*
==============================================================================================
							ЗАПОЛНЕНИЕ ИСХОДНЫМИ ДАННЫМИ
==============================================================================================
*/

-- категории товаров
INSERT INTO catalogs (name) VALUES
	('Процессоры'), ('Материнские платы'), ('Оперативная память'), ('Видеокарты'), ('Жёсткие диски'),
	 ('Сетевые карты'), ('Блоки питания'), ('Переферийное оборудование'), ('Прочее');

-- пользователи
INSERT INTO users (name, birthday) VALUES
	('Иванов Иван Иванович', '1991-02-28'), ('Александровна Александра Александровна', '1973-01-15'),
	('Евгениев Евгений Евгениевич', '1987-07-13'), ('Олегова Ольга Олеговна', '1997-12-01'), 
	('Тимофеев Тимофей Тимофеевич', '1967-11-03'), ('Юлианова Юлия Юлиановна', '2001-06-23');

-- товары
INSERT INTO products (name, description, price, catalog_id) VALUES
	('Камень А1-1.6', 'Скалярный, ядер - 2, тактовая частота 1600 ГГц, x86', 1300, 1),
	('Камень А2-1.6', 'Скалярный, ядер - 4, тактовая частота 3200 ГГц, x86-64', 2700, 1),
	('Камень А2-3.2', 'Скалярный, ядер - 4, тактовая частота 1600 ГГц, x86-64', 2700, 1),
	('Векторок с0', 'Векторный, ядер - 8, тактовая частота 3200, x86-64', 7300, 1),
	('Родина 15-А', 'Материнская плата серии \"Родина 15\". Базовая', 6850, 2),
	('Родина 15-Б', 'Материнская плата серии \"Родина 15\". Расширенная', 9340, 2),
	('Родина 15-В', 'Материнская плата серии \"Родина 15\". Экстра', 12999, 2),
	('ОЗУ Страсть 4', 'Оперативное запоминающее устройство, 4 Гб', 1570, 3),
	('ОЗУ Страсть 8', 'Оперативное запоминающее устройство, 8 Гб', 3120, 3),
	('ОЗУ Страсть-Ультра', 'Оперативное запоминающее устройство, 16 Гб', 7153, 3),
	('Битый пиксель. База', 'Видеокарта, совместимая с м.п. Родина 15. Базовая', 25843, 4),
	('Битый пиксель. Игра', 'Видеокарта, совместимая с м.п. Родина 15. Игровая', 35248, 4),
	('Битый пиксель. Работа', 'Видеокарта, совместимая с м.п. Родина 15. Профессиональная', 76999, 4),
	('Погребок данных', 'Магнитрый, 4800 об./сек., 1Тб', 2753, 5),
	('Погребок данных', 'Твердотельный, 1Тб', 6500, 5),
	('Погребок данных', 'Твердотельный, 10Тб', 15300, 5),
	('Ало-Э! Адын', 'Сетевая карта, проводная', 3200, 6),
	('Ало-Э! Двэ', 'Сетевая карта, проводная, беспоровдная', 6100, 6),
	('Разряд 10', 'Блок питания, 10А, 75Вт', 1300, 7),
	('Разряд 15', 'Блок питания, 15А, 80Вт', 2785, 7),
	('Разряд 30', 'Блок питания, 30А, 660Вт', 5465, 7),
	('Клавка', 'Простая 102 кнопочная клавиатура', 1000, 8),
	('Клавдия Васильевна', 'Эргономичная клавиатура 267 клавиш', 6843, 8),
	('Клавец 9000', 'Эргономичная игровая клавиатура, подсветка, настройка эргономики, 134 клавиши', 23784, 8),
	('Курсор \"Тык\"', 'Мышь, 3 кнопки, оптическая', 300, 8),
	('Курсор \"Клац\"', 'Мышь, 6 кнопок, колесо, оптическая', 2640, 8),
	('Курсор \"Улёт\"', 'Эргономичная 83-кнопочная ректально имплементируемая мышь для полного погружения в игры', 173000, 8),
	('ПронХаб А4', 'Салфетки формата А4 для уборки помещения после посещения интернета, 1 шт.', 15, 9),
	('Звук500', 'Аккустическая система, 2 колонки + сабвуфер', 1500, 9),
	('Ухи-А', 'Наушники с микрофоном', 1300, 9),
	('Свет', 'Настольная лампа', 760, 9),
	('Печать', 'Принтер', 6800, 9);

-- складские помещения
INSERT INTO storehouses (name) VALUES ('Основной'), ('Кубышка');

-- текущие остатки на складах
INSERT INTO storehouses_products (storehouse_id, product_id, product_count) VALUES
	(1, 1, 10), (2, 1, 30),	(1, 2, 7), (2, 2, 0), (1, 3, 12), (2, 3, 8), (1, 4, 30),
	(2, 4, 7),	(1, 5, 12),	(2, 5, 1), (1, 6, 75), (2, 6, 0), (1, 7, 0), (2, 7, 12),
	(1, 8, 35),	(2, 8, 0),	(1, 9, 1), (2, 9, 2), (1, 10, 3), (2, 10, 4), (1, 11, 7),
	(2, 11, 0),	(1, 12, 0),	(2, 12, 0),	(1, 13, 0), (2, 13, 12), (1, 14, 75), (2, 14, 0),
	(1, 15, 20), (2, 15, 20), (1, 16, 11), (2, 16, 7), (1, 17, 6), (2, 17, 3), (1, 18, 1),
	(2, 18, 2), (1, 19, 36), (2, 19, 0), (1, 20, 0), (2, 20, 0), (1, 21, 7), (2, 21, 4),
	(1, 22, 1), (2, 22, 100), (1, 23, 13), (2, 23, 8), (1, 24, 1), (2, 24, 2), (1, 25, 0),
	(2, 25, 7), (1, 26, 7), (2, 26, 0), (1, 27, 0), (2, 27, 0), (1, 28, 1), (2, 28, 1),
	(1, 29, 0), (2, 29, 2), (1, 30, 0), (2, 30, 0), (1, 31, 31), (2, 31, 50), (1, 32, 17),
	(2, 32, 3);

-- ранее сделанные заказы
INSERT INTO orders (user_id) VALUES (1), (2), (3), (1), (4), (5), (3), (6);

-- состав ранее сделанных заказов
INSERT INTO order_products (order_id, product_id, product_count) VALUES
	(1, 7, 1), (1, 3, 2), (1, 12, 1), (1, 32, 15), (2, 2, 2), (2, 7, 1), (2, 13, 1),
	(2, 24, 1), (3, 29, 1), (3, 16, 2), (3, 10, 1), (4, 1, 1), (4, 3, 1), (5, 8, 1),
	(6, 3, 1), (6, 6, 1), (6, 9, 2), (6, 12, 2), (6, 15, 1), (7, 12, 10), (8, 16, 3);

-- установленные скидки для пользователей
INSERT INTO discounts (user_id, product_id, amount, starts) VALUES 
	(1, 28, 0.15, '2020-07-01'), (3, 28, 0.15, '2020-07-01');

SELECT 'ИНИФИАЛИЗИРОВАНО' AS 'СОДЕРЖИМОЕ БАЗЫ ДАННЫХ', 'ГОТОВА К РАБОТЕ' AS 'БАЗА ДАННЫХ';






