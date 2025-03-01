CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE domains (
    domain_id SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    domain_name VARCHAR(50) NOT NULL,
    status_code VARCHAR(50) DEFAULT 'unknown',
    ssl_expiration VARCHAR(50) DEFAULT 'unknown',
    ssl_issuer VARCHAR(30) DEFAULT 'unknown',
    FOREIGN KEY (username) REFERENCES users(username),
    CONSTRAINT unique_domain_columns UNIQUE (username, domain_name)
);

INSERT INTO users (username, password) VALUES
('David', '1223'),
('Sarah', '4567'),
('John', '7890'); 

INSERT INTO domains (username, domain_name, status_code, ssl_expiration, ssl_issuer) VALUES
('David', 'google.com', 'unknown', 'unknown', 'unknown'),
('David', 'facebook.com', 'unknown', 'unknown', 'unknown'),
('Sarah', 'yahoo.com', 'unknown', 'unknown', 'unknown'),
('Sarah', 'bing.com', 'unknown', 'unknown', 'unknown'),
('John', 'amazon.com', 'unknown', 'unknown', 'unknown'),
('John', 'apple.com', 'unknown', 'unknown', 'unknown');
