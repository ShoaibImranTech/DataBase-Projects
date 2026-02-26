CREATE DATABASE  Hotel_Booking_System;
USE Hotel_Booking_System; 
-- Table: Guests
CREATE TABLE guests (
    guest_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address TEXT
);

-- Table: Room Types
CREATE TABLE room_types (
    type_id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(50),
    price_per_night DECIMAL(10, 2)
);

-- Table: Rooms
CREATE TABLE rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_number VARCHAR(10) UNIQUE,
    type_id INT,
    is_available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (type_id) REFERENCES room_types(type_id)
);

-- Table: Bookings
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_id INT,
    room_id INT,
    check_in DATE,
    check_out DATE,
    total_amount DECIMAL(10, 2),
    status VARCHAR(20) DEFAULT 'Booked',
    FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

-- Table: Payments
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT,
    payment_date DATE,
    amount_paid DECIMAL(10, 2),
    payment_method VARCHAR(50),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);
-- Room Types
INSERT INTO room_types (type_name, price_per_night)
VALUES
('Single', 50.00),
('Double', 80.00),
('Suite', 150.00);

-- Rooms
INSERT INTO rooms (room_number, type_id, is_available)
VALUES
('101', 1, TRUE),
('102', 1, TRUE),
('201', 2, TRUE),
('301', 3, TRUE);

-- Guests
INSERT INTO guests (full_name, email, phone, address)
VALUES
('Ali Khan', 'ali@gmail.com.com', '03123456789', 'Islamabad'),
('Sara Ahmed', 'sara@gmail.com.com', '03219876543', 'Lahore');

-- Bookings
INSERT INTO bookings (guest_id, room_id, check_in, check_out, total_amount, status)
VALUES
(1, 1, '2025-07-21', '2025-07-25', 200.00, 'Booked'),
(2, 3, '2025-07-22', '2025-07-24', 300.00, 'Booked');

-- Payments
INSERT INTO payments (booking_id, payment_date, amount_paid, payment_method)
VALUES
(1, '2025-07-20', 200.00, 'Credit Card'),
(2, '2025-07-21', 300.00, 'Cash');

-- List all available rooms:
SELECT room_number FROM rooms WHERE is_available = TRUE;

-- Show guest bookings:
SELECT g.full_name, r.room_number, b.check_in, b.check_out
FROM bookings b
JOIN guests g ON b.guest_id = g.guest_id
JOIN rooms r ON b.room_id = r.room_id;

-- Total revenue:
SELECT SUM(amount_paid) AS total_revenue FROM payments;

-- Get booking details for a specific guest:
SELECT g.full_name, b.booking_id, b.check_in, b.check_out, b.total_amount
FROM bookings b
JOIN guests g ON b.guest_id = g.guest_id
WHERE g.full_name = 'Ali Khan';



