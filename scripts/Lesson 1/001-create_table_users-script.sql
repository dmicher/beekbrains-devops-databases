drop table if exists users;
create table users (
	id serial comment 'Первичный ключ',
    `name` varchar(255) comment	'Имя пользователя'
);