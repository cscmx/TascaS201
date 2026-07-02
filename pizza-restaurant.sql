USE `pizza-restaurant`;

INSERT INTO RESTAURANT (`address-restaurant`,`zip-code`,city,province) VALUES
('Plaza España 40', 08014, 'Barcelona', 'Cataluña');
SELECT * FROM RESTAURANT;

SELECT * FROM CLIENTS;
SELECT * FROM CLIENTORDER;
INSERT INTO CLIENTORDER (date, `order-type`,`total-price`, RESTAURANT_idRESTAURANT, CLIENTS_idCLIENTS) VALUES
('2026-06-28', 0, 85, 1, 1),
('2026-05-18', 0, 115, 1, 2),
('2026-04-08', 1, 25, 1, 3),
('2026-03-02', 0, 35, 1, 4);

SELECT * FROM POSITION; 

INSERT INTO POSITION (`position-name`) VALUES
('chef');

UPDATE POSITION 
SET `position-name` = 'delivery person'
WHERE idposition = 2;

SELECT * FROM WORKER; 

INSERT INTO WORKER (name,lastname,NIF,`phone-number`, RESTAURANT_idRESTAURANT, POSITION_idposition) VALUES
('Jose','Pla', '232323232S',977878787, 1, 2),
('Josefina','Glz','121212121M',987654321, 1, 1),
('Karina','Juarez','454545454T', 921232323, 1, 1);

SELECT * FROM `CATEGORY-PIZZA`;
INSERT INTO `CATEGORY-PIZZA` (`name-category`) VALUES
('pizza arugula'),
('pizza napoli'),
('pizza diabla'),
('pizza peperoncino');

INSERT INTO `CATEGORY-PIZZA` (`name-category`) VALUES
('pizza veggie');

SELECT * FROM PRODUCTS;

INSERT INTO PRODUCTS (name,description,image,price) VALUES
('water', 'water', 'water.jpg', 2),
('beer', 'beer drink', 'sparkling.jpg', 3),
('coke', 'coke drink', 'sparkling.jpg', 2),
('aquarius', 'sport drink', 'water.jpg', 2),
('pizza mediterranean', 'pizza with vegetables ', 'water.jpg', 15);

select * from pizza;

INSERT INTO PIZZA (PRODUCTS_idPRODUCTS, `CATEGORY-PIZZA_idCATEGORY-PIZZA`) VALUES
(5, 5);

SELECT * FROM CANTIDADPRODUCTOS;
INSERT INTO CANTIDADPRODUCTOS (CLIENTORDER_idCLIENTORDER, PRODUCTS_idPRODUCTS,CANTIDAD) VALUES
(1, 5, 5),
(1, 3, 5),
(2, 5, 10),
(3, 3, 5),
(4, 5, 2),
(4, 4, 2);

SELECT * FROM CANTIDADPRODUCTOS;

INSERT INTO drinks (PRODUCTS_idPRODUCTS) VALUES
(1),
(2), 
(3), 
(4); 

INSERT INTO PRODUCTS (name, description, image, price) VALUES
('classic burger', 'beef burger with cheese', 'burger.jpg', 15);

SELECT * FROM PRODUCTS;

SHOW TABLES;
DROP TABLE IF EXISTS HAMBURGERS;
DROP TABLE IF EXISTS DRINKS;

SELECT * FROM PRODUCTS;

ALTER TABLE PRODUCTS AUTO_INCREMENT = 1;

ALTER TABLE PRODUCTS 
ADD productType ENUM ('pizza', 'burger','drink') NOT NULL DEFAULT 'drink';

INSERT INTO PRODUCTS (name, description, image, price, productType) VALUES
('water', 'water', 'water.jpg', 2, 'drink'),
('beer', 'beer drink', 'sparkling.jpg', 3, 'drink'),
('coke', 'coke drink', 'sparkling.jpg', 2, 'drink'),
('aquarius', 'sport drink', 'water.jpg', 2, 'drink'),
('pizza veggie', 'pizza with vegetables', 'pizza.jpg', 15, 'pizza'),
('burger', 'burger with cheese', 'cheeseburger.jpg', 12, 'burger');

SELECT * FROM PRODUCTS;

SELECT * FROM CANTIDADPRODUCTOS;

ALTER TABLE WORKER
ADD ROL ENUM ('chef','delivery person');

SELECT * FROM WORKER;
ALTER TABLE WORKER DROP COLUMN POSITION_idposition;

UPDATE WORKER
SET ROL = 'chef'
WHERE idWORKER = 3;

ALTER TABLE WORKER
MODIFY COLUMN ROL ENUM ('chef','delivery person') NOT NULL DEFAULT 'chef';

SELECT * FROM WORKER;

SELECT * FROM CLIENTORDER;

ALTER TABLE CLIENTORDER
ADD WORKER_idWORKER int NULL,
ADD CONSTRAINT fk_CLIENTORDER_WORKER1
FOREIGN KEY (WORKER_idWORKER) REFERENCES WORKER (idWORKER);

ALTER TABLE CLIENTORDER
ADD deliveryTime datetime NULL;

UPDATE CLIENTORDER
SET WORKER_idWORKER = 1, deliveryTime = '2026-06-28 14:15:00'
WHERE idCLIENTORDER = 1;

UPDATE CLIENTORDER
SET WORKER_idWORKER = 1, deliveryTime = '2026-05-18 18:01:00'
WHERE idCLIENTORDER = 2;


UPDATE CLIENTORDER
SET WORKER_idWORKER = 1, deliveryTime = '2026-03-02 21:08:00'
WHERE idCLIENTORDER = 4;

SELECT * FROM CANTIDADPRODUCTOS;

SELECT * FROM CLIENTORDER;
-- **********Enunciado 1 : Llista quants productes de tipus “Begudes” s'han venut en una determinada localitat.
SELECT COUNT(co.idCLIENTORDER), cl.city
FROM PRODUCTS pr
JOIN CANTIDADPRODUCTOS cn ON cn.PRODUCTS_idPRODUCTS = pr.idPRODUCTS
JOIN CLIENTORDER co ON co.idCLIENTORDER = cn.CLIENTORDER_idCLIENTORDER
JOIN CLIENTS cl ON cl.idCLIENTS = co.CLIENTS_idCLIENTS
WHERE pr.productType = 'drink'
GROUP BY cl.city;


-- ************Enunciado 2 : Llista quantes comandes ha efectuat un determinat empleat/da.
SELECT COUNT(co.idCLIENTORDER) AS all_orders, w.name, w.rol
FROM CLIENTORDER co
JOIN WORKER w ON w.idWORKER = co.WORKER_idWORKER
WHERE co.WORKER_idWORKER = 1;