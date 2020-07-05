/* ЗАДАНИЕ 2
 * Выведите список товаров products и разделов catalogs, который соответствует товару
 */

-- ТРЕБУЕТСЯ ИНИЦИАЛИЗАЦИЯ БАЗЫ ИЗ БАЗОВОГО СКРИПТА (там данные по каталогам и товарам)

SELECT p.id AS '№', p.name AS 'Товар', c.name AS 'Категория'
FROM products p 
INNER JOIN catalogs c ON p.catalog_id = c.id;

-- усложняем задачу: объединим вывод данных по категориям
SELECT 
	c.name AS 'Категория', -- название категории
	COUNT(*) AS 'Всего', -- количество номенклатурных единиц в категории
	GROUP_CONCAT(p.name ORDER BY p.id SEPARATOR ', ') AS 'Товары' -- именя товаров в категории
FROM catalogs c
	INNER JOIN products p ON p.catalog_id = c.id
GROUP BY c.name
ORDER BY c.id;
