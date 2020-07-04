-- категории таваров
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
	id SERIAL PRIMARY KEY,
	name CHAR(128) COMMENT 'Название раздела',
	UNIQUE unique_name(name(10))
) COMMENT = 'Разделы товаров';

-- данные о покупателе
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	name CHAR(255) COMMENT 'Полное имя покупателя',
	birthday DATE COMMENT 'Дата рождения',
	created DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи о покупателе',
	updated DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата последнего обновления записи о покупателе'
) COMMENT = 'Покупатель в магазине';

-- товары
DROP TABLE IF EXISTS products;
CREATE TABLE products (
	id SERIAL PRIMARY KEY,
	name CHAR(255) COMMENT 'Название товара',
	description TEXT COMMENT 'Подробное описание товара',
	price DECIMAL(11,2) COMMENT 'Цена товара',
	catalog_id INT UNSIGNED COMMENT 'Раздел товаров, к которому этот товар относится',
	created DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи о товаре',
	updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления записи о товаре',
	KEY index_of_catalog_id(catalog_id)
) COMMENT = 'Товарные позиции';

-- заказы
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
	id SERIAL PRIMARY KEY,
	user_id INT UNSIGNED COMMENT 'Идентификатор покупателя, к которому относится этот заказ',
	created DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи о заказе',
	updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления записи о заказе',
	KEY index_of_user_id(customer_id)
) COMMENT = 'Заказы покупателей';

-- покупки в заказе
DROP TABLE IF EXISTS order_products;
CREATE TABLE order_products (
	id SERIAL PRIMARY KEY,
	order_id INT UNSIGNED COMMENT 'Заказ для сопоставления с товаром',
	product_id INT UNSIGNED COMMENT 'Товар для сопоставления с заказом',
	product_count INT UNSIGNED DEFAULT 1 COMMENT 'Количество товара, указанного в записи, заказанное покупателем',
	created DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи о товарах в заказе',
	updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления записи о товарах в заказе',
	INDEX index_of_order_id_product_id(order_id, product_id),
	INDEX index_of_product_id_order_id(product_id, order_id)
) COMMENT 'Отдельные товарные позиции в заказе (связывает заказ и товары в нём)';

-- скидки
DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
	id SERIAL PRIMARY KEY,
	user_id INT UNSIGNED COMMENT 'Покупатель, которому предоставляется скидка',
	product_id INT UNSIGNED COMMENT 'Товар, на который предоставляется скидка',
	amount FLOAT COMMENT 'Размер скидки в значении от 0.0 до 1.0',
	starts DATETIME NULL COMMENT '(оционально) Дата начала действия скидки',
	ends DATETIME NULL COMMENT '(опционально) Дата завершения действия скидки',
	created DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи о скидке',
	updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления записи о скидке',
	INDEX index_of_customer_id(costumer_id),
	INDEX index_of_product_id(product_id)
) COMMENT = 'Скидки на товары для определённых покупателей';

-- складские помещения (склады)
DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
	id SERIAL PRIMARY KEY,
	name CHAR(225) COMMENT 'Название склада',
	created DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи о складе',
	updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления записи о складе'
) COMMENT = 'Складские помещения';

-- расположение товаров на складах
DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
	id SERIAL PRIMARY KEY,
	storehouse_id INT UNSIGNED COMMENT 'Склад, на котором расположен указанный товар',
	product_id INT UNSIGNED COMMENT 'Товар, расположенный на указанном складе',
	product_count INT UNSIGNED COMMENT 'Количество указаннных товаров на указанном складе',
	created DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи об остатке товара на складе',
	updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления записи об остатке товара на складе'
) COMMENT = 'Остатки товаров на складах (связывает склады и товары на них)';

