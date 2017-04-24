CREATE TABLE `address`
(
  `id` integer unsigned NOT NULL AUTO_INCREMENT,
  `line_1` varchar(50),
  `line_2` varchar(50),
  `number` smallint unsigned,
  `complement` varchar(20),
  `city` varchar(20) NOT NULL,
  `province` varchar(20) NOT NULL,
  CONSTRAINT pk_address PRIMARY KEY (`id`)
);

CREATE TABLE `album`
(
  `id` integer unsigned NOT NULL AUTO_INCREMENT,
  `band_id` integer unsigned NOT NULL,
  `birth_date` date NOT NULL,
  `name` varchar(20) NOT NULL,
  `picture_id` bigint unsigned NOT NULL,
  `external_link` varchar(100),
  CONSTRAINT pk_album PRIMARY KEY (`id`)
);

CREATE TABLE `band`
(
  `id` integer unsigned NOT NULL,
  `type_id` tinyint unsigned NOT NULL,
  `birth_date` date NOT NULL,
  `birth_address_id` integer unsigned NOT NULL,
  `description` text,
  `web_site` varchar(100),
  CONSTRAINT pk_band PRIMARY KEY (`id`)
);

CREATE TABLE `band_member`
(
  `id` integer unsigned NOT NULL AUTO_INCREMENT,
  `band_id` integer unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `external_link` varchar(100),
  CONSTRAINT pk_band_member PRIMARY KEY (`id`)
);

CREATE TABLE `en_band_type`
(
  `id` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  CONSTRAINT pk_en_band_type PRIMARY KEY (`id`)
);

CREATE TABLE `en_musical_genre`
(
  `id` integer unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `external_link` varchar(100),
  CONSTRAINT pk_en_musical_genre PRIMARY KEY (`id`)
);

CREATE TABLE `en_musical_genre_sub_genre`
(
  `genre_id` integer unsigned NOT NULL,
  `sub_genre_id` integer unsigned NOT NULL
);

CREATE TABLE `en_social_network_type`
(
  `id` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `external_link` varchar(100) NOT NULL,
  `picture_id` bigint unsigned NOT NULL,
  CONSTRAINT pk_en_social_network PRIMARY KEY (`id`)
);

CREATE TABLE `en_user_type`
(
  `id` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  CONSTRAINT pk_en_user_type PRIMARY KEY (`id`)
);

CREATE TABLE `event`
(
  `id` integer unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `description` text,
  `start_date` datetime,
  `end_date` datetime,
  `address_id` integer unsigned,
  `age_rating` tinyint unsigned NOT NULL,
  `external_link` varchar(100),
  CONSTRAINT pk_event PRIMARY KEY (`id`)
);

CREATE TABLE `event_band`
(
  `event_id` integer unsigned NOT NULL,
  `band_id` integer unsigned NOT NULL
);

CREATE TABLE `event_picture`
(
  `event_id` integer unsigned NOT NULL,
  `picture_id` bigint unsigned NOT NULL
);

CREATE TABLE `event_social_network`
(
  `id` integer unsigned NOT NULL AUTO_INCREMENT,
  `event_id` integer unsigned NOT NULL,
  `social_network_type_id` tinyint unsigned NOT NULL,
  `external_link` varchar(100) NOT NULL,
  CONSTRAINT pk_event_social_network PRIMARY KEY (`id`)
);

CREATE TABLE `fan`
(
  `id` integer unsigned NOT NULL,
  `birth_date` date NOT NULL,
  `birth_address_id` integer unsigned NOT NULL,
  `biography` text,
  CONSTRAINT pk_fan PRIMARY KEY (`id`)
);

CREATE TABLE `picture`
(
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `external_link` varchar(100) NOT NULL,
  `description` text,
  CONSTRAINT pk_picture PRIMARY KEY (`id`)
);

CREATE TABLE `user`
(
  `id` integer unsigned NOT NULL AUTO_INCREMENT,
  `type_id` tinyint unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(20),
  CONSTRAINT pk_user PRIMARY KEY (`id`)
);

CREATE TABLE `user_address`
(
  `user_id` integer unsigned NOT NULL,
  `address_id` integer unsigned NOT NULL
);

CREATE TABLE `user_musical_genre`
(
  `user_id` integer unsigned NOT NULL,
  `musical_genre_id` integer unsigned NOT NULL
);

CREATE TABLE `user_picture`
(
  `user_id` integer unsigned NOT NULL,
  `picture_id` bigint unsigned NOT NULL
);

CREATE TABLE `user_social_network`
(
  `id` integer unsigned NOT NULL AUTO_INCREMENT,
  `user_id` integer unsigned NOT NULL,
  `social_network_type_id` tinyint unsigned NOT NULL,
  `external_link` varchar(100) NOT NULL,
  CONSTRAINT pk_user_social_network PRIMARY KEY (`id`)
);

ALTER TABLE `album` ADD CONSTRAINT `fk_album_band`
  FOREIGN KEY (`band_id`) REFERENCES `band` (`id`) ON UPDATE NO ACTION;

ALTER TABLE `album` ADD CONSTRAINT `fk_album_picture`
  FOREIGN KEY (`picture_id`) REFERENCES `picture` (`id`) ON UPDATE CASCADE;

ALTER TABLE `band` ADD CONSTRAINT `fk_band_band_type`
  FOREIGN KEY (`type_id`) REFERENCES `en_band_type` (`id`) ON UPDATE NO ACTION;

ALTER TABLE `band` ADD CONSTRAINT `fk_band_birth_address`
  FOREIGN KEY (`birth_address_id`) REFERENCES `address` (`id`) ON UPDATE CASCADE;

ALTER TABLE `band` ADD CONSTRAINT `fk_band_user`
  FOREIGN KEY (`id`) REFERENCES `user` (`id`) ON UPDATE CASCADE;

ALTER TABLE `band_member` ADD CONSTRAINT `fk_band_member_band`
  FOREIGN KEY (`band_id`) REFERENCES `band` (`id`) ON UPDATE NO ACTION;

ALTER TABLE `en_musical_genre_sub_genre` ADD CONSTRAINT `fk_en_musical_genre`
  FOREIGN KEY (`genre_id`) REFERENCES `en_musical_genre` (`id`) ON UPDATE NO ACTION;

ALTER TABLE `en_musical_genre_sub_genre` ADD CONSTRAINT `fk_en_musical_genre_sub_genre`
  FOREIGN KEY (`sub_genre_id`) REFERENCES `en_musical_genre` (`id`) ON UPDATE NO ACTION;

ALTER TABLE `event_band` ADD CONSTRAINT `fk_event_band_band`
  FOREIGN KEY (`band_id`) REFERENCES `band` (`id`) ON UPDATE NO ACTION;

ALTER TABLE `event_band` ADD CONSTRAINT `fk_event_band_event`
  FOREIGN KEY (`event_id`) REFERENCES `event` (`id`) ON UPDATE NO ACTION;

ALTER TABLE `event_picture` ADD CONSTRAINT `fk_event_picture_event`
  FOREIGN KEY (`event_id`) REFERENCES `event` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `event_picture` ADD CONSTRAINT `fk_event_picture_picture`
  FOREIGN KEY (`picture_id`) REFERENCES `picture` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE `event_social_network` ADD CONSTRAINT `fk_event_social_network_en_social_network_type`
  FOREIGN KEY (`social_network_type_id`) REFERENCES `en_social_network_type` (`id`) ON UPDATE NO ACTION;

ALTER TABLE `event_social_network` ADD CONSTRAINT `fk_event_social_network_event`
  FOREIGN KEY (`event_id`) REFERENCES `event` (`id`) ON UPDATE NO ACTION;

ALTER TABLE `fan` ADD CONSTRAINT `fk_fan_birth_address`
  FOREIGN KEY (`birth_address_id`) REFERENCES `address` (`id`) ON UPDATE CASCADE;

ALTER TABLE `fan` ADD CONSTRAINT `fk_fan_user`
  FOREIGN KEY (`id`) REFERENCES `user` (`id`) ON UPDATE CASCADE;

ALTER TABLE `user` ADD CONSTRAINT `fk_user_en_user_type`
  FOREIGN KEY (`type_id`) REFERENCES `en_user_type` (`id`) ON UPDATE NO ACTION;

ALTER TABLE `user_address` ADD CONSTRAINT `fk_user_address_address`
  FOREIGN KEY (`address_id`) REFERENCES `address` (`id`) ON UPDATE CASCADE;

ALTER TABLE `user_address` ADD CONSTRAINT `fk_user_address_user`
  FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON UPDATE CASCADE;

ALTER TABLE `user_musical_genre` ADD CONSTRAINT `fk_user_musical_genre_musical_genre`
  FOREIGN KEY (`musical_genre_id`) REFERENCES `en_musical_genre` (`id`) ON UPDATE NO ACTION;

ALTER TABLE `user_musical_genre` ADD CONSTRAINT `fk_user_musical_genre_user`
  FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON UPDATE NO ACTION;

ALTER TABLE `user_picture` ADD CONSTRAINT `fk_user_picture_picture`
  FOREIGN KEY (`picture_id`) REFERENCES `picture` (`id`) ON UPDATE CASCADE;

ALTER TABLE `user_picture` ADD CONSTRAINT `fk_user_picture_user`
  FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON UPDATE NO ACTION;

ALTER TABLE `user_social_network` ADD CONSTRAINT `fk_user_social_network_en_social_network_type`
  FOREIGN KEY (`social_network_type_id`) REFERENCES `en_social_network_type` (`id`) ON UPDATE NO ACTION;

ALTER TABLE `user_social_network` ADD CONSTRAINT `fk_user_social_network_user`
  FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON UPDATE NO ACTION;

