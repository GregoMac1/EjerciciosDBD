/*
Ejercicio 2

Cliente(idCliente, nombre, apellido, DNI, telefono, direccion)
Factura (nroTicket, total, fecha, hora, idCliente (fk))
Detalle(nroTicket, idProducto, cantidad, preciounitario)
Producto(idProducto, descripcion, precio, nombreP, stock)

1. Listar datos personales de clientes cuyo apellido comience con el string ‘Pe’. Ordenar por
DNI
2. Listar nombre, apellido, DNI, teléfono y dirección de clientes que realizaron compras
solamente durante 2017.
Página 1 de 10
3. Listar nombre, descripción, precio y stock de productos vendidos al cliente con
DNI:45789456, pero que no fueron vendidos a clientes de apellido ‘Garcia’.
4. Listar nombre, descripción, precio y stock de productos no vendidos a clientes que
tengan teléfono con característica: 221 (La característica está al comienzo del teléfono).
Ordenar por nombre.
5. Listar para cada producto: nombre, descripción, precio y cuantas veces fué vendido.
Tenga en cuenta que puede no haberse vendido nunca el producto.
6. Listar nombre, apellido, DNI, teléfono y dirección de clientes que compraron los
productos con nombre ‘prod1’ y ‘prod2’ pero nunca compraron el producto con nombre
‘prod3’.
7. Listar nroTicket, total, fecha, hora y DNI del cliente, de aquellas facturas donde se haya
comprado el producto ‘prod38’ o la factura tenga fecha de 2019.
8. Agregar un cliente con los siguientes datos: nombre:’Jorge Luis’, apellido:’Castor’,
DNI:40578999, teléfono:221-4400789, dirección:’11 entre 500 y 501 nro:2587’ y el id de
cliente: 500002. Se supone que el idCliente 500002 no existe.
9. Listar nroTicket, total, fecha, hora para las facturas del cliente ´Jorge Pérez´ donde no
haya comprado el producto ´Z´.
10. Listar DNI, apellido y nombre de clientes donde el monto total comprado, teniendo en
cuenta todas sus facturas, supere $10.000.000.

*/


-- Listar datos personales de clientes cuyo apellido comience con el string ‘Pe’. Ordenar por DNI
SELECT * FROM Cliente WHERE apellido LIKE 'Pe%' ORDER BY DNI;


-- Listar nombre, apellido, DNI, teléfono y dirección de clientes que realizaron compras solamente durante 2017.
SELECT * FROM Cliente WHERE EXISTS 
(SELECT * FROM Factura WHERE idCliente = Cliente.idCliente AND fecha LIKE '2017%');


-- Listar nombre, descripción, precio y stock de productos vendidos al cliente con DNI:45789456,
-- pero que no fueron vendidos a clientes de apellido ‘Garcia’
SELECT p.nombreP, p.descripcion, p.precio, p.stock FROM Producto p 
INNER JOIN Cliente c ON c.idCliente = p.idCliente
INNER JOIN Factura f ON f.idCliente = c.idCliente
WHERE c.DNI = 45789456
EXCEPT
(SELECT p.nombreP, p.descripcion, p.precio, p.stock FROM Producto p
INNER JOIN Cliente c ON c.idCliente = p.idCliente
INNER JOIN Factura f ON f.idCliente = c.idCliente
WHERE c.apellido = 'Garcia');


-- Listar nombre, descripción, precio y stock de productos no vendidos a clientes que
-- tengan teléfono con característica: 221 (La característica está al comienzo del teléfono). Ordenar por nombre
SELECT p.nombreP, p.descripcion, p.precio, p.stock FROM Producto p
INNER JOIN Cliente c ON c.idCliente = p.idCliente
WHERE c.telefono LIKE '221%' AND NOT IN 
(SELECT * FROM Producto p INNER JOIN Factura f ON f.idProducto = p.idProducto);


-- Listar para cada producto: nombre, descripción, precio y cuantas veces fué vendido. 
-- Tenga en cuenta que puede no haberse vendido nunca el producto.
SELECT p.nombreP, p.descripcion, p.precio, SUM(d.cantidad) FROM Producto p
LEFT JOIN Factura f ON f.idProducto = p.idProducto
LEFT JOIN Detalle d ON d.nroTicket = f.nroTicket
GROUP BY p.nombreP, p.descripcion, p.precio;



-- Listar nombre, apellido, DNI, teléfono y dirección de clientes que compraron los
-- productos con nombre ‘prod1’ y ‘prod2’ pero nunca compraron el producto con nombre ‘prod3’.
SELECT * FROM Cliente c WHERE EXISTS
(SELECT * FROM Factura f INNER JOIN Detalle d ON d.nroTicket = f.nroTicket
INNER JOIN Producto p ON p.idProducto = d.idProducto
WHERE f.idCliente = c.idCliente AND (p.nombreP = 'prod1' OR p.nombreP = 'prod2')
AND NOT EXISTS (SELECT * FROM Factura f INNER JOIN Detalle d ON d.nroTicket = f.nroTicket
INNER JOIN Producto p ON p.idProducto = d.idProducto
WHERE f.idCliente = c.idCliente AND p.nombreP = 'prod3'));


-- Listar nroTicket, total, fecha, hora y DNI del cliente, de aquellas facturas donde se haya
-- comprado el producto ‘prod38’ o la factura tenga fecha de 2019
SELECT f.nroTicket, f.total, f.fecha, f.hora, c.DNI FROM Factura f
INNER JOIN Cliente c ON c.idCliente = f.idCliente
INNER JOIN Detalle d ON d.nroTicket = f.nroTicket
WHERE d.nombreP = 'prod38' OR f.fecha LIKE '2019%';


-- Agregar un cliente con los siguientes datos: nombre:’Jorge Luis’, apellido:’Castor’,
-- DNI:40578999, teléfono:221-4400789, dirección:’11 entre 500 y 501 nro:2587’ y el id de
-- cliente: 500002. Se supone que el idCliente 500002 no existe.
INSERT INTO Cliente (idCliente, nombre, apellido, DNI, telefono, direccion) 
VALUES (500002, 'Jorge Luis', 'Castor', 40578999, '221-4400789', '11 entre 500 y 501 nro:2587');


-- Listar nroTicket, total, fecha, hora para las facturas del cliente ´Jorge Pérez´ donde no
-- haya comprado el producto ´Z´.
SELECT f.nroTicket, f.total, f.fecha, f.hora FROM Factura f
INNER JOIN Cliente c ON c.idCliente = f.idCliente
INNER JOIN Detalle d ON d.nroTicket = f.nroTicket
WHERE c.nombre = 'Jorge Pérez' 
EXCEPT
(SELECT f.nroTicket, f.total, f.fecha, f.hora FROM Factura f
INNER JOIN Cliente c ON c.idCliente = f.idCliente
INNER JOIN Detalle d ON d.nroTicket = f.nroTickets
WHERE c.nombre = 'Jorge Pérez' AND d.nombreP = 'Z');


-- Listar DNI, apellido y nombre de clientes donde el monto total comprado, teniendo en
-- cuenta todas sus facturas, supere $10.000.000
SELECT c.dni, c.apellido, c.nombre FROM Cliente c
INNER JOIN Factura c on c.idCliente=f.idCliente
GROUP BY c.dni, c.apellido, c.nombre
HAVING SUM(f.total) > 10000000;






