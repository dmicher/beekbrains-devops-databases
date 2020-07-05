/* ЗАДАНИЕ 2
 * Создайте представление, которое выводит название (name) товарной позиции из таблицы products
 * и соответствующее название (name) каталога из таблицы catalogs.
 */

-- Требуется инициализация баз данных по скрипту № 0 (создаёт shop & sample, shop заполняет данными)

-- РЕШЕНИЕ: создаёт представление и использует его
USE shop_202007dak_homework;

DROP VIEW IF EXISTS view_products_by_catalogs;
CREATE VIEW view_products_by_catalogs (product, `catalog`) AS
	SELECT p.name, c.name
	FROM products p
	LEFT JOIN catalogs c ON p.catalog_id = c.id;

SELECT -- демеонстрация работы
	`catalog` 'Категория товаров', 
	COUNT(*) AS 'Товарных имён'
FROM view_products_by_catalogs 
GROUP BY `catalog`;