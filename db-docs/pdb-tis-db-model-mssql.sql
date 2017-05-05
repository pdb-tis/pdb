CREATE TABLE address
(
  [id] integer check ([id] > 0) NOT NULL IDENTITY,
  [line_1] varchar(50),
  [line_2] varchar(50),
  [number] smallint check ([number] > 0),
  [complement] varchar(20),
  [city_id] integer check ([city_id] > 0) NOT NULL,
  [postal_code] varchar(20),
  CONSTRAINT pk_address PRIMARY KEY ([id])
);

CREATE TABLE album
(
  [id] integer check ([id] > 0) NOT NULL IDENTITY,
  [band_id] integer check ([band_id] > 0) NOT NULL,
  [birth_date] date NOT NULL,
  [name] varchar(20) NOT NULL,
  [picture_id] bigint check ([picture_id] > 0) NOT NULL,
  [external_link] varchar(100),
  CONSTRAINT pk_album PRIMARY KEY ([id])
);

CREATE TABLE band
(
  [id] integer check ([id] > 0) NOT NULL,
  [type_id] smallint check ([type_id] > 0) NOT NULL,
  [birth_date] date NOT NULL,
  [birth_address_id] integer check ([birth_address_id] > 0) NOT NULL,
  [description] varchar(max),
  [web_site] varchar(100),
  CONSTRAINT pk_band PRIMARY KEY ([id])
);

CREATE TABLE band_member
(
  [id] integer check ([id] > 0) NOT NULL IDENTITY,
  [band_id] integer check ([band_id] > 0) NOT NULL,
  [name] varchar(50) NOT NULL,
  [external_link] varchar(100),
  CONSTRAINT pk_band_member PRIMARY KEY ([id])
);

CREATE TABLE city
(
  [id] integer check ([id] > 0) NOT NULL IDENTITY,
  [name] varchar(50) NOT NULL,
  [province_id] smallint check ([province_id] > 0) NOT NULL,
  CONSTRAINT pk_city PRIMARY KEY ([id])
);

CREATE TABLE customer
(
  [id] integer check ([id] > 0) NOT NULL IDENTITY,
  [type_id] smallint check ([type_id] > 0) NOT NULL,
  [name] varchar(50) NOT NULL,
  [email] varchar(50) NOT NULL,
  [phone] varchar(20),
  CONSTRAINT pk_customer PRIMARY KEY ([id])
);

CREATE TABLE customer_address
(
  [customer_id] integer check ([customer_id] > 0) NOT NULL,
  [address_id] integer check ([address_id] > 0) NOT NULL
);

CREATE TABLE customer_musical_genre
(
  [customer_id] integer check ([customer_id] > 0) NOT NULL,
  [musical_genre_id] integer check ([musical_genre_id] > 0) NOT NULL
);

CREATE TABLE customer_picture
(
  [customer_id] integer check ([customer_id] > 0) NOT NULL,
  [picture_id] bigint check ([picture_id] > 0) NOT NULL
);

CREATE TABLE customer_social_network
(
  [id] integer check ([id] > 0) NOT NULL IDENTITY,
  [customer_id] integer check ([customer_id] > 0) NOT NULL,
  [social_network_type_id] smallint check ([social_network_type_id] > 0) NOT NULL,
  [external_link] varchar(100) NOT NULL,
  CONSTRAINT pk_customer_social_network PRIMARY KEY ([id])
);

CREATE TABLE en_band_type
(
  [id] smallint check ([id] > 0) NOT NULL IDENTITY,
  [name] varchar(20) NOT NULL,
  CONSTRAINT pk_en_band_type PRIMARY KEY ([id])
);

CREATE TABLE en_customer_type
(
  [id] smallint check ([id] > 0) NOT NULL IDENTITY,
  [name] varchar(20) NOT NULL,
  CONSTRAINT pk_en_customer_type PRIMARY KEY ([id])
);

CREATE TABLE en_musical_genre
(
  [id] integer check ([id] > 0) NOT NULL IDENTITY,
  [name] varchar(50) NOT NULL,
  [external_link] varchar(100),
  CONSTRAINT pk_en_musical_genre PRIMARY KEY ([id])
);

CREATE TABLE en_musical_genre_sub_genre
(
  [genre_id] integer check ([genre_id] > 0) NOT NULL,
  [sub_genre_id] integer check ([sub_genre_id] > 0) NOT NULL
);

CREATE TABLE en_social_network_type
(
  [id] smallint check ([id] > 0) NOT NULL IDENTITY,
  [name] varchar(20) NOT NULL,
  [external_link] varchar(100) NOT NULL,
  [picture_id] bigint check ([picture_id] > 0) NOT NULL,
  CONSTRAINT pk_en_social_network PRIMARY KEY ([id])
);

CREATE TABLE event
(
  [id] integer check ([id] > 0) NOT NULL IDENTITY,
  [name] varchar(20) NOT NULL,
  [description] varchar(max),
  [start_date] datetime2(0),
  [end_date] datetime2(0),
  [address_id] integer check ([address_id] > 0),
  [age_rating] smallint check ([age_rating] > 0) NOT NULL,
  [external_link] varchar(100),
  CONSTRAINT pk_event PRIMARY KEY ([id])
);

CREATE TABLE event_band
(
  [event_id] integer check ([event_id] > 0) NOT NULL,
  [band_id] integer check ([band_id] > 0) NOT NULL
);

CREATE TABLE event_picture
(
  [event_id] integer check ([event_id] > 0) NOT NULL,
  [picture_id] bigint check ([picture_id] > 0) NOT NULL
);

CREATE TABLE event_social_network
(
  [id] integer check ([id] > 0) NOT NULL IDENTITY,
  [event_id] integer check ([event_id] > 0) NOT NULL,
  [social_network_type_id] smallint check ([social_network_type_id] > 0) NOT NULL,
  [external_link] varchar(100) NOT NULL,
  CONSTRAINT pk_event_social_network PRIMARY KEY ([id])
);

CREATE TABLE fan
(
  [id] integer check ([id] > 0) NOT NULL,
  [birth_date] date NOT NULL,
  [birth_address_id] integer check ([birth_address_id] > 0) NOT NULL,
  [biography] varchar(max),
  CONSTRAINT pk_fan PRIMARY KEY ([id])
);

CREATE TABLE picture
(
  [id] bigint check ([id] > 0) NOT NULL IDENTITY,
  [external_link] varchar(100) NOT NULL,
  [description] varchar(max),
  CONSTRAINT pk_picture PRIMARY KEY ([id])
);

CREATE TABLE province
(
  [id] smallint check ([id] > 0) NOT NULL,
  [name] varchar(20) NOT NULL,
  [initials] varchar(2) NOT NULL,
  CONSTRAINT pk_province PRIMARY KEY ([id])
);

ALTER TABLE [address] ADD CONSTRAINT [fk_address_city]
  FOREIGN KEY ([city_id]) REFERENCES city ([id]);

ALTER TABLE [album] ADD CONSTRAINT [fk_album_band]
  FOREIGN KEY ([band_id]) REFERENCES band ([id]);

ALTER TABLE [album] ADD CONSTRAINT [fk_album_picture]
  FOREIGN KEY ([picture_id]) REFERENCES picture ([id]);

ALTER TABLE [band] ADD CONSTRAINT [fk_band_band_type]
  FOREIGN KEY ([type_id]) REFERENCES en_band_type ([id]);

ALTER TABLE [band] ADD CONSTRAINT [fk_band_birth_address]
  FOREIGN KEY ([birth_address_id]) REFERENCES address ([id]);

ALTER TABLE [band] ADD CONSTRAINT [fk_band_user]
  FOREIGN KEY ([id]) REFERENCES customer ([id]);

ALTER TABLE [band_member] ADD CONSTRAINT [fk_band_member_band]
  FOREIGN KEY ([band_id]) REFERENCES band ([id]);

ALTER TABLE [city] ADD CONSTRAINT [fk_city_province]
  FOREIGN KEY ([province_id]) REFERENCES province ([id]);

ALTER TABLE [customer] ADD CONSTRAINT [fk_customer_en_customer_type]
  FOREIGN KEY ([type_id]) REFERENCES en_customer_type ([id]);

ALTER TABLE [customer_address] ADD CONSTRAINT [fk_customer_address_address]
  FOREIGN KEY ([address_id]) REFERENCES address ([id]);

ALTER TABLE [customer_address] ADD CONSTRAINT [fk_customer_address_user]
  FOREIGN KEY ([customer_id]) REFERENCES customer ([id]);

ALTER TABLE [customer_musical_genre] ADD CONSTRAINT [fk_customer_musical_genre_musical_genre]
  FOREIGN KEY ([musical_genre_id]) REFERENCES en_musical_genre ([id]);

ALTER TABLE [customer_musical_genre] ADD CONSTRAINT [fk_customer_musical_genre_user]
  FOREIGN KEY ([customer_id]) REFERENCES customer ([id]);

ALTER TABLE [customer_picture] ADD CONSTRAINT [fk_customer_picture_customer]
  FOREIGN KEY ([customer_id]) REFERENCES customer ([id]);

ALTER TABLE [customer_picture] ADD CONSTRAINT [fk_customer_picture_picture]
  FOREIGN KEY ([picture_id]) REFERENCES picture ([id]);

ALTER TABLE [customer_social_network] ADD CONSTRAINT [fk_customer_social_network_customer]
  FOREIGN KEY ([customer_id]) REFERENCES customer ([id]);

ALTER TABLE [customer_social_network] ADD CONSTRAINT [fk_customer_social_network_en_social_network_type]
  FOREIGN KEY ([social_network_type_id]) REFERENCES en_social_network_type ([id]);

ALTER TABLE [en_musical_genre_sub_genre] ADD CONSTRAINT [fk_en_musical_genre]
  FOREIGN KEY ([genre_id]) REFERENCES en_musical_genre ([id]);

ALTER TABLE [en_musical_genre_sub_genre] ADD CONSTRAINT [fk_en_musical_genre_sub_genre]
  FOREIGN KEY ([sub_genre_id]) REFERENCES en_musical_genre ([id]);

ALTER TABLE [event] ADD CONSTRAINT [fk_event_address]
  FOREIGN KEY ([address_id]) REFERENCES address ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE [event_band] ADD CONSTRAINT [fk_event_band_band]
  FOREIGN KEY ([band_id]) REFERENCES band ([id]);

ALTER TABLE [event_band] ADD CONSTRAINT [fk_event_band_event]
  FOREIGN KEY ([event_id]) REFERENCES event ([id]);

ALTER TABLE [event_picture] ADD CONSTRAINT [fk_event_picture_event]
  FOREIGN KEY ([event_id]) REFERENCES event ([id]);

ALTER TABLE [event_picture] ADD CONSTRAINT [fk_event_picture_picture]
  FOREIGN KEY ([picture_id]) REFERENCES picture ([id]);

ALTER TABLE [event_social_network] ADD CONSTRAINT [fk_event_social_network_en_social_network_type]
  FOREIGN KEY ([social_network_type_id]) REFERENCES en_social_network_type ([id]);

ALTER TABLE [event_social_network] ADD CONSTRAINT [fk_event_social_network_event]
  FOREIGN KEY ([event_id]) REFERENCES event ([id]);

ALTER TABLE [fan] ADD CONSTRAINT [fk_fan_birth_address]
  FOREIGN KEY ([birth_address_id]) REFERENCES address ([id]);

ALTER TABLE [fan] ADD CONSTRAINT [fk_fan_user]
  FOREIGN KEY ([id]) REFERENCES customer ([id]);