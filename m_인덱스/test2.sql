create database if not exists `springboot_db`;

use `springboot_db`;

create table if not exists test(
	id bigint primary key auto_increment,
    name varchar(50) not null
);

select * from test;

create table student (
	id bigint auto_increment primary key,
    name varchar(255) not null,
    email varchar(255) not null unique
);

select * from student;

create table book (
	id bigint auto_increment primary key,
    writer varchar(50) not null,
    title varchar(100) not null,
    content varchar(500) not null,
    category varchar(255) not null,
    constraint chk_category check (category in ('NOVEL', 'ESSAY','POEM','MAGAZINE'))
);

select * from book;