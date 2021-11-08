/*
AGENCIA (RAZON_SOCIAL, dirección, telef, e-mail)
CIUDAD (CODIGOPOSTAL, nombreCiudad, añoCreación)
CLIENTE (DNI, nombre, apellido, teléfono, dirección)
VIAJE( FECHA,HORA,DNI, cpOrigen(fk), cpDestino(fk), razon_social(fk), descripcion)
//cpOrigen y cpDestino corresponden a la ciudades origen y destino del viaje
1. Listar razón social, dirección y teléfono de agencias que realizaron viajes desde la ciudad de
‘La Plata’ (ciudad origen) y que el cliente tenga apellido ‘Roma’. Ordenar por razón social y
luego por teléfono.
2. Listar fecha, hora, datos personales del cliente, ciudad origen y destino de viajes realizados
en enero de 2019 donde la descripción del viaje contenga el String ‘demorado’.
3. Reportar información de agencias que realizaron viajes durante 2019 o que tengan dirección
de mail que termine con ‘@jmail.com’.
4. Listar datos personales de clientes que viajaron solo con destino a la ciudad de ‘Coronel
Brandsen’
5. Informar cantidad de viajes de la agencia con razón social ‘TAXI Y’ realizados a ‘Villa Elisa’.
6. Listar nombre, apellido, dirección y teléfono de clientes que viajaron con todas las agencias.
7. Modificar el cliente con DNI: 38495444 actualizando el teléfono a: 221-4400897.
8. Listar razon_social, dirección y teléfono de la/s agencias que tengan mayor cantidad de
viajes realizados.
9. Reportar nombre, apellido, dirección y teléfono de clientes con al menos 10 viajes.
10. Borrar al cliente con DNI 40325692.
*/


create database ej1;

-- crea tabla agencia (razon_social, direccion, telef, e-mail)
CREATE TABLE agencia (
  razon_social VARCHAR(50) NOT NULL,
  direccion VARCHAR(50) NOT NULL,
  telef VARCHAR(50) NOT NULL,
  e_mail VARCHAR(50) NOT NULL,
  PRIMARY KEY (razon_social)
);
-- crea tabla ciudad (codigoPostal, nombreCiudad, anoCreacion)
CREATE TABLE ciudad (
  codigoPostal VARCHAR(50) NOT NULL,
  nombreCiudad VARCHAR(50) NOT NULL,
  anoCreacion VARCHAR(50) NOT NULL,
  PRIMARY KEY (codigoPostal)
);
-- crea tabla cliente (DNI, nombre, apellido, telefono, direccion)
CREATE TABLE cliente (
  DNI VARCHAR(50) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  telefono VARCHAR(50) NOT NULL,
  direccion VARCHAR(50) NOT NULL,
  PRIMARY KEY (DNI)
);
-- crea tabla viaje (FECHA,HORA,DNI, cpOrigen(fk), cpDestino(fk), razon_social(fk), descripcion)
CREATE TABLE viaje (
  FECHA VARCHAR(50) NOT NULL,
  HORA VARCHAR(50) NOT NULL,
  DNI VARCHAR(50) NOT NULL,
  cpOrigen VARCHAR(50) NOT NULL,
  cpDestino VARCHAR(50) NOT NULL,
  razon_social VARCHAR(50) NOT NULL,
  descripcion VARCHAR(50) NOT NULL,
  PRIMARY KEY (FECHA,HORA,DNI,cpOrigen,cpDestino,razon_social,descripcion)
);
-- inserta datos de prueba en las tablas
INSERT INTO agencia VALUES ('TAXI A', 'Av. Corrientes', '4-5-600', 'taxia@jmail.com');
INSERT INTO agencia VALUES ('TAXI B', 'Av. Corrientes', '4-5-611', 'taxib@jmail.com');
INSERT INTO agencia VALUES ('TAXI C', 'Av. Corrientes', '4-5-622', 'taxic@gmail.com');
INSERT INTO agencia VALUES ('TAXI D', 'Av. Corrientes', '4-5-633', 'taxid@gmail.com');
INSERT INTO ciudad VALUES ('1400', 'La Plata', '1930');
INSERT INTO ciudad VALUES ('1401', 'La Cumbre', '1940');
INSERT INTO ciudad VALUES ('1402', 'La Cebada', '1950');
INSERT INTO ciudad VALUES ('1403', 'Coronel Brandsen', '1960');
INSERT INTO ciudad VALUES ('1404', 'Villa Elisa', '1970');
INSERT INTO ciudad VALUES ('1405', 'Buenos Aires', '1980');
INSERT INTO ciudad VALUES ('1406', 'Ensenada', '1990');
INSERT INTO cliente VALUES ('38495444', 'Juan', 'Roma', '221-4400000', 'Av. Corrientes0');
INSERT INTO cliente VALUES ('40325692', 'Maria', 'Gonzalez', '221-4400001', 'Av. Corrientes1');
INSERT INTO cliente VALUES ('40325693', 'Jose', 'Gonzalez', '221-4400002', 'Av. Corrientes2');
INSERT INTO cliente VALUES ('40325694', 'Pedro', 'Gonzalez', '221-4400003', 'Av. Corrientes3');
INSERT INTO cliente VALUES ('40325695', 'Juan', 'Gonzalez', '221-4400004', 'Av. Corrientes4');
INSERT INTO cliente VALUES ('40325696', 'Jimena', 'Gonzalez', '221-4400005', 'Av. Corrientes5');
INSERT INTO viaje VALUES ('2019-01-01', '10:00', '38495444', '1400', '1401', 'TAXI D', 'demorado');
INSERT INTO viaje VALUES ('2019-01-02', '10:00', '40325692', '1403', '1402', 'TAXI A', 'demorado');
INSERT INTO viaje VALUES ('2019-01-03', '18:00', '40325693', '1400', '1403', 'TAXI B', 'en hora');
INSERT INTO viaje VALUES ('2019-01-04', '18:00', '40325694', '1400', '1404', 'TAXI C', 'demorado');
INSERT INTO viaje VALUES ('2019-01-05', '08:00', '40325692', '1403', '1405', 'TAXI D', 'demorado');
INSERT INTO viaje VALUES ('2019-01-05', '08:00', '40325694', '1403', '1406', 'TAXI A', 'en hora');
INSERT INTO viaje VALUES ('2019-01-06', '09:20', '40325695', '1406', '1402', 'TAXI C', 'en hora');
INSERT INTO viaje VALUES ('2019-01-06', '09:50', '40325696', '1402', '1406', 'TAXI C', 'en hora');
INSERT INTO viaje VALUES ('2020-04-06', '19:50', '40325696', '1402', '1406', 'TAXI C', 'en hora');
INSERT INTO viaje VALUES ('2021-05-26', '23:50', '40325696', '1402', '1406', 'TAXI C', 'en hora');
INSERT INTO viaje VALUES ('2020-06-06', '19:50', '40325696', '1402', '1406', 'TAXI C', 'demorado');
INSERT INTO viaje VALUES ('2019-01-06', '09:50', '40325696', '1402', '1403', 'TAXI C', 'en hora');
INSERT INTO viaje VALUES ('2019-01-07', '09:50', '40325696', '1402', '1403', 'TAXI A', 'en hora');
INSERT INTO viaje VALUES ('2019-11-08', '09:50', '40325696', '1402', '1403', 'TAXI B', 'en hora');
INSERT INTO viaje VALUES ('2019-05-09', '09:50', '40325696', '1402', '1403', 'TAXI C', 'en hora');
INSERT INTO viaje VALUES ('2019-03-10', '09:50', '40325696', '1402', '1403', 'TAXI D', 'en hora');

-- Listar razón social, dirección y teléfono de agencias que realizaron viajes desde la ciudad de ‘La Plata’ (ciudad origen) 
-- y que el cliente tenga apellido ‘Roma’. Ordenar por razón social y luego por teléfono.
-- usando inner join
SELECT a.razon_social, a.direccion, a.telef from agencia a 
INNER JOIN viaje v ON (a.razon_social=v.razon_social) 
INNER JOIN ciudad c ON (v.cpOrigen=c.codigoPostal) 
INNER JOIN cliente cli ON (v.DNI=cli.DNI)
WHERE c.nombreCiudad='La Plata' and cli.apellido='Roma'
ORDER BY a.razon_social, a.telef


-- Listar fecha, hora, datos personales del cliente, nombre ciudad origen y nombre destino de viajes realizados
-- en enero de 2019 donde la descripción del viaje contenga el String ‘demorado’.
SELECT v.fecha, v.hora, c.dni, c.nombre, c.apellido, ciu.nombreCiudad as ciudadOrigen, ciu2.nombreCiudad as ciudadDestino, v.descripcion FROM viaje v
INNER JOIN cliente c ON v.DNI=c.DNI
INNER JOIN ciudad ciu ON (v.cpOrigen=ciu.codigoPostal)
INNER JOIN ciudad ciu2 ON (v.cpDestino=ciu2.codigoPostal)
WHERE v.descripcion='demorado' and v.FECHA LIKE '2019-01-%';


-- Reportar información de agencias que realizaron viajes durante 2019 o que tengan dirección
-- de mail que termine con ‘@jmail.com’.
SELECT a.razon_social, a.direccion, a.telef, a.e_mail FROM agencia a
INNER JOIN viaje v ON (a.razon_social=v.razon_social)
WHERE v.FECHA LIKE '2019-%' OR a.e_mail LIKE '%@jmail.com';


-- Listar datos personales de clientes que solo viajaron con destino a la ciudad de ‘Coronel Brandsen’
SELECT c.dni, c.nombre, c.apellido FROM cliente c
INNER JOIN viaje v ON (c.DNI=v.DNI)
INNER JOIN ciudad ciu ON (v.cpDestino=ciu.codigoPostal)
WHERE ciu.nombreCiudad='Coronel Brandsen'
EXCEPT
(SELECT c.dni, c.nombre, c.apellido FROM cliente c
INNER JOIN viaje v ON (c.DNI=v.DNI)
INNER JOIN ciudad ciu ON (v.cpDestino=ciu.codigoPostal)
WHERE ciu.nombreCiudad!='Coronel Brandsen');


-- Informar cantidad de viajes de la agencia con razón social ‘TAXI Y’ realizados a ‘Villa Elisa’.
SELECT COUNT(v.FECHA) as cantViajes FROM viaje v
INNER JOIN ciudad c ON v.cpDestino=c.codigoPostal
WHERE v.razon_social='TAXI C' AND c.nombreCiudad='Villa Elisa';


-- Listar nombre, apellido, dirección y teléfono de clientes que viajaron con todas las agencias.
SELECT c.nombre, c.apellido, c.direccion, c.telefono FROM cliente c
WHERE NOT EXISTS
	(SELECT * FROM agencia a 
     WHERE NOT EXISTS(
     	SELECT * FROM viaje v
         WHERE a.razon_social=v.razon_social AND v.DNI=c.DNI
     )
);


-- Modificar el cliente con DNI: 38495444 actualizando el teléfono a: 221-4400897.
UPDATE cliente SET telefono='221-4400897' WHERE DNI=38495444;


-- Listar razon_social, dirección y teléfono de la/s agencias que tengan mayor cantidad de viajes realizados.
SELECT a.razon_social, a.direccion, a.telef
FROM agencia a INNER JOIN viaje v ON (a.razon_social = v.razon_social)
GROUP BY a.razon_social, a.direccion, a.telef
HAVING COUNT() >= ALL (SELECT COUNT() FROM viaje GROUP BY razon_social)


-- Reportar nombre, apellido, dirección y teléfono de clientes con al menos 10 viajes.
SELECT c.nombre, c.apellido, c.direccion, c.telefono FROM cliente c
INNER JOIN viaje v ON (c.DNI=v.DNI)
GROUP BY c.DNI, c.nombre, c.apellido, c.direccion, c.telefono
HAVING COUNT(v.FECHA) >= 10;

