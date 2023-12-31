CREATE DATABASE MUEBLETEC
GO
USE MUEBLETEC
GO
CREATE TABLE CLIENTES (
	CLAVECLI INT IDENTITY (1000,1) NOT NULL,
	NOMBRECLI NVARCHAR(50) NOT NULL,
	DIRECCION NVARCHAR(70) NOT NULL,
	TELEFONO CHAR(10) NOT NULL,
	SALDOPENDIENTE MONEY NOT NULL,
	MONTOMAXCREDITO MONEY NOT NULL
)
GO
CREATE TABLE ARTICULOS(
	CLAVEART INT IDENTITY(100,1) NOT NULL,
	DESCRIPCION NVARCHAR(30) NOT NULL,
	PRECIO MONEY NOT NULL,
	EXSITENCIA INT NOT NULL
)
GO
CREATE TABLE VENTAS(
	CLAVEVENTA INT IDENTITY(10,1) NOT NULL,
	IMPORTE MONEY NOT NULL,
	CLAVECLI INT NOT NULL,
	TIPOVENTA NVARCHAR(10) NOT NULL,
	FECHA DATETIME NOT NULL
)
GO
CREATE TABLE DETALLEVENTA(
	CLAVEART INT NOT NULL,
	CLAVEVENTA INT NOT NULL,
	CANTIDAD INT NOT NULL,
	IMPORTE MONEY NOT NULL
)
GO --PRIMARY KEYS
	ALTER TABLE CLIENTES ADD CONSTRAINT PK_CLIENTES PRIMARY KEY (CLAVECLI)
	ALTER TABLE ARTICULOS ADD CONSTRAINT PK_ARTICULOS PRIMARY KEY (CLAVEART)
	ALTER TABLE VENTAS ADD CONSTRAINT PK_VENTAS PRIMARY KEY (CLAVEVENTA)
	ALTER TABLE DETALLEVENTA ADD CONSTRAINT PK_DETALLE PRIMARY KEY(CLAVEART, CLAVEVENTA)
GO --FOREIGN KEYS
	ALTER TABLE VENTAS ADD CONSTRAINT FK_VENTAS_ARTICULOS FOREIGN KEY (CLAVECLI) REFERENCES CLIENTES (CLAVECLI)
	ALTER TABLE DETALLEVENTA ADD CONSTRAINT FK_DETALLE_ARTICULOS FOREIGN KEY (CLAVEART) REFERENCES ARTICULOS (CLAVEART)
	ALTER TABLE DETALLEVENTA ADD CONSTRAINT FK_DETALLE_VENTAS FOREIGN KEY (CLAVEVENTA) REFERENCES VENTAS (CLAVEVENTA)
GO
-->DATOS
INSERT INTO ARTICULOS VALUES ('MESA', 450, 6), ('COLCHON', 3000, 5), ('SILLON', 6000, 3)
INSERT INTO CLIENTES VALUES ('RYAN FELIX', 'VILLA BONITA', '6672241995', 0, 10400), ('AMERICA FLORES', 'LAZARO CARDENAS', '6677874227', 0, 10600)
INSERT INTO VENTAS VALUES (900, 1000, 'CONTADO', '10/02/2023'),(3000, 1001, 'CONTADO', '10/02/2023') -->ASIGNA CLIENTES
INSERT INTO DETALLEVENTA VALUES(100,10,1,900), (101, 11, 1, 3000)
GO
--> RECONTRUCCION 
-->1. CREAR SUCURSALES Y AGREGAR 
CREATE TABLE SUCURSALES (
	SUCID INT NOT NULL,
	NOMBRE NVARCHAR(30) NOT NULL,
	DOMICILIO NVARCHAR (50) NOT NULL,
	TELEFONO CHAR (10) NOT  NULL
)
GO
ALTER TABLE SUCURSALES ADD CONSTRAINT PK_SUCURSAL PRIMARY KEY (SUCID)
GO
INSERT INTO SUCURSALES VALUES (100, 'MUEBLETEC CARRASCO', 'ANTONIO CARRASCO, CULIACAN', '6677125767')
GO
-->2. QUITAR LLAVES FORANEAS
ALTER TABLE DETALLEVENTA DROP CONSTRAINT FK_DETALLE_VENTAS

-->3. QUITAR PK EN ORDERS
ALTER TABLE VENTAS DROP CONSTRAINT PK_VENTAS

-->4. QUITAR IDENTITY EN ORDERS
CREATE TABLE VENTA(
	SUCID INT NULL,
	CLAVEVENTA INT NOT NULL,
	IMPORTE MONEY NOT NULL,
	CLAVECLI INT NOT NULL,
	TIPOVENTA NVARCHAR(10) NOT NULL,
	FECHA DATETIME NOT NULL
) --NUEVA TABLA 
INSERT INTO VENTA(CLAVEVENTA, IMPORTE, CLAVECLI, TIPOVENTA, FECHA) SELECT CLAVEVENTA, IMPORTE, CLAVECLI, TIPOVENTA, FECHA FROM VENTAS --> COPIA DE TABLA CON SUCID NULL
DROP TABLE VENTAS -->ELIMINAMOS TABLA ANTERIOR

-->5. AGERGAR ORDER.SUCID Y 6. ACTUALIZAR ORDERS CON LA CLAVE SUCID DEL PUNTO 1 
UPDATE VENTA SET SUCID = 100

-->7. QUE NO PERMITA NULOS ORDERS.SUCID 
ALTER TABLE VENTA ALTER COLUMN SUCID INT NOT NULL

-->8. CREAR PK EN ORDERS Y  9. FK EN ORDERS-SUCURSALES.
ALTER TABLE VENTA ADD CONSTRAINT FK_CLAVESUC FOREIGN KEY (SUCID) REFERENCES SUCURSALES (SUCID)--FK SUCURSAL
ALTER TABLE VENTA ADD CONSTRAINT FK_CLAVECLI FOREIGN KEY (CLAVECLI) REFERENCES CLIENTES (CLAVECLI)--FK CLIENTE
ALTER TABLE VENTA ADD CONSTRAINT PK_VENTA PRIMARY KEY (CLAVEVENTA, SUCID)--PK VENTA

-->10. QUITAR PK EN ORDER DETAILS
ALTER TABLE DETALLEVENTA DROP CONSTRAINT PK_DETALLE

-->11. AGREGAR ORDERDEATILS.SUCID
CREATE TABLE DETAILVENTA(
	SUCID INT NULL,
	CLAVEVENTA INT NOT NULL,
	CLAVEART INT NOT NULL,
	CANTIDAD INT NOT NULL,
	IMPORTE MONEY NOT NULL
)
--COPIAR ELEMENTOS A LA NUEVA TABLA 
INSERT INTO DETAILVENTA(CLAVEVENTA, CLAVEART, CANTIDAD, IMPORTE) SELECT CLAVEVENTA, CLAVEART, CANTIDAD, IMPORTE FROM DETALLEVENTA --> COPIA DE TABLA CON SUCID NULL
DROP TABLE DETALLEVENTA

-->12. ACTUALIZAR ORDERDETAILS.SUCID CON EL PUNTO 1
UPDATE DETAILVENTA SET SUCID = 100

-->13. QUE NO PERMITA NULOS
ALTER TABLE DETAILVENTA ALTER COLUMN SUCID INT NOT NULL

-->14. CREAR PK Y 15. CREAR FK EN ORDERDETAILS Y ORDERS 
ALTER TABLE DETAILVENTA ADD CONSTRAINT FK_VENTA FOREIGN KEY (CLAVEVENTA,SUCID) REFERENCES VENTA(CLAVEVENTA,SUCID)
ALTER TABLE DETAILVENTA ADD CONSTRAINT FK_ARTICULOS FOREIGN KEY (CLAVEART) REFERENCES ARTICULOS (CLAVEART)
ALTER TABLE DETAILVENTA ADD CONSTRAINT PK_DETAILVENTA PRIMARY KEY (CLAVEVENTA, SUCID, CLAVEART)

-->INSERCIONES DE PRUEBA
INSERT INTO ARTICULOS VALUES ('SILLON', 1790, 3), ('ROPERO', 7000, 3)
INSERT INTO CLIENTES VALUES ('DANIEL CASTRO', 'ADOLFO LOPES MATEOS', '6672241995', 0, 20000), ('JESUS GASTELUM', 'VILLA DEL REAL', '6677874227', 0, 45666)

INSERT INTO VENTA VALUES (100, 350, 1790, 1002,'CONTADO', '10/02/2023') -->INSERCION CON PRUEBA DE QUE IDENTITY SE QUIT�
INSERT INTO DETAILVENTA VALUES(100, 350, 101, 1, 1790)-->INSERCION CON PRUEBA DE DETALLE