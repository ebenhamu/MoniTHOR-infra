CREATE TABLE user_credentials (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE domains (
    domain_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    domain_name VARCHAR(30) NOT NULL,
    status_code VARCHAR(10) DEFAULT "unknown",
    ssl_expiration VARCHAR(10) DEFAULT "unknown",
    ssl_Issuer VARCHAR(20) DEFAULT "unknown" ,
    FOREIGN KEY (user_id) REFERENCES user_credentials(id)
);

INSERT INTO user_credentials (username, password) VALUES
('David', '1223'),
('Sarah', '4567');
('John', '7890'); 

INSERT INTO domains (user_id, domain_name) VALUES
(1, 'google.com'),
(1, 'facebook.com'),
(2, 'yahoo.com'),
(2, 'bing.com');
(3, 'amazon.com'),
(3, 'apple.com');

