/*
Ejercicio 3

Club=(codigoClub, nombre, anioFundacion, codigoCiudad(FK))
Ciudad=(codigoCiudad, nombre)
Estadio=(codigoEstadio, codigoClub(FK), nombre, direccion)
Jugador=(DNI, nombre, apellido, edad, codigoCiudad(FK))
ClubJugador(codigoClub, DNI, desde, hasta)

1. Reportar nombre y anioFundacion de aquellos clubes de la ciudad de La Plata que no
poseen estadio.
2. Listar nombre de los clubes que no hayan tenido ni tengan jugadores de la ciudad de
Berisso.
3. Mostrar DNI, nombre y apellido de aquellos jugadores que jugaron o juegan en el club
Gimnasia y Esgrima La PLata.
4. Mostrar DNI, nombre y apellido de aquellos jugadores que tengan más de 29 años y
hayan jugado o juegan en algún club de la ciudad de Córdoba.
5. Mostrar para cada club, nombre de club y la edad promedio de los jugadores que juegan
actualmente en cada uno.
6. Listar para cada jugador: nombre, apellido, edad y cantidad de clubes diferentes en los
que jugó. (incluido el actual)
7. Mostrar el nombre de los clubes que nunca hayan tenido jugadores de la ciudad de Mar
del Plata.
8. Reportar el nombre y apellido de aquellos jugadores que hayan jugado en todos los
clubes.
Página 2 de 10
9. Agregar con codigoClub 1234 el club “Estrella de Berisso” que se fundó en 1921 y que
pertenece a la ciudad de Berisso. Puede asumir que el codigoClub 1234 no existe en la
tabla Club.
*/

-- Reportar nombre y anioFundacion de aquellos clubes de la ciudad de La Plata que no poseen estadio
SELECT nombre, anioFundacion FROM Club c
INNER JOIN Ciudad ci ON c.codigoCiudad = ci.codigoCiudad
WHERE ci.nombre = 'La Plata' AND c.codigoClub NOT IN (SELECT codigoClub FROM Estadio);


-- Listar nombre de los clubes que no hayan tenido ni tengan jugadores de la ciudad de Berisso
SELECT nombre FROM Club c
WHERE c.codigoClub NOT IN (
    SELECT codigoClub FROM ClubJugador
    INNER JOIN Jugador j ON j.DNI = ClubJugador.DNI
    INNER JOIN Ciudad ci ON ci.codigoCiudad = j.codigoCiudad
    WHERE ci.nombre = 'Berisso'
);


-- Mostrar DNI, nombre y apellido de aquellos jugadores que jugaron o juegan en el club Gimnasia y Esgrima La PLata.
SELECT j.DNI, j.nombre, j.apellido FROM Jugador j
INNER JOIN ClubJugador cj ON j.DNI = cj.DNI
INNER JOIN Club c ON c.codigoClub = cj.codigoClub
WHERE c.nombre = 'Gimnasia y Esgrima La PLata';


-- Mostrar DNI, nombre y apellido de aquellos jugadores que tengan más de 29 años y hayan jugado o juegan en algún club de la ciudad de Córdoba.
SELECT j.DNI, j.nombre, j.apellido FROM Jugador j
INNER JOIN ClubJugador cj ON j.DNI = cj.DNI
INNER JOIN Club c ON c.codigoClub = cj.codigoClub
INNER JOIN Ciudad ci ON ci.codigoCiudad = c.codigoCiudad
WHERE j.edad > 29 AND ci.nombre = 'Córdoba';


-- Mostrar para cada club, nombre de club y la edad promedio de los jugadores que juegan actualmente en cada uno.
SELECT c.nombre, AVG(j.edad) FROM Club c
INNER JOIN ClubJugador cj ON c.codigoClub = cj.codigoClub
INNER JOIN Jugador j ON j.DNI = cj.DNI
WHERE cj.desde <= CURRENT_DATE AND cj.hasta >= CURRENT_DATE


-- Listar para cada jugador: nombre, apellido, edad y cantidad de clubes diferentes en los que jugó. (incluido el actual)
SELECT j.nombre, j.apellido, j.edad, COUNT(DISTINCT cj.codigoClub) FROM Jugador j
INNER JOIN ClubJugador cj ON j.DNI = cj.DNI
GROUP BY j.DNI, j.nombre, j.apellido, j.edad;


-- Mostrar el nombre de los clubes que nunca hayan tenido jugadores de la ciudad de Mar del Plata.
SELECT c.nombre FROM Club c
WHERE c.codigoClub NOT IN (
    SELECT codigoClub FROM ClubJugador
    INNER JOIN Jugador j ON j.DNI = ClubJugador.DNI
    INNER JOIN Ciudad ci ON ci.codigoCiudad = j.codigoCiudad
    WHERE ci.nombre = 'Mar del Plata'
);


-- Reportar el nombre y apellido de aquellos jugadores que hayan jugado en todos los clubes.
SELECT j.nombre, j.apellido FROM Jugador j
WHERE NOT EXISTS (
    SELECT * FROM Club c
    WHERE NOT EXISTS (
        SELECT * FROM ClubJugador cj
        WHERE cj.DNI = j.DNI AND cj.codigoClub = c.codigoClub
    )
);


-- Agregar con codigoClub 1234 el club “Estrella de Berisso” que se fundó en 1921 y que pertenece a la ciudad de Berisso. 
-- Puede asumir que el codigoClub 1234 no existe en la tabla Club.
INSERT INTO Club (codigoClub, nombre, anioFundacion, codigoCiudad) VALUES (1234, 'Estrella de Berisso', 1921, (SELECT codigoCiudad FROM Ciudad WHERE nombre = 'Berisso'));

