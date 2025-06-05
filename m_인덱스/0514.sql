-- users(사용자) 테이블 --
CREATE TABLE IF NOT EXISTS users(
	id BIGINT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL,
	updated_at DATETIME  
);
SELECT * FROM springboot_db.users;

-- authority(권한) 관련 테이블 --
# 권한 관리 테이블 설계(정규화 방식)
# : 권한 종류를 roles 테이블로 분리
#	, 이를 참조하여 user_roles에 저장
# > 역할 이름을 고유값으로 관리, role_id를 통해 연결
create table if not exists roles(
	role_id bigint auto_increment primary key, -- 역할 고유 ID
    role_name varchar(50) not null unique		-- 역할 이름(ex, ADMIN, USER), 중복 불가
);

insert into roles(role_name)
values
	('USER'),('ADMIN'),('MANAGER');

# 해당 테이블은 사용자와 역할의 관계를 나타내는 중간 테이블
# : 사용자 한 명이 여러 역할을 가질 수 있고
#	, 하나의 역할도 여러 사용자에게 부여될 수 있음
# > 다대다(ManyToMany) 관계
create table if not exists user_roles(
	user_id bigint not null,
    role_id bigint not null,
    primary key (user_id, role_id), -- 복합 기본키: 중복 매핑 방지
    constraint fk_user foreign key (user_id) references users(id) on delete cascade,
	constraint fk_role foreign key (role_id) references roles(role_id) on delete cascade
);

select * from roles;
select * from user_roles;

-- log(기록) 테이블 --
# 권한 변경 시 기록(로그) 테이블에 자동 저장
CREATE TABLE IF NOT EXISTS role_change_logs(
	ud BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id bigint not null,-- 권한이 변경된 사용자 ID(PK)
    email varchar(255) not null,-- 사용자 이메일
    prev_roles text,
    new_roles text,
    changed_by varchar(255) not null,-- 변경을 수행한 관리자 이메일
    change_type varchar(20) not null,-- 변경 유형(ADD, REMOVE, UPDATE 등)
    change_reason varchar(255),-- 변경 사유
    changed_at timestamp default current_timestamp,
    foreign key (user_id) references USERS(id) on delete cascade
);

select * from role_change_logs; 