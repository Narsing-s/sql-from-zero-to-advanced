CREATE TEMP TABLE room_booking (room_id integer, valid_during tstzrange NOT NULL, CONSTRAINT room_booking_pk PRIMARY KEY (room_id, valid_during WITHOUT OVERLAPS));
INSERT INTO room_booking VALUES (101, tstzrange('2026-01-01 10:00+00','2026-01-01 11:00+00','[)'));
