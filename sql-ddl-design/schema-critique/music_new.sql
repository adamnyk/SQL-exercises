-- May also want to store: 
  -- separate table for roles?

-- Potential challenges with model / information:
  -- compilation album. Many artists but no one is creditied for the album. Who does album belong to? 
  -- If the song was released as a single, you would need to create a new album for it
  -- More complex queries and joins reqiured to access data. 

DROP DATABASE IF EXISTS music;

CREATE DATABASE music;

\c music

CREATE TABLE albums
(
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  num_tracks INTEGER NOT NULL,
  duration_in_seconds INTEGER NOT NULL,
  release_date DATE NOT NULL, 
  label TEXT NOT NULL
);

CREATE TABLE artists
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE songs
(
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  duration_in_seconds INTEGER NOT NULL,
  release_date DATE NOT NULL,
  album_id INT REFERENCES albums ON DELETE CASCADE
);

CREATE TABLE producers
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE song_producer
(
  id SERIAL PRIMARY KEY,
  song_id INT REFERENCES songs ON DELETE CASCADE,
  producer_id INT REFERENCES producers ON DELETE CASCADE
);

CREATE TABLE song_artist
(
  id SERIAL PRIMARY KEY,
  song_id INT REFERENCES songs ON DELETE CASCADE,
  artist_id INT REFERENCES artists ON DELETE CASCADE,
  role TEXT NOT NULL, 
  role_2 TEXT, 
  role_3 TEXT
);

CREATE TABLE album_artist
(
  id SERIAL PRIMARY KEY,
  song_id INT REFERENCES albums ON DELETE CASCADE,
  album_id INT REFERENCES artists ON DELETE CASCADE
);





-- INSERT INTO songs
--   (title, duration_in_seconds, release_date, artists, album, producers)
-- VALUES
--   ('MMMBop', 238, '04-15-1997', '{"Hanson"}', 'Middle of Nowhere', '{"Dust Brothers", "Stephen Lironi"}'),
--   ('Bohemian Rhapsody', 355, '10-31-1975', '{"Queen"}', 'A Night at the Opera', '{"Roy Thomas Baker"}'),
--   ('One Sweet Day', 282, '11-14-1995', '{"Mariah Cary", "Boyz II Men"}', 'Daydream', '{"Walter Afanasieff"}'),
--   ('Shallow', 216, '09-27-2018', '{"Lady Gaga", "Bradley Cooper"}', 'A Star Is Born', '{"Benjamin Rice"}'),
--   ('How You Remind Me', 223, '08-21-2001', '{"Nickelback"}', 'Silver Side Up', '{"Rick Parashar"}'),
--   ('New York State of Mind', 276, '10-20-2009', '{"Jay Z", "Alicia Keys"}', 'The Blueprint 3', '{"Al Shux"}'),
--   ('Dark Horse', 215, '12-17-2013', '{"Katy Perry", "Juicy J"}', 'Prism', '{"Max Martin", "Cirkut"}'),
--   ('Moves Like Jagger', 201, '06-21-2011', '{"Maroon 5", "Christina Aguilera"}', 'Hands All Over', '{"Shellback", "Benny Blanco"}'),
--   ('Complicated', 244, '05-14-2002', '{"Avril Lavigne"}', 'Let Go', '{"The Matrix"}'),
--   ('Say My Name', 240, '11-07-1999', '{"Destiny''s Child"}', 'The Writing''s on the Wall', '{"Darkchild"}');
