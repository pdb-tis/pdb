CREATE PROCEDURE AllEvents
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		name,
		description,
		start_date,
		end_date,
		address_id,
		age_rating,
		external_link
	FROM
		event
END

CREATE PROCEDURE EventById
	@eventId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		id,
		name,
		description,
		start_date,
		end_date,
		address_id,
		age_rating,
		external_link
	FROM
		event
	WHERE
		id = @eventId
END

CREATE PROCEDURE EventByAddressId
	@addressId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		id,
		name,
		description,
		start_date,
		end_date,
		address_id,
		age_rating,
		external_link
	FROM
		event
	WHERE
		address_id = @addressId OR
		address_id = NULL
END

CREATE PROCEDURE EventByAddress
	@line1 varchar(50),
	@line2 varchar(50),
	@number smallint,
	@complement varchar(20),
	@postalCode varchar(20),
	@cityId int,
	@province_id smallint
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		id,
		name,
		description,
		start_date,
		end_date,
		address_id,
		age_rating,
		external_link
	FROM
		event
		JOIN address ON event.address_id = address.id
		JOIN city ON address.city_id = city.id
		JOIN province ON city.province_id = province.id
	WHERE
		city.id = @cityId AND
		province.id = @province_id AND
		(address.postal_code = @postalCode OR
			(CONTAINS((address.line1, address.line2), @line1 OR @line2) AND
			address.number = @number AND
			address.complement = @complement)) OR
		event.address_id = NULL
END

CREATE PROCEDURE EventByTimePeriod
	@startDate datetime,
	@endDate datetime
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		id,
		name,
		description,
		start_date,
		end_date,
		address_id,
		age_rating,
		external_link
	FROM
		event
	WHERE
		(start_date >= @startDate AND
		start_date <= @endDate) OR
		(end_date >= @startDate AND
		end_date <= @endDate)
END

CREATE PROCEDURE EventByBandId
	@bandId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		id,
		name,
		description,
		start_date,
		end_date,
		address_id,
		age_rating,
		external_link
	FROM
		event
		JOIN event_band ON event.id = event_band.id
		JOIN band ON event_band.id = band.id
	WHERE
		band.id = @bandId
END