create database if not exists user_db
default character set utf8mb4 collate UTF8mb4_general_ci;

use user_db;

create table user(
	id int auto_increment primary key,
	name varchar(100) not null,
	email varchar(100) not null unique,
	country varchar(100) not null
);
select * from user;
drop table user;