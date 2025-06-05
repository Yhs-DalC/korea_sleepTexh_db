create database if not exists board_db 
default character set utf8mb4 collate utf8mb4_general_ci;

use board_db;

create table if not exists post(
	id int auto_increment primary key,
    title varchar(100) not null,
    content text not null,
    author varchar(50) not null,
    created_at datetime not null default current_timestamp
);

select * from post;
SELECT * FROM post;