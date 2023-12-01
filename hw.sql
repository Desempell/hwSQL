-- A --

SELECT airport_code, city -> 'ru' FROM airports_data
WHERE city -> 'ru' ? 'Казань' or city -> 'ru' ? 'Москва'
ORDER BY airport_code DESC;


-- B --

SELECT concat(airport_code, airport_name, city, coordinates, timezone) as "Полная информация" FROM airports_data
ORDER BY "Полная информация";


-- С --

SELECT airport_code, COUNT(airport_code) as r FROM airports_data
INNER JOIN flights f on airports_data.airport_code = f.departure_airport
WHERE airport_code IN ('KZN', 'DME', 'OVB', 'IKT', 'LED', 'SVO')
GROUP BY airport_code
ORDER BY r DESC;

-- D --

SELECT airport_code, COUNT(airport_code) as r FROM airports_data
INNER JOIN flights f on airports_data.airport_code = f.departure_airport
WHERE airport_code NOT IN ('KZN', 'DME', 'OVB', 'IKT', 'LED', 'SVO')
GROUP BY airport_code
ORDER BY r;

-- E --

SELECT flight_no, scheduled_arrival, COUNT(tf.ticket_no) as count_pas FROM flights
INNER JOIN ticket_flights tf on flights.flight_id = tf.flight_id
GROUP BY flight_no, scheduled_arrival
HAVING COUNT(tf.ticket_no) > 26 and COUNT(tf.ticket_no) < 91
ORDER BY flight_no DESC, scheduled_arrival DESC, count_pas DESC;

--F --

SELECT passenger_name as "Общий список" FROM tickets
UNION ALL
SELECT (airport_name ->> 'ru')::text FROM airports_data
ORDER BY  "Общий список" DESC;