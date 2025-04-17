### 비정규화(반정규화)
# : 정규화된 db를 조회 성능 향상이나 복잡한 조인의 단순화 등을 위해
#	, 의도적으로 중복을 허용하여 다시 통합하는 과정
# - 정규화를 뒤집는 개념 X, 특정 상항의 성능을 위해 설계적으로 일부 정규화를 되돌리는 작업
# cf) 정규화 : 테이블의 중보을 없애는 것

-- 정규화된 테이블 예시
drop database if exists `비정규화`;
create database `비정규화`;
use `비정규화`;

# 고객 테이블
create table customers(
	customer_id int primary key,
    name varchar(100), -- 컬럼명으로 name보다는 구체화된 테이블_name 사용을 권장
    address varchar(255)
);

# 제품 테이블
create table products(
	product_id int primary key,
	product_name varchar(100),
	price int
);

# 주문 테이블
create table orders(
	order_id int primary key,
    customer_id int,
    order_date date,
    total_amount int,
    foreign key (customer_id) references customers(customer_id)
);
# 주문 상세 테이블
create table order_details(
	order_detail_id int primary key,
    order_id int,
    product_id int,
    quantity int,
    price int,
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
);

### 1. 정규화의 장단점
# 1) 장점: 중복 최소화, 데이터 무결성 유지
# 2) 단점: 데이터를 조회할 때마다 여러 테이블을 조인해야 하므로 성능 저하 가능

-- 비정규화된 테이블 예시
create table orders_denomalized(
	order_id int primary key,
    customer_name varchar(100),
    customer_address varchar(255),
    order_date date,
    product_name varchar(100),
    quantity int,
    price int,
    total_amount int -- 총 주문 금액
);
