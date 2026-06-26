RENAME TABLE mydb.PROVEEDOR TO optica_cuelloDeBotella.PROVEEDOR;
RENAME TABLE mydb.MARCA TO optica_cuelloDeBotella.MARCA;

CREATE SCHEMA IF NOT EXISTS `optica_cuelloDeBotella`;
RENAME TABLE mydb.CLIENTES TO optica_cuelloDeBotella.CLIENTES;
RENAME TABLE mydb.PEDIDO TO optica_cuelloDeBotella.PEDIDO;
RENAME TABLE mydb.EMPLEADO TO optica_cuelloDeBotella.EMPLEADO;
RENAME TABLE mydb.GAFAS TO optica_cuelloDeBotella.GAFAS;

DROP SCHEMA mydb;

use optica_cuelloDeBotella;
-- proveedor
INSERT INTO PROVEEDOR (nombre, direccion, telefono, fax, NIF) VALUES
('Universium', 'Gran Via 345', '932456321', '932456322', 'B12345678'),
('Galaxy', 'Paseo Colón 25', '931231231', '931231232', 'B87654321');

-- marca
INSERT INTO MARCA (`nombre marca`, PROVEEDOR_idPROVEEDOR) VALUES
('Ray Ban', 1),
('Oakley', 1),
('Etnia', 2);

-- clientes
INSERT INTO CLIENTES (nombre, direccion, telefono, email, `fecha registro`, idCliente_Referral) VALUES
('Pedro Guerrero', 'Plaza Prim 2', '612312312', 'pedro@gmail.com', '2025-06-10', NULL),
('Joana Monet', 'Gran Vía 400', '656756756', 'joana@gmail.com', '2025-07-15', 1);

-- empleados
INSERT INTO EMPLEADO (nombre) VALUES
('Marina López'),
('Óscar Rodríguez');

-- pedidos
INSERT INTO PEDIDO (fecha, `Precio Total`, CLIENTES_idCLIENTES, EMPLEADO_idEMPLEADO) VALUES
('2026-01-10', 157.40, 1, 1),
('2026-03-05', 99.85, 2, 2),
('2026-05-20', 487.90, 1, 1);

-- gafas
INSERT INTO GAFAS (`grad derecho`, `grad izquierdo`, `tipo montura`, `color vidrio`, precio, `color de montura`, MARCA_idMARCA, PEDIDO_idPEDIDO) VALUES
(4, 4, 'Pasta', 'Transparente', 250.00, 'Carey', 2, 1),
(1, 1, 'Metálica', 'Marrón', 90.00, 'Dorado', 3, 2),
(3, 3, 'Pasta', 'Verde', 140.00, 'Negro', 2, 3),
(2, 2, 'Flotante', 'Transparente', 300.00, 'Plata', 1, 3),
(1, 1, 'Metálica', 'Verde', 80.00, 'Plateado', 2, NULL); -- en stock

SELECT * FROM GAFAS;
SELECT * FROM PROVEEDOR;
SELECT * FROM MARCA;
SELECT * FROM CLIENTES;
SELECT * FROM EMPLEADO;
SELECT * FROM PEDIDO;
SELECT * FROM GAFAS;


SELECT nombre, email FROM CLIENTES;
SELECT `nombre marca` FROM MARCA;

SELECT nombre, direccion FROM CLIENTES WHERE idCLIENTES = 1;

SELECT nombre, email FROM CLIENTES WHERE nombre = 'Joana Monet';
SELECT telefono, NIF FROM PROVEEDOR WHERE idPROVEEDOR = 1;
SELECT nombre,telefono, NIF FROM PROVEEDOR WHERE idPROVEEDOR = 1;

SELECT COUNT(*) FROM PEDIDO;
SELECT SUM(`Precio Total`) FROM PEDIDO;

SELECT SUM(`Precio Total`) 
FROM PEDIDO 
WHERE CLIENTES_idCLIENTES = 1;

SELECT SUM(`Precio Total`) FROM PEDIDO WHERE CLIENTES_idCLIENTES = 2;

SELECT MIN(`Precio Total`) FROM PEDIDO WHERE EMPLEADO_idEMPLEADO = 1;
SELECT MIN(`Precio Total`) FROM PEDIDO WHERE EMPLEADO_idEMPLEADO = 2;
SELECT MAX(`Precio Total`) FROM PEDIDO WHERE EMPLEADO_idEMPLEADO = 1;

SELECT c.nombre, p.fecha, p.`Precio Total` 
FROM CLIENTES c
JOIN PEDIDO p ON c.idCLIENTES = p.CLIENTES_idCLIENTES;

SELECT c.nombre, SUM(p.`Precio Total`) AS total_compras
FROM CLIENTES c
JOIN PEDIDO p ON c.idCLIENTES = p.CLIENTES_idCLIENTES
GROUP BY c.nombre;

SELECT c.nombre, SUM(p.`Precio Total`)
FROM CLIENTES c
JOIN PEDIDO p ON c.idCLIENTES = p.CLIENTES_idCLIENTES
GROUP BY c.nombre;

SELECT c.nombre, m.`nombre marca`, p.fecha
FROM CLIENTES c
JOIN PEDIDO p ON c.idCLIENTES = p.CLIENTES_idCLIENTES
JOIN GAFAS g ON p.idPEDIDO = g.PEDIDO_idPEDIDO
JOIN MARCA m ON g.MARCA_idMARCA = m.idMARCA;

SELECT c.nombre, m.`nombre marca`, p.fecha, pr.telefono
FROM CLIENTES c
JOIN PEDIDO p ON c.idCLIENTES = p.CLIENTES_idCLIENTES
JOIN GAFAS g ON p.idPEDIDO = g.PEDIDO_idPEDIDO
JOIN MARCA m ON g.MARCA_idMARCA = m.idMARCA
JOIN PROVEEDOR pr ON pr.idPROVEEDOR = m.PROVEEDOR_idPROVEEDOR;

SELECT c.nombre, c.telefono AS telefono_cliente, m.`nombre marca`, p.fecha, pr.telefono AS telefono_proveedor
FROM CLIENTES c
JOIN PEDIDO p ON c.idCLIENTES = p.CLIENTES_idCLIENTES
JOIN GAFAS g ON p.idPEDIDO = g.PEDIDO_idPEDIDO
JOIN MARCA m ON g.MARCA_idMARCA = m.idMARCA
JOIN PROVEEDOR pr ON pr.idPROVEEDOR = m.PROVEEDOR_idPROVEEDOR;


INSERT INTO PROVEEDOR (nombre, direccion, telefono, fax, NIF) VALUES
('Opticalia', 'Carrer Verdún 14', '930001001', '930001002', 'B10010010');

SELECT * FROM PROVEEDOR;
INSERT INTO MARCA (`nombre marca`, PROVEEDOR_idPROVEEDOR) VALUES
('Lafont', 3),
('Anne et Valentin', 3);

INSERT INTO CLIENTES (nombre, direccion, telefono, email, `fecha registro`, idCliente_Referral) VALUES
('Matias Alexander', 'rue perignon 3', '+34 667667667', 'matias@gmail.com', '2026-02-24', NULL);

SELECT * FROM CLIENTES;

SELECT * FROM PROVEEDOR;

SELECT c.nombre, c.email, c.telefono, p.fecha
FROM CLIENTES c
JOIN PEDIDO p ON c.idCLIENTES = p.CLIENTES_idCLIENTES
WHERE idCLIENTES = 3;

SELECT COUNT(*) FROM PEDIDO; 

SELECT SUM(`Precio Total`)
FROM PEDIDO
WHERE CLIENTES_idCLIENTES = 1;

INSERT INTO PEDIDO (fecha, `Precio Total`, CLIENTES_idCLIENTES, EMPLEADO_idEMPLEADO) VALUES
('2026-05-23', 267, 3,2),
('2026-06-10', 456.34, 2, 2),
('2026-04-15', 199, 3, 1);

-- LISTA TOTAL DE COMPRAS DE UN CLIENTE
SELECT c.nombre, c.direccion, c.telefono, SUM(p.`Precio Total`)
FROM CLIENTES c
JOIN PEDIDO p ON c.idCLIENTES = p.CLIENTES_idCLIENTES
WHERE CLIENTES_idCLIENTES = 3;

-- GAFAS VENDIDAS POR EMPLEADO
SELECT p.`Precio Total`, g.precio AS precio_gafa, g.`tipo montura`, e.nombre AS nombre_empleado, p.idPEDIDO
FROM PEDIDO p
JOIN GAFAS g ON p.idPEDIDO = g.PEDIDO_idPEDIDO
JOIN EMPLEADO e ON e.idEMPLEADO = p.EMPLEADO_idEMPLEADO
WHERE p.fecha
BETWEEN '2026-01-10' AND '2026-06-30';

-- pedidos por empleado
SELECT e.nombre, p.fecha AS fecha_pedido, p.`Precio Total`, p.idPEDIDO
FROM EMPLEADO e
JOIN PEDIDO p ON e.idEMPLEADO = p.EMPLEADO_idEMPLEADO
WHERE p.fecha 
BETWEEN '2026-01-10' AND '2026-06-30';

SELECT * FROM PEDIDO;
SELECT * FROM GAFAS;

SELECT PEDIDO_idPEDIDO, COUNT(*) AS cuantas_gafas
FROM GAFAS
GROUP BY PEDIDO_idPEDIDO;

SELECT * FROM PEDIDO WHERE idPEDIDO = 3;
SELECT * FROM GAFAS WHERE PEDIDO_idPEDIDO = 3;

SELECT pr.nombre, m.`nombre marca`
FROM PROVEEDOR pr
JOIN MARCA m
WHERE m.`nombre marca` = 'Anne et Valentin'  AND pr.idPROVEEDOR = m.PROVEEDOR_idPROVEEDOR;

-- PROVEEDORES QUE HAN SUMINISTRADO GAFAS VENDIDAS CON EXITO 
SELECT DISTINCT pr.nombre AS nombre_proveedor
FROM PROVEEDOR pr
JOIN MARCA m ON pr.idPROVEEDOR = m.PROVEEDOR_idPROVEEDOR
JOIN GAFAS g ON m.idMARCA = g.MARCA_idMARCA
WHERE g.PEDIDO_idPEDIDO IS NOT NULL;



SELECT pr.nombre AS nombre_proveedor, m.`nombre marca`, g.idGAFAS
FROM PROVEEDOR pr
JOIN MARCA m ON pr.idPROVEEDOR = m.PROVEEDOR_idPROVEEDOR
JOIN GAFAS g ON m.idMARCA = g.MARCA_idMARCA
WHERE g.PEDIDO_idPEDIDO IS NOT NULL;