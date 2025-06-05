CREATE TABLE IF NOT EXISTS `users` (
   user_code BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    role_code ENUM('MEMBER', 'TRAINER') NOT NULL,
    user_id VARCHAR(20) NOT NULL,
    user_password VARCHAR(255) NOT NULL,
    user_image BLOB,
    user_name VARCHAR(25) NOT NULL,
    user_birthdate DATE NOT NULL,
    user_gender ENUM('MAN', 'WOMAN') NOT NULL,
    user_phone VARCHAR(20) NOT NULL,
    user_email VARCHAR(100) NOT NULL
);
-- =============================
CREATE TABLE IF NOT EXISTS `matches`(
	member_id BIGINT NOT NULL,
    trainer_id BIGINT NOT NULL,
    match_id BIGINT UNIQUE,
    match_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    match_is_maintained BOOLEAN NOT NULL DEFAULT TRUE,
    
    PRIMARY KEY(member_id, trainer_id),
    FOREIGN KEY (member_code) REFERENCES users(user_code),
    FOREIGN KEY (trainer_code) REFERENCES users(user_code)
);

CREATE TABLE IF NOT EXISTS `oneday_tickets`(
	ticket_code BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    member_code BIGINT NOT NULL,
    trainer_code BIGINT NOT NULL,
    ticket_apply_date DATE,
    ticket_used_date DATE,
    ticket_processed_date DATE,
    ticket_is_used BOOLEAN NOT NULL DEFAULT FALSE,
    ticket_is_approved BOOLEAN NOT NULL DEFAULT FALSE,
    ticket_is_rejection BOOLEAN NOT NULL DEFAULT FALSE,
    ticket_reject_reason VARCHAR(100),
    
    FOREIGN KEY (member_code) REFERENCES users(user_code),
    FOREIGN KEY (trainer_code) REFERENCES users(user_code)
);

CREATE TABLE IF NOT EXISTS `coupons`(
	coupon_code INT NOT NULL PRIMARY KEY,
    member_code BIGINT NOT NULL,
    trainer_code BIGINT NOT NULL,
    coupon_image BLOB,
    coupon_expiration_period DATE NOT NULL,
    coupon_used_date DATE,
    coupon_is_used BOOLEAN NOT NULL DEFAULT FALSE,
    coupon_is_expired BOOLEAN NOT NULL DEFAULT FALSE,
    
    FOREIGN KEY (member_code) REFERENCES users(user_code),
    FOREIGN KEY (trainer_code) REFERENCES users(user_code)
);

CREATE TABLE IF NOT EXISTS `personal_community_posts`(
	post_code BIGINT NOT NULL PRIMARY KEY,
    match_code BIGINT NOT NULL,
    post_title VARCHAR(100) NOT NULL,
    post_content TEXT,
    post_image BLOB,
    post_writer BIGINT NOT NULL,
    post_date DATETIME NOT NULL,
    
    FOREIGN KEY (match_code) REFERENCES matches(member_code), -- err
    FOREIGN KEY (post_writer) REFERENCES users(user_code)
);
