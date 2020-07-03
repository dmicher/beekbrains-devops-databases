-- ЗАДАНИЕ 2

-- пользователь (по заданию): идентификатор и имя
CREATE TABLE IF NOT EXISTS users (
	id SERIAL PRIMARY KEY,
	name CHAR(255) NOT NULL COMMENT 'Имя пользователя',
	INDEX infex_of_name(name(16)) COMMENT 'Индекс по имени пользователя. 16 знаков достаточно.'
) COMMENT = '';

/* медиафал (по заданию):
   - путь к файлам
   - название
   - описание
   - ключевые слова
   - принадлежность к пользователю */
CREATE TABLE IF NOT EXISTS media_file (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL COMMENT 'Указатель на пользователя',
	file_path TEXT NOT NULL COMMENT 'Путь к медиафайлу в файловой системе',
	name CHAR(255) NOT NULL COMMENT 'Название медиафала',
	description TEXT DEFAULT NULL COMMENT '(опционально) описание файла',
	key_wods VARCHAR(255) DEFAULT NULL COMMENT '(опционально) ключевые слова через запятую',
	FOREIGN KEY (user_id) REFERENCES users (id),
	UNIQUE unique_path(file_path(255)),
	INDEX infex_of_name(name(64))
) COMMENT = 'Медиафайлы';

-- заполнение таблиц
TRUNCATE users;
TRUNCATE media_file;

INSERT INTO users VALUES
	(DEFAULT, 'Иван'),
	(DEFAULT, 'Павел'),
	(DEFAULT, 'Пётр'),
	(DEFAULT, 'Ульяна');

INSERT INTO media_file VALUES
	(DEFAULT, 3, 'C://Media/Audio/file1.mp3', 'А. Вивальди Летняя гроза.', NULL, 'классика, музыка'),
	(DEFAULT, 2, 'C://Media/Video/file12.mp4', 'С. Кубрик \"Космическая одиссея\".', DEFAULT, 'классика, видео'),
	(DEFAULT, 2, 'C://Media/Photi/file743.png', 'Фотка ню няшной тянки.', 'Пашка! Срочно удали это отсюда!', DEFAULT);
	
-- смотрим результат
SELECT u.name as `user`, f.name as media, f.description
FROM media_file f
	INNER JOIN users u on f.user_id = u.id;
	