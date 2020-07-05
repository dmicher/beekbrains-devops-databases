/*
==============================================================================================
							СОЗДАНИЕ БАЗЫ ДАННЫХ SHOP
==============================================================================================
*/

DROP DATABASE IF EXISTS shop_202007dak_homework;
CREATE DATABASE shop_202007dak_homework CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE shop_202007dak_homework;
SELECT DATABASE() AS 'БАЗА ДАННЫХ';

/*
==============================================================================================
							ФОРМИРОВАНИЕ СТРУКТУРЫ БАЗЫ ДАННЫХ SHOP
==============================================================================================
*/

-- категории таваров
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
	id SERIAL PRIMARY KEY,
	name CHAR(128) COMMENT 'Название раздела'
) COMMENT = 'Разделы товаров';

-- данные о покупателе
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	name CHAR(255) COMMENT 'Полное имя покупателя',
	birthday DATE COMMENT 'Дата рождения',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи о покупателе',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата последнего обновления записи о покупателе',
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

-- складские помещения (склады)
DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
	id SERIAL PRIMARY KEY,
	name CHAR(225) COMMENT 'Название склада',
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
	CONSTRAINT fk_from_storehouses_products_to_storehouse_id FOREIGN KEY (storehouse_id) REFERENCES storehouses(id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_from_storehouses_products_to_product_id FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT = 'Остатки товаров на складах (связывает склады и товары на них)';

-- заказы
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED COMMENT 'Идентификатор покупателя, к которому относится этот заказ',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи о заказе',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления записи о заказе',
	CONSTRAINT fk_from_orders_to_user_id FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
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
	CONSTRAINT fk_from_order_products_to_order_id FOREIGN KEY(order_id) REFERENCES orders(id) ON DELETE CASCADE ON UPDATE CASCADE,
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
	CONSTRAINT fk_from_discounts_to_user_id FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_from_discounts_to_product_id FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE SET NULL ON UPDATE CASCADE
) COMMENT = 'Скидки на товары для определённых покупателей';

SELECT 'ВОССОЗДАНА' AS 'СТРУКТУРА БАЗЫ ДАННЫХ';

/*
==============================================================================================
							ЗАПОЛНЕНИЕ ИСХОДНЫМИ ДАННЫМИ SHOP
==============================================================================================
*/

-- категории товаров
INSERT INTO catalogs VALUES
	(NULL, 'Процессоры'),					-- 1
	(NULL, 'Материнские платы'),			-- 2
	(NULL, 'Оперативная память'),			-- 3
	(NULL, 'Видеокарты'),					-- 4
	(NULL, 'Жёсткие диски'),				-- 5
	(NULL, 'Сетевые карты'),				-- 6
	(NULL, 'Блоки питания'),				-- 7
	(NULL, 'Переферийное оборудование'),	-- 8
	(NULL, 'Прочее');						-- 9

-- пользователи
INSERT INTO users VALUES
	(NULL, 'Иванов Иван Иванович', '1991-02-28', DEFAULT, DEFAULT),						-- 1
	(NULL, 'Александровна Александра Александровна', '1973-01-15', DEFAULT, DEFAULT),	-- 2
	(NULL, 'Евгениев Евгений Евгениевич', '1987-07-13', DEFAULT, DEFAULT),				-- 3
	(NULL, 'Олегова Ольга Олеговна', '1997-12-01', DEFAULT, DEFAULT),					-- 4
	(NULL, 'Тимофеев Тимофей Тимофеевич', '1967-11-03', DEFAULT, DEFAULT),				-- 5
	(NULL, 'Юлианова Юлия Юлиановна', '2001-06-23', DEFAULT, DEFAULT);					-- 6

-- товары
INSERT INTO products VALUES
-- 1:
	(NULL, 'Камень А1-1.6', 'Скалярный, ядер - 2, тактовая частота 1600 ГГц, x86', 1300, 1, DEFAULT, DEFAULT),
-- 2:
	(NULL, 'Камень А2-1.6', 'Скалярный, ядер - 4, тактовая частота 3200 ГГц, x86-64', 2700, 1, DEFAULT, DEFAULT),
-- 3:
	(NULL, 'Камень А2-3.2', 'Скалярный, ядер - 4, тактовая частота 1600 ГГц, x86-64', 2700, 1, DEFAULT, DEFAULT),
-- 4:
	(NULL, 'Векторок с0', 'Векторный, ядер - 8, тактовая частота 3200, x86-64', 7300, 1, DEFAULT, DEFAULT),
-- 5:
	(NULL, 'Родина 15-А', 'Материнская плата серии \"Родина 15\". Базовая', 6850, 2, DEFAULT, DEFAULT),
-- 6:
	(NULL, 'Родина 15-Б', 'Материнская плата серии \"Родина 15\". Расширенная', 9340, 2, DEFAULT, DEFAULT),
-- 7:
	(NULL, 'Родина 15-В', 'Материнская плата серии \"Родина 15\". Экстра', 12999, 2, DEFAULT, DEFAULT),
-- 8:
	(NULL, 'ОЗУ Страсть 4', 'Оперативное запоминающее устройство, 4 Гб', 1570, 3, DEFAULT, DEFAULT),
-- 9:
	(NULL, 'ОЗУ Страсть 8', 'Оперативное запоминающее устройство, 8 Гб', 3120, 3, DEFAULT, DEFAULT),
-- 10:
	(NULL, 'ОЗУ Страсть-Ультра', 'Оперативное запоминающее устройство, 16 Гб', 7153, 3, DEFAULT, DEFAULT),
-- 11:
	(NULL, 'Битый пиксель. База', 'Видеокарта, совместимая с м.п. Родина 15. Базовая', 25843, 4, DEFAULT, DEFAULT),
-- 12:
	(NULL, 'Битый пиксель. Игра', 'Видеокарта, совместимая с м.п. Родина 15. Игровая', 35248, 4, DEFAULT, DEFAULT),
-- 13:
	(NULL, 'Битый пиксель. Работа', 'Видеокарта, совместимая с м.п. Родина 15. Профессиональная', 76999, 4, DEFAULT, DEFAULT),
-- 14:
	(NULL, 'Погребок данных', 'Магнитрый, 4800 об./сек., 1Тб', 2753, 5, DEFAULT, DEFAULT),
-- 15:
	(NULL, 'Погребок данных', 'Твердотельный, 1Тб', 6500, 5, DEFAULT, DEFAULT),
-- 16:
	(NULL, 'Погребок данных', 'Твердотельный, 10Тб', 15300, 5, DEFAULT, DEFAULT),
-- 17:
	(NULL, 'Ало-Э! Адын', 'Сетевая карта, проводная', 3200, 6, DEFAULT, DEFAULT),
-- 18:
	(NULL, 'Ало-Э! Двэ', 'Сетевая карта, проводная, беспоровдная', 6100, 6, DEFAULT, DEFAULT),
-- 19:
	(NULL, 'Разряд 10', 'Блок питания, 10А, 75Вт', 1300, 7, DEFAULT, DEFAULT),
-- 20:
	(NULL, 'Разряд 15', 'Блок питания, 15А, 80Вт', 2785, 7, DEFAULT, DEFAULT),
-- 21:
	(NULL, 'Разряд 30', 'Блок питания, 30А, 660Вт', 5465, 7, DEFAULT, DEFAULT),
-- 22:
	(NULL, 'Клавка', 'Простая 102 кнопочная клавиатура', 1000, 8, DEFAULT, DEFAULT),
-- 23:
	(NULL, 'Клавдия Васильевна', 'Эргономичная клавиатура 267 клавиш', 6843, 8, DEFAULT, DEFAULT),
-- 24:
	(NULL, 'Клавец 9000', 'Эргономичная игровая клавиатура, подсветка, настройка эргономики, 134 клавиши', 23784, 8, DEFAULT, DEFAULT),
-- 24:
	(NULL, 'Курсор \"Тык\"', 'Мышь, 3 кнопки, оптическая', 300, 8, DEFAULT, DEFAULT),
-- 26:
	(NULL, 'Курсор \"Клац\"', 'Мышь, 6 кнопок, колесо, оптическая', 2640, 8, DEFAULT, DEFAULT),
-- 27:
	(NULL, 'Курсор \"Улёт\"', 'Эргономичная 83-кнопочная ректально имплементируемая мышь для полного погружения в игры', 173000, 8, DEFAULT, DEFAULT),
-- 28:
	(NULL, 'ПронХаб А4', 'Салфетки формата А4 для уборки помещения после посещения интернета, 1 шт.', 15, 9, DEFAULT, DEFAULT),
-- 29:
	(NULL, 'Звук500', 'Аккустическая система, 2 колонки + сабвуфер', 1500, 9, DEFAULT, DEFAULT),
-- 30:
	(NULL, 'Ухи-А', 'Наушники с микрофоном', 1300, 9, DEFAULT, DEFAULT),
-- 31:
	(NULL, 'Свет', 'Настольная лампа', 760, 9, DEFAULT, DEFAULT),
-- 32:
	(NULL, 'Печать', 'Принтер', 6800, 9, DEFAULT, DEFAULT);

-- складские помещения
INSERT INTO storehouses VALUES
	(NULL, 'Основной', DEFAULT, DEFAULT), -- 1
	(NULL, 'Кубышка', DEFAULT, DEFAULT);	-- 2

-- текущие остатки на складах
INSERT INTO storehouses_products VALUES
	(NULL, 1, 1, 10, DEFAULT, DEFAULT), -- основной склад, товар № 1, 10 штук
	(NULL, 2, 1, 30, DEFAULT, DEFAULT), -- кубылка, товар № 1, 30 штук
	(NULL, 1, 2, 7, DEFAULT, DEFAULT),
	(NULL, 2, 2, 0, DEFAULT, DEFAULT),
	(NULL, 1, 3, 12, DEFAULT, DEFAULT),
	(NULL, 2, 3, 8, DEFAULT, DEFAULT),
	(NULL, 1, 4, 30, DEFAULT, DEFAULT),
	(NULL, 2, 4, 7, DEFAULT, DEFAULT),
	(NULL, 1, 5, 12, DEFAULT, DEFAULT),
	(NULL, 2, 5, 1, DEFAULT, DEFAULT),
	(NULL, 1, 6, 75, DEFAULT, DEFAULT),
	(NULL, 2, 6, 0, DEFAULT, DEFAULT),
	(NULL, 1, 7, 0, DEFAULT, DEFAULT),
	(NULL, 2, 7, 12, DEFAULT, DEFAULT),
	(NULL, 1, 8, 35, DEFAULT, DEFAULT),
	(NULL, 2, 8, 0, DEFAULT, DEFAULT),
	(NULL, 1, 9, 1, DEFAULT, DEFAULT),
	(NULL, 2, 9, 2, DEFAULT, DEFAULT),
	(NULL, 1, 10, 3, DEFAULT, DEFAULT),
	(NULL, 2, 10, 4, DEFAULT, DEFAULT),
	(NULL, 1, 11, 7, DEFAULT, DEFAULT),
	(NULL, 2, 11, 0, DEFAULT, DEFAULT),
	(NULL, 1, 12, 0, DEFAULT, DEFAULT),
	(NULL, 2, 12, 0, DEFAULT, DEFAULT),
	(NULL, 1, 13, 0, DEFAULT, DEFAULT),
	(NULL, 2, 13, 12, DEFAULT, DEFAULT),
	(NULL, 1, 14, 75, DEFAULT, DEFAULT),
	(NULL, 2, 14, 0, DEFAULT, DEFAULT),
	(NULL, 1, 15, 20, DEFAULT, DEFAULT),
	(NULL, 2, 15, 20, DEFAULT, DEFAULT),
	(NULL, 1, 16, 11, DEFAULT, DEFAULT),
	(NULL, 2, 16, 7, DEFAULT, DEFAULT),
	(NULL, 1, 17, 6, DEFAULT, DEFAULT),
	(NULL, 2, 17, 3, DEFAULT, DEFAULT),
	(NULL, 1, 18, 1, DEFAULT, DEFAULT),
	(NULL, 2, 18, 2, DEFAULT, DEFAULT),
	(NULL, 1, 19, 36, DEFAULT, DEFAULT),
	(NULL, 2, 19, 0, DEFAULT, DEFAULT),
	(NULL, 1, 20, 0, DEFAULT, DEFAULT),
	(NULL, 2, 20, 0, DEFAULT, DEFAULT),
	(NULL, 1, 21, 7, DEFAULT, DEFAULT),
	(NULL, 2, 21, 4, DEFAULT, DEFAULT),
	(NULL, 1, 22, 1, DEFAULT, DEFAULT),
	(NULL, 2, 22, 100, DEFAULT, DEFAULT),
	(NULL, 1, 23, 13, DEFAULT, DEFAULT),
	(NULL, 2, 23, 8, DEFAULT, DEFAULT),
	(NULL, 1, 24, 1, DEFAULT, DEFAULT),
	(NULL, 2, 24, 2, DEFAULT, DEFAULT),
	(NULL, 1, 25, 0, DEFAULT, DEFAULT),
	(NULL, 2, 25, 7, DEFAULT, DEFAULT),
	(NULL, 1, 26, 7, DEFAULT, DEFAULT),
	(NULL, 2, 26, 0, DEFAULT, DEFAULT),
	(NULL, 1, 27, 0, DEFAULT, DEFAULT),
	(NULL, 2, 27, 0, DEFAULT, DEFAULT),
	(NULL, 1, 28, 1, DEFAULT, DEFAULT),
	(NULL, 2, 28, 1, DEFAULT, DEFAULT),
	(NULL, 1, 29, 0, DEFAULT, DEFAULT),
	(NULL, 2, 29, 2, DEFAULT, DEFAULT),
	(NULL, 1, 30, 0, DEFAULT, DEFAULT),
	(NULL, 2, 30, 0, DEFAULT, DEFAULT),
	(NULL, 1, 31, 31, DEFAULT, DEFAULT),
	(NULL, 2, 31, 50, DEFAULT, DEFAULT),
	(NULL, 1, 32, 17, DEFAULT, DEFAULT),
	(NULL, 2, 32, 3, DEFAULT, DEFAULT);

-- ранее сделанные заказы
INSERT INTO orders VALUES
	(NULL, 1, DEFAULT, DEFAULT), -- 1
	(NULL, 2, DEFAULT, DEFAULT), -- 2
	(NULL, 3, DEFAULT, DEFAULT), -- 3
	(NULL, 1, DEFAULT, DEFAULT), -- 4
	(NULL, 4, DEFAULT, DEFAULT), -- 5
	(NULL, 5, DEFAULT, DEFAULT), -- 6
	(NULL, 3, DEFAULT, DEFAULT), -- 7
	(NULL, 6, DEFAULT, DEFAULT); -- 8

-- состав ранее сделанных заказов
INSERT INTO order_products VALUES
	(NULL, 1, 7, 1, DEFAULT, DEFAULT),
	(NULL, 1, 3, 2, DEFAULT, DEFAULT),
	(NULL, 1, 12, 1, DEFAULT, DEFAULT),
	(NULL, 1, 32, 15, DEFAULT, DEFAULT),
	(NULL, 2, 2, 2, DEFAULT, DEFAULT),
	(NULL, 2, 7, 1, DEFAULT, DEFAULT),
	(NULL, 2, 13, 1, DEFAULT, DEFAULT),
	(NULL, 2, 24, 1, DEFAULT, DEFAULT),
	(NULL, 3, 29, 1, DEFAULT, DEFAULT),
	(NULL, 3, 16, 2, DEFAULT, DEFAULT),
	(NULL, 3, 10, 1, DEFAULT, DEFAULT),
	(NULL, 4, 1, 1, DEFAULT, DEFAULT),
	(NULL, 4, 3, 1, DEFAULT, DEFAULT),
	(NULL, 5, 8, 1, DEFAULT, DEFAULT),
	(NULL, 6, 3, 1, DEFAULT, DEFAULT),
	(NULL, 6, 6, 1, DEFAULT, DEFAULT),
	(NULL, 6, 9, 2, DEFAULT, DEFAULT),
	(NULL, 6, 12, 2, DEFAULT, DEFAULT),
	(NULL, 6, 15, 1, DEFAULT, DEFAULT),
	(NULL, 7, 12, 10, DEFAULT, DEFAULT),
	(NULL, 8, 16, 3, DEFAULT, DEFAULT);

-- установленные скидки для пользователей
INSERT INTO discounts VALUES
	(NULL, 1, 28, 0.15, '2020-07-01', NULL, DEFAULT, DEFAULT),
	(NULL, 3, 28, 0.15, '2020-07-01', NULL, DEFAULT, DEFAULT);

SELECT 'ИНИФИАЛИЗИРОВАНО' AS 'СОДЕРЖИМОЕ БАЗЫ ДАННЫХ', 'ГОТОВА К РАБОТЕ' AS 'БАЗА ДАННЫХ';

/*
==============================================================================================
							СОЗДАНИЕ БАЗЫ ДАННЫХ SAMPLE
==============================================================================================
*/

DROP DATABASE IF EXISTS sample_202007dak_homework;
CREATE DATABASE sample_202007dak_homework CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE sample_202007dak_homework;
SELECT DATABASE() AS 'БАЗА ДАННЫХ';

/*
==============================================================================================
							ФОРМИРОВАНИЕ СТРУКТУРЫ БАЗЫ ДАННЫХ SAMPLE
==============================================================================================
*/

-- категории таваров
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
	id SERIAL PRIMARY KEY,
	name CHAR(128) COMMENT 'Название раздела'
) COMMENT = 'Разделы товаров';

-- данные о покупателе
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	name CHAR(255) COMMENT 'Полное имя покупателя',
	birthday DATE COMMENT 'Дата рождения',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи о покупателе',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата последнего обновления записи о покупателе',
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

-- складские помещения (склады)
DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
	id SERIAL PRIMARY KEY,
	name CHAR(225) COMMENT 'Название склада',
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
	CONSTRAINT fk_from_storehouses_products_to_storehouse_id FOREIGN KEY (storehouse_id) REFERENCES storehouses(id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_from_storehouses_products_to_product_id FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT = 'Остатки товаров на складах (связывает склады и товары на них)';

-- заказы
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED COMMENT 'Идентификатор покупателя, к которому относится этот заказ',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи о заказе',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления записи о заказе',
	CONSTRAINT fk_from_orders_to_user_id FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
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
	CONSTRAINT fk_from_order_products_to_order_id FOREIGN KEY(order_id) REFERENCES orders(id) ON DELETE CASCADE ON UPDATE CASCADE,
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
	CONSTRAINT fk_from_discounts_to_user_id FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_from_discounts_to_product_id FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE SET NULL ON UPDATE CASCADE
) COMMENT = 'Скидки на товары для определённых покупателей';

SELECT 'ВОССОЗДАНА' AS 'СТРУКТУРА БАЗЫ ДАННЫХ';





