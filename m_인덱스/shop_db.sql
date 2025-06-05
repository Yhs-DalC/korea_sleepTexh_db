### OrderApp 프로젝트 DB 설정

CREATE DATABASE shop_db;
USE shop_db;
CREATE TABLE `user`(
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	email VARCHAR(100) NOT NULL
);

# 예약어를 테이블명으로 사용할 경우 백틱으로 감싸기(따옴표 x)
CREATE TABLE `order`(
	id INT AUTO_INCREMENT PRIMARY KEY,
	user_id INT,
	product_name VARCHAR(100) NOT NULL,
	amount INT NOT NULL,
	FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE
);
 # on delete cascade
    # : 부모 테이블의 행이 삭제되면 그 행을 참조하고 있는 자식 테이블의 행도 같이 삭제

SELECT * FROM `user`;
SELECT * FROM `order`;