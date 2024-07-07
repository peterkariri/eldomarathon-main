
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    fullname VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    role ENUM('tenant', 'landlord') NOT NULL
);

CREATE TABLE Tenants (
    tenant_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    full_name VARCHAR(100) NOT NULL,
    contact_info VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);


CREATE TABLE Landlords (
    landlord_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    company_name VARCHAR(100) NOT NULL,
    contact_info VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);


CREATE TABLE Properties (
    property_id INT PRIMARY KEY AUTO_INCREMENT,
    landlord_id INT,
    address VARCHAR(255) NOT NULL,
    description TEXT,
    FOREIGN KEY (landlord_id) REFERENCES Landlords(landlord_id)
);


CREATE TABLE Leases (
    lease_id INT PRIMARY KEY AUTO_INCREMENT,
    property_id INT,
    tenant_id INT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    rent_amount DECIMAL(10, 2) NOT NULL,
    terms TEXT,
    FOREIGN KEY (property_id) REFERENCES Properties(property_id),
    FOREIGN KEY (tenant_id) REFERENCES Tenants(tenant_id)
);


CREATE TABLE MaintenanceRequests (
    request_id INT PRIMARY KEY AUTO_INCREMENT,
    property_id INT,
    tenant_id INT,
    description TEXT NOT NULL,
    status ENUM('pending', 'in_progress', 'completed') NOT NULL,
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Properties(property_id),
    FOREIGN KEY (tenant_id) REFERENCES Tenants(tenant_id)
);


CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    lease_id INT,
    amount DECIMAL(10, 2) NOT NULL,
    date_paid DATE NOT NULL,
    FOREIGN KEY (lease_id) REFERENCES Leases(lease_id)
);


CREATE TABLE Messages (
    message_id INT PRIMARY KEY AUTO_INCREMENT,
    sender_id INT,
    receiver_id INT,
    message TEXT NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES Users(user_id),
    FOREIGN KEY (receiver_id) REFERENCES Users(user_id)
);
/* //access controll */
SELECT t.*, u.username, u.email
FROM Tenants t
INNER JOIN Users u ON t.user_id = u.user_id
WHERE u.user_id = [user_id];
SELECT l.*, u.username, u.email
FROM Landlords l
INNER JOIN Users u ON l.user_id = u.user_id
WHERE u.user_id = [user_id];
