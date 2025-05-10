import React, { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import './HotelPage.css'

const HotelPage = () => {
  const { hotel_id } = useParams();
  const [hotel, setHotel] = useState(null);
  const [rooms, setRooms] = useState([]);
  const [selectedDate, setSelectedDate] = useState('');
  const [bookingMessage, setBookingMessage] = useState('');

  useEffect(() => {
    fetch(`http://localhost:5000/api/hotel/${hotel_id}`)
      .then(res => res.json())
      .then(data => setHotel(data))
      .catch(err => console.error("Error fetching hotel details:", err));
  }, [hotel_id]);

  useEffect(() => {
    if (selectedDate && hotel_id) {
      fetch(`http://localhost:5000/api/hotel/${hotel_id}/rooms?date=${selectedDate}`)
        .then(res => res.json())
        .then(data => setRooms(data))
        .catch(err => console.error("Error fetching rooms:", err));
    }
  }, [selectedDate, hotel_id]);

  const handleBooking = (room_id) => {
    const user_id = 1; // You can replace this with the actual logged-in user's ID
    fetch('http://localhost:5000/api/book-room', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ room_id, booking_date: selectedDate, user_id }),
    })
      .then(res => res.json())
      .then(data => setBookingMessage(data.message || 'Booking failed'))
      .catch(err => setBookingMessage('Error booking room'));
  };

  return (
    hotel && (
      <div className="hotel-page">
        <h1>{hotel.name}</h1>
        <p>{hotel.description}</p>
        <img src={hotel.image} alt={hotel.name} />
        <p>{hotel.location}</p>
        <p>Price Range: {hotel.price_range}</p>
        <p>Rating: {hotel.rating}</p>

        <div className="date-selector">
          <input
            type="date"
            value={selectedDate}
            onChange={(e) => setSelectedDate(e.target.value)}
          />
        </div>

        <div className="rooms">
          {rooms.length > 0 ? (
            rooms.map((room) => (
              <div key={room.room_id} className="room">
                <h3>{room.name}</h3>
                <p>{room.description}</p>
                <p>Price: {room.price}</p>
                <button onClick={() => handleBooking(room.room_id)}>
                  Book Room
                </button>
              </div>
            ))
          ) : (
            <p>No rooms available for the selected date</p>
          )}
        </div>

        {bookingMessage && <p>{bookingMessage}</p>}
      </div>
    )
  );
};

export default HotelPage;
