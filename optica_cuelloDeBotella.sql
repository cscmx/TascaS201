USE `optica_cuelloDeBotella`;



-- proveedor
INSERT INTO proveedor (nombre, direccion, telefono, fax, nif) VALUES
('Universium', 'Gran Via 345', '932456321', '932456322', 'B12345678'),
('Galaxy', 'Paseo Colón 25', '931231231', '931231232', 'B87654321');

-- marca
INSERT INTO marca (`nombre_marca`, proveedor_id_proveedor) VALUES
('Ray Ban', 1),
('Oakley', 1),
('Etnia', 2);

-- clientes
INSERT INTO cliente (nombre, direccion, telefono, email, `fecha_registro`, cliente_id_cliente) VALUES
('Pedro Guerrero', 'Plaza Prim 2', '612312312', 'pedro@gmail.com', '2025-06-10', NULL),
('Joana Monet', 'Gran Vía 400', '656756756', 'joana@gmail.com', '2025-07-15', 1);

-- empleados
INSERT INTO empleado (nombre) VALUES
('Marina López'),
('Óscar Rodríguez');

-- pedidos
INSERT INTO pedido (fecha, `precio_total`, cliente_id_cliente, empleado_id_empleado) VALUES
('2026-01-10', 157.40, 1, 1),
('2026-03-05', 99.85, 2, 2),
('2026-05-20', 487.90, 1, 1);

-- gafas
INSERT INTO gafas (`grad_derecho`, `grad_izquierdo`, `tipo_montura`, `color_vidrio`, precio, `color_montura`, marca_id_marca, pedido_id_pedido) VALUES
(4, 4, 'pasta', 'Transparente', 250.00, 'Carey', 2, 1),
(1, 1, 'metalica', 'Marrón', 90.00, 'Dorado', 3, 2),
(3, 3, 'pasta', 'Verde', 140.00, 'Negro', 2, 3),
(2, 2, 'flotante', 'Transparente', 300.00, 'Plata', 1, 3),
(1, 1, 'metalica', 'Verde', 80.00, 'Plateado', 2, NULL); -- en stock

SELECT * FROM gafas;