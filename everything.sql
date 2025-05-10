
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE hotels (
    hotel_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    photo_url VARCHAR(255),
    location VARCHAR(100),
    rating DECIMAL(2, 1)  -- e.g., 4.5
);

CREATE TABLE rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    hotel_id INT NOT NULL,
    room_name VARCHAR(100),
    room_type VARCHAR(50),           -- e.g., Single, Double, Suite
    price DECIMAL(10, 2),            -- Price per night
    max_occupancy INT,
    description TEXT,
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id)
);










ALTER TABLE rooms
ADD room_name VARCHAR(100), 
ADD room_type VARCHAR(50), 
ADD max_occupancy INT,
ADD description TEXT,
ADD created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ADD updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE rooms
RENAME COLUMN availability TO room_availability;

ALTER TABLE rooms
RENAME COLUMN type TO room_type;

ALTER TABLE rooms
ADD FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id);

ALTER TABLE rooms
MODIFY price DECIMAL(10, 2);












CREATE TABLE room_availability (
    availability_id INT AUTO_INCREMENT PRIMARY KEY,
    room_id INT NOT NULL,                     -- Foreign key from rooms table
    available_date DATE NOT NULL,             -- Date of availability
    availability BOOLEAN DEFAULT TRUE,        -- TRUE means available, FALSE means unavailable
    FOREIGN KEY (room_id) REFERENCES rooms(room_id) ON DELETE CASCADE
);

CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    room_id INT,
    user_id INT,
    booking_date DATE,
    check_in_date DATE,
    check_out_date DATE,
    total_price DECIMAL(10, 2),
    status VARCHAR(50),  -- E.g., Confirmed, Pending, Cancelled
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (room_id) REFERENCES rooms(room_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)  -- Assuming a users table exists
);













INSERT INTO hotels (name, description, photo_url, location, rating)
VALUES
('Ocean Breeze Resort', 'A beachfront resort offering modern amenities and stunning sea views.', 'https://example.com/hotel1.jpg', 'Goa', 4.6),
('Urban Stay Inn', 'Perfect for business travelers with easy access to the city center.', 'https://example.com/hotel2.jpg', 'Bangalore', 4.3),
('Hilltop Retreat', 'A peaceful retreat nestled in the hills, ideal for families.', 'https://example.com/hotel3.jpg', 'Ooty', 4.5),
('City Central Hotel', 'Located in the heart of the city with all modern conveniences.', 'https://example.com/hotel4.jpg', 'Mumbai', 4.1),
('Palm Grove Villas', 'A cozy escape surrounded by palm trees and nature.', 'https://example.com/hotel5.jpg', 'Kerala', 4.4),
('The Heritage Grand', 'Luxurious hotel with heritage-inspired architecture.', 'https://example.com/hotel6.jpg', 'Jaipur', 4.7),
('Skyline Towers', 'Stylish rooms with a city skyline view.', 'https://example.com/hotel7.jpg', 'Delhi', 4.2),
('Lakeside Inn', 'Romantic setting by the lake with premium services.', 'https://example.com/hotel8.jpg', 'Udaipur', 4.6),
('Royal Orchid Stay', 'Elegant hotel near major tourist attractions.', 'https://example.com/hotel9.jpg', 'Chennai', 4.3),
('The Regal Suites', 'Top-tier accommodations with luxury spa and dining.', 'https://example.com/hotel10.jpg', 'Hyderabad', 4.8);













INSERT INTO rooms (hotel_id, room_name, room_type, price, max_occupancy, description)
VALUES
-- Hotel 1
(1, 'Sea View Deluxe', 'Double', 180.00, 2, 'Spacious room with a sea view and balcony.'),
(1, 'Economy Room', 'Single', 100.00, 1, 'Affordable room ideal for short stays.'),

-- Hotel 2
(2, 'Executive Suite', 'Suite', 300.00, 4, 'Luxurious suite with modern decor and lounge.'),
(2, 'Standard Double', 'Double', 160.00, 2, 'Well-equipped double room with garden view.'),

-- Hotel 3
(3, 'Family Room', 'Suite', 250.00, 5, 'Family suite with multiple beds and spacious interior.'),
(3, 'Compact Single', 'Single', 90.00, 1, 'Cozy single room with modern amenities.'),

-- Hotel 4
(4, 'Deluxe King', 'Double', 200.00, 2, 'Elegant room with king-size bed and luxury features.'),
(4, 'Standard Room', 'Single', 95.00, 1, 'Comfortable standard single room.'),

-- Hotel 5
(5, 'Panoramic Suite', 'Suite', 350.00, 4, 'Suite with panoramic views and deluxe bathroom.'),
(5, 'Twin Room', 'Double', 150.00, 2, 'Room with two single beds, perfect for sharing.'),

-- Hotel 6
(6, 'Heritage Room', 'Double', 170.00, 2, 'Stylish room with heritage interiors and comfort.'),
(6, 'Business Room', 'Single', 120.00, 1, 'Ideal for business travelers with workspace.'),

-- Hotel 7
(7, 'Luxury Suite', 'Suite', 400.00, 4, 'Top-tier suite with luxury amenities and large lounge.'),
(7, 'Basic Room', 'Single', 85.00, 1, 'Simple room for budget-conscious guests.'),

-- Hotel 8
(8, 'Couple’s Retreat', 'Double', 190.00, 2, 'Romantic room for couples with cozy lighting.'),
(8, 'Mini Suite', 'Suite', 220.00, 3, 'Small suite with extra space and sitting area.'),

-- Hotel 9
(9, 'Executive King', 'Double', 210.00, 2, 'High-end double room with workspace and view.'),
(9, 'Solo Stay', 'Single', 95.00, 1, 'Ideal for solo travelers with minimal needs.'),

-- Hotel 10
(10, 'Royal Suite', 'Suite', 420.00, 4, 'Premium suite with royal decor and private lounge.'),
(10, 'Standard Double', 'Double', 160.00, 2, 'Balanced room with modern facilities.');


















-- Hotel 1: Rooms 1, 2, 3
INSERT INTO room_availability (room_id, available_date, availability) VALUES
(1, '2025-05-07', TRUE), (1, '2025-05-08', TRUE), (1, '2025-05-09', FALSE), (1, '2025-05-10', TRUE), (1, '2025-05-11', TRUE),
(2, '2025-05-07', TRUE), (2, '2025-05-08', FALSE), (2, '2025-05-09', TRUE), (2, '2025-05-10', TRUE), (2, '2025-05-11', TRUE),
(3, '2025-05-07', TRUE), (3, '2025-05-08', TRUE), (3, '2025-05-09', TRUE), (3, '2025-05-10', FALSE), (3, '2025-05-11', TRUE);

-- Hotel 2: Rooms 4, 5, 6
INSERT INTO room_availability (room_id, available_date, availability) VALUES
(4, '2025-05-07', FALSE), (4, '2025-05-08', TRUE), (4, '2025-05-09', TRUE), (4, '2025-05-10', TRUE), (4, '2025-05-11', TRUE),
(5, '2025-05-07', TRUE), (5, '2025-05-08', TRUE), (5, '2025-05-09', FALSE), (5, '2025-05-10', TRUE), (5, '2025-05-11', TRUE),
(6, '2025-05-07', TRUE), (6, '2025-05-08', TRUE), (6, '2025-05-09', TRUE), (6, '2025-05-10', TRUE), (6, '2025-05-11', FALSE);

-- Hotel 3: Rooms 7, 8, 9
INSERT INTO room_availability (room_id, available_date, availability) VALUES
(7, '2025-05-07', TRUE), (7, '2025-05-08', FALSE), (7, '2025-05-09', TRUE), (7, '2025-05-10', TRUE), (7, '2025-05-11', TRUE),
(8, '2025-05-07', TRUE), (8, '2025-05-08', TRUE), (8, '2025-05-09', TRUE), (8, '2025-05-10', FALSE), (8, '2025-05-11', TRUE),
(9, '2025-05-07', FALSE), (9, '2025-05-08', TRUE), (9, '2025-05-09', TRUE), (9, '2025-05-10', TRUE), (9, '2025-05-11', TRUE);

-- Hotel 4: Rooms 10, 11, 12
INSERT INTO room_availability (room_id, available_date, availability) VALUES
(10, '2025-05-07', TRUE), (10, '2025-05-08', TRUE), (10, '2025-05-09', FALSE), (10, '2025-05-10', TRUE), (10, '2025-05-11', TRUE),
(11, '2025-05-07', TRUE), (11, '2025-05-08', TRUE), (11, '2025-05-09', TRUE), (11, '2025-05-10', TRUE), (11, '2025-05-11', FALSE),
(12, '2025-05-07', FALSE), (12, '2025-05-08', TRUE), (12, '2025-05-09', TRUE), (12, '2025-05-10', TRUE), (12, '2025-05-11', TRUE);

-- Hotel 5: Rooms 13, 14, 15
INSERT INTO room_availability (room_id, available_date, availability) VALUES
(13, '2025-05-07', TRUE), (13, '2025-05-08', TRUE), (13, '2025-05-09', TRUE), (13, '2025-05-10', FALSE), (13, '2025-05-11', TRUE),
(14, '2025-05-07', TRUE), (14, '2025-05-08', FALSE), (14, '2025-05-09', TRUE), (14, '2025-05-10', TRUE), (14, '2025-05-11', TRUE),
(15, '2025-05-07', FALSE), (15, '2025-05-08', TRUE), (15, '2025-05-09', TRUE), (15, '2025-05-10', TRUE), (15, '2025-05-11', TRUE);

-- Hotel 6: Rooms 16, 17, 18
INSERT INTO room_availability (room_id, available_date, availability) VALUES
(16, '2025-05-07', TRUE), (16, '2025-05-08', TRUE), (16, '2025-05-09', TRUE), (16, '2025-05-10', FALSE), (16, '2025-05-11', TRUE),
(17, '2025-05-07', TRUE), (17, '2025-05-08', TRUE), (17, '2025-05-09', FALSE), (17, '2025-05-10', TRUE), (17, '2025-05-11', TRUE),
(18, '2025-05-07', FALSE), (18, '2025-05-08', TRUE), (18, '2025-05-09', TRUE), (18, '2025-05-10', TRUE), (18, '2025-05-11', TRUE);

-- Hotel 7: Rooms 19, 20, 21
INSERT INTO room_availability (room_id, available_date, availability) VALUES
(19, '2025-05-07', TRUE), (19, '2025-05-08', TRUE), (19, '2025-05-09', TRUE), (19, '2025-05-10', TRUE), (19, '2025-05-11', FALSE),
(20, '2025-05-07', TRUE), (20, '2025-05-08', TRUE), (20, '2025-05-09', TRUE), (20, '2025-05-10', FALSE), (20, '2025-05-11', TRUE),
(21, '2025-05-07', FALSE), (21, '2025-05-08', TRUE), (21, '2025-05-09', TRUE), (21, '2025-05-10', TRUE), (21, '2025-05-11', TRUE);

-- Hotel 8: Rooms 22, 23, 24
INSERT INTO room_availability (room_id, available_date, availability) VALUES
(22, '2025-05-07', TRUE), (22, '2025-05-08', TRUE), (22, '2025-05-09', FALSE), (22, '2025-05-10', TRUE), (22, '2025-05-11', TRUE),
(23, '2025-05-07', TRUE), (23, '2025-05-08', TRUE), (23, '2025-05-09', TRUE), (23, '2025-05-10', TRUE), (23, '2025-05-11', FALSE),
(24, '2025-05-07', FALSE), (24, '2025-05-08', TRUE), (24, '2025-05-09', TRUE), (24, '2025-05-10', TRUE), (24, '2025-05-11', TRUE);

-- Hotel 9: Rooms 25, 26, 27
INSERT INTO room_availability (room_id, available_date, availability) VALUES
(25, '2025-05-07', TRUE), (25, '2025-05-08', TRUE), (25, '2025-05-09', TRUE), (25, '2025-05-10', FALSE), (25, '2025-05-11', TRUE),
(26, '2025-05-07', TRUE), (26, '2025-05-08', TRUE), (26, '2025-05-09', TRUE), (26, '2025-05-10', TRUE), (26, '2025-05-11', TRUE),
(27, '2025-05-07', FALSE), (27, '2025-05-08', TRUE), (27, '2025-05-09', TRUE), (27, '2025-05-10', TRUE), (27, '2025-05-11', FALSE);

-- Hotel 10: Rooms 28, 29, 30
INSERT INTO room_availability (room_id, available_date, availability) VALUES
(28, '2025-05-07', TRUE), (28, '2025-05-08', FALSE), (28, '2025-05-09', TRUE), (28, '2025-05-10', TRUE), (28, '2025-05-11', TRUE),
(29, '2025-05-07', TRUE), (29, '2025-05-08', TRUE), (29, '2025-05-09', TRUE), (29, '2025-05-10', FALSE), (29, '2025-05-11', TRUE),
(30, '2025-05-07', FALSE), (30, '2025-05-08', TRUE), (30, '2025-05-09', TRUE), (30, '2025-05-10', TRUE), (30, '2025-05-11', TRUE);
