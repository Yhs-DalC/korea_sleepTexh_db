-- 파일 시스템
create table if not exists posts(
	id bigint auto_increment primary key,
    title varchar(255) not null,
    content text not null,
    created_at datetime not null default current_timestamp,
    updated_at datetime not null default current_timestamp on update current_timestamp
);
select * from posts;
create table if not exists communites(
	id bigint auto_increment primary key,
    title varchar(255) not null,
    content text not null,
    created_at datetime not null default current_timestamp,
    updated_at datetime not null default current_timestamp on update current_timestamp
);

create table if not exists upload_files(
	id bigint auto_increment primary key,
    original_name varchar(255) not null,-- 사용자가 업로드한 원래 이름
    file_name varchar(255) not null,-- 서버에 저장된 이름
    file_path varchar(500) not null,-- 전체 경로 또는 상대 경로
    file_type varchar(100),-- MIME 타입(image/png)
    file_size bigint not null,-- 파일 크기(bytes)
    
    target_id bigint not null,
    target_type enum('POST', 'COMMUNITY') not null,
    
    index idx_target(target_type, target_id)
);select * from upload_files;

-- 주문 관리 시스템(트랜잭션, 트리거, 인덱스, 뷰 학습)
use `springboot_db`;
create table if not exists products(
	id bigint auto_increment primary key,
    name varchar(100) not null,
    price int not null,
    created_at datetime default current_timestamp
);
create table if not exists stocks(
	id bigint auto_increment primary key,
    product_id bigint not null,
    quantity int not null,
    updated_at datetime default current_timestamp on update current_timestamp,
    foreign key (product_id) references products(id) on delete cascade
);
create table if not exists orders(
	id bigint auto_increment primary key,
    user_id bigint not null,
    order_status varchar(20) not null default 'PENDING', -- 주문 대기 상태 - 담당자가 주문 승인 시 상태 변경
    created_at datetime default current_timestamp,
    foreign key (user_id) references users(id) on delete cascade
);
create table if not exists order_items(
	id bigint auto_increment primary key,
    order_id bigint not null, -- orders 테이블 참조(주문의 공통 상태를 저장)
    product_id bigint not null,
    quantity int not null, -- 주문 수량
    foreign key (order_id) references orders(id) on delete cascade,
    foreign key (product_id) references products(id) on delete cascade
);

create table if not exists order_logs(
	id bigint auto_increment primary key,
    order_id bigint not null,
    message varchar(255),
    created_at datetime default current_timestamp,
    foreign key (order_id) references orders(id) on delete cascade
);

# 초기 데이터 삽입 스크립트
-- 기본 상품 등록
insert into products(name, price)
values
	('슬립테크 매트리스', 120),
    ('수면 측정기기', 45),
    ('아로마 수면램프', 30);

-- 재고 등록
insert into stocks (product_id, quantity)
values
	(1,100),
    (2, 30),
    (3, 45);
    
# 인덱스 추가(제품 명 순서로 빠르게 검색하는 인덱스 추가)
create index idx_product_name on products(name);

# 주문 요약 뷰 생성
create or replace view order_summary as
select
	o.id as order_id, o.user_id, p.name as product_name, oi.quantity, p.price
    , (oi.quantity * p.price) as total_price
from
	orders o
    join order_items oi on o.id = oi.order_id
    join products p on oi.product_id = p.id;order_summaryorder_summary

drop trigger if exists trg_after_order_insert;
# 주문 생성 트리거
DELIMITER // -- 구분 문자 변경 (기본값 ;)
CREATE TRIGGER trg_after_order_insert
AFTER INSERT ON 'orders'
FOR EACH ROW
BEGIN
		INSERT INTO order_logs(order_id, message)
        VALUES (NEW.id, CONCAT('주문이 생성되었습니다. 주문 ID: ', NEW.id));
END;
//
DELIMITER ;

show triggers like 'orders';

select * from products;
select * from stocks;
select * from orders;
select * from order_items;
select * from order_logs;
SELECT * FROM order_summary WHERE order_id;