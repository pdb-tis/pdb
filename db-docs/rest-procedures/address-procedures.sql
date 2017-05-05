CREATE PROCEDURE AllAddresses
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		id,
		line_1,
		line_2,
		number,
		complement,
		city_id,
		postal_code
	FROM
		address
END

CREATE PROCEDURE AddressByCityId
	@cityId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		id,
		line_1,
		line_2,
		number,
		complement,
		city_id,
		postal_code
	FROM
		address
		JOIN city ON address.city_id = city.id
	WHERE
		city.id = @cityId
END

CREATE PROCEDURE AddressByProvinceId
	@provinceId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		id,
		line_1,
		line_2,
		number,
		complement,
		city_id,
		postal_code
	FROM
		address
		JOIN city ON address.city_id = city.id
		JOIN province ON city.province_id = province.id
	WHERE
		province.id = @provinceId
END

CREATE PROCEDURE AddressBy
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
		line_1,
		line_2,
		number,
		complement,
		city_id,
		postal_code
	FROM
		address
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