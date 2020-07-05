/* ЗАДАНИЕ 1
 * В базе данных shop и sample присутвуют одни и те же таблицы учебной базы данных.
 * Переместите запись id = 1 из таблицы shop.users в таблицу sample.users.
 * Используйте транзакции.
 */

-- Требуется инициализация баз данных по скрипту № 0 (создаёт shop & sample, shop заполняет данными)

-- РЕШЕНИЕ. Для наглядности будет 2 транзакции: первую зафиксирую, а вторую откачу.
SELECT id, name AS 'Пользователи SHOP (изначально)' FROM shop_202007dak_homework.users;
SELECT id, name AS 'Пользователи SAMLLE (изначально)' FROM sample_202007dak_homework.users;

START TRANSACTION; -- Транзакция 1 "Успешная" (для фиксации)
	INSERT INTO sample_202007dak_homework.users (name, birthday) 
		SELECT name, birthday
		FROM shop_202007dak_homework.users
		WHERE id = 1;
	
	DELETE FROM shop_202007dak_homework.users WHERE id = 1;
COMMIT;

SELECT id, name AS 'Пользователи SHOP (успешная транзакция)' FROM shop_202007dak_homework.users;
SELECT id, name AS 'Пользователи SAMLLE (успешная транзакция)' FROM sample_202007dak_homework.users;

START TRANSACTION; -- Транзакция 2 "провалоьная" (для отката)
	INSERT INTO sample_202007dak_homework.users (name, birthday) 
		SELECT name, birthday
		FROM shop_202007dak_homework.users
		WHERE id = 2;

	DELETE FROM shop_202007dak_homework.users WHERE id = 2;

	SELECT id, name AS 'Пользователи SHOP (провальная транзакция до отката)' FROM shop_202007dak_homework.users;
	SELECT id, name AS 'Пользователи SAMLLE (провальная транзакция до отката)' FROM sample_202007dak_homework.users;
ROLLBACK;

SELECT id, name AS 'Пользователи SHOP (в итоге)' FROM shop_202007dak_homework.users;
SELECT id, name AS 'Пользователи SAMLLE (в итоге)' FROM sample_202007dak_homework.users;