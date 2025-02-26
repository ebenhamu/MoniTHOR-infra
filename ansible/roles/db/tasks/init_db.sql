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
    status_code VARCHAR(10),
    ssl_expiration VARCHAR(10),
    ssl_Issuer VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES user_credentials(id)
);
