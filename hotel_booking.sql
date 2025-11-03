-- Hotel Booking 

CREATE TABLE hotel_booking.RoomTypes(
    ID SERIAL PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL,
    price_per_night NUMERIC(10,2) CHECK (price_per_night > 0),
    max_capacity INT CHECK (max_capacity > 0)
);


CREATE TABLE hotel_booking.Rooms(
    ID SERIAL PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    room_type_id INT REFERENCES hotel_booking.RoomTypes(ID),
    status VARCHAR(20) CHECK (status IN ('Available', 'Occupied', 'Maintenance')) NOT NULL
);

CREATE TABLE hotel_booking.Customers(
    ID SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL
);

CREATE TABLE hotel_booking.Bookings(
    ID SERIAL PRIMARY KEY,
    customer_id INT REFERENCES hotel_booking.Customers(ID),
    room_id INT REFERENCES hotel_booking.Rooms(ID),
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    status VARCHAR(20) CHECK (status IN ('Pending', 'Confirmed','Cancelled')) 
);

CREATE TABLE hotel_booking.Payments(
    ID SERIAL PRIMARY KEY,
    booking_id INT REFERENCES hotel_booking.Bookings(ID),
    amount NUMERIC(10,2) CHECK(amount > 0),
    payment_date DATE NOT NULL,
    method VARCHAR(20) CHECK(method IN ('Credit Card', 'Cash', 'Bank Transfer'))
);