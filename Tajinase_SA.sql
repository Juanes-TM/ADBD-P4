-- Script para la base de datos de Viveros Tajinaste S.A.

-- Creación de la base de datos
CREATE DATABASE Tajinase_SA;

-- Creación de la tablas

-- Tabla Vivero
CREATE TABLE Vivero (
    ID_Vivero SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Latitud DECIMAL(10, 8) NOT NULL,
    Longitud DECIMAL(11, 8) NOT NULL
);

-- Tabla Zona
CREATE TABLE Zona (
    ID_Zona SERIAL,
    ID_Vivero INTEGER NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    PRIMARY KEY (ID_Zona, ID_Vivero),
    FOREIGN KEY (ID_Vivero) REFERENCES Vivero(ID_Vivero) ON DELETE CASCADE
);

-- Tabla Producto
CREATE TABLE Producto (
    ID_Producto SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Tipo VARCHAR(50) NOT NULL,
    Precio_Actual DECIMAL(10,2) NOT NULL CHECK (Precio_Actual > 0)
);

-- Tabla Puesto
CREATE TABLE Puesto (
    ID_Puesto SERIAL PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL UNIQUE
);

-- Tabla Empleado
CREATE TABLE Empleado (
    DNI_Empleado VARCHAR(10) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Fecha_Ingreso DATE NOT NULL,
    ID_Zona INTEGER NOT NULL,
    ID_Vivero INTEGER NOT NULL,
    FOREIGN KEY (ID_Zona, ID_Vivero) REFERENCES Zona(ID_Zona, ID_Vivero) ON DELETE RESTRICT
);

-- Tabla Historial_Puestos
CREATE TABLE Historial_Puestos (
    DNI_Empleado VARCHAR(10) NOT NULL,
    ID_Puesto INTEGER NOT NULL,
    Fecha_Inicio DATE NOT NULL,
    Fecha_Fin DATE NULL,
    PRIMARY KEY (DNI_Empleado, ID_Puesto, Fecha_Inicio),
    FOREIGN KEY (DNI_Empleado) REFERENCES Empleado(DNI_Empleado) ON DELETE CASCADE,
    FOREIGN KEY (ID_Puesto) REFERENCES Puesto(ID_Puesto) ON DELETE RESTRICT,
    CHECK (Fecha_Inicio <= Fecha_Fin OR Fecha_Fin IS NULL)
);

-- Tabla Cliente_Plus
CREATE TABLE Cliente_Plus (
    DNI_Cliente VARCHAR(10) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Telefono VARCHAR(15),
    Fecha_Ingreso_Plus DATE NOT NULL,
    Bonificador DECIMAL(3,1) DEFAULT 0 CHECK (Bonificador >= 0)
);

-- Tabla Pedido
CREATE TABLE Pedido (
    ID_Pedido SERIAL PRIMARY KEY,
    Importe DECIMAL(10,2) NOT NULL CHECK (Importe >= 0),
    Fecha DATE NOT NULL,
    Metodo_Pago VARCHAR(20) NOT NULL CHECK (Metodo_Pago IN ('tarjeta','efectivo','transferencia')),
    DNI_Cliente VARCHAR(10) NULL,
    DNI_Empleado VARCHAR(10) NOT NULL,
    FOREIGN KEY (DNI_Cliente) REFERENCES Cliente_Plus(DNI_Cliente) ON DELETE SET NULL,
    FOREIGN KEY (DNI_Empleado) REFERENCES Empleado(DNI_Empleado) ON DELETE RESTRICT
);

-- Tabla Stock
CREATE TABLE Stock (
    ID_Producto INTEGER NOT NULL,
    ID_Zona INTEGER NOT NULL,
    ID_Vivero INTEGER NOT NULL,
    Stock INTEGER NOT NULL CHECK (Stock >= 0),
    PRIMARY KEY (ID_Producto, ID_Zona, ID_Vivero),
    FOREIGN KEY (ID_Producto) REFERENCES Producto(ID_Producto) ON DELETE CASCADE,
    FOREIGN KEY (ID_Zona, ID_Vivero) REFERENCES Zona(ID_Zona, ID_Vivero) ON DELETE CASCADE
);

-- Tabla Detalle_Pedido
CREATE TABLE Detalle_Pedido (
    ID_Pedido INTEGER NOT NULL,
    ID_Producto INTEGER NOT NULL,
    Cantidad INTEGER NOT NULL CHECK (Cantidad > 0),
    Precio_Unitario DECIMAL(10,2) NOT NULL CHECK (Precio_Unitario > 0),
    PRIMARY KEY (ID_Pedido, ID_Producto),
    FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido) ON DELETE CASCADE,
    FOREIGN KEY (ID_Producto) REFERENCES Producto(ID_Producto) ON DELETE RESTRICT
);

-- Inserción de datos

-- Insertar Viveros
INSERT INTO Vivero (Nombre, Latitud, Longitud) VALUES
('Tajinaste Las Torres', 28.468200, -16.251800),
('Tajinaste La Laguna', 28.485300, -16.320100),
('Tajinaste Santa Cruz', 28.463600, -16.251000),
('Tajinaste Puerto', 28.415800, -16.548700),
('Tajinaste Icod', 28.367400, -16.720500);

-- Insertar Zonas
INSERT INTO Zona (ID_Vivero, Nombre) VALUES
(1, 'Exterior'), (1, 'Almacén'), (1, 'Invernadero'),
(2, 'Exterior'), (2, 'Almacén'),
(3, 'Exterior'), (3, 'Invernadero'), (3, 'Mostrador'),
(4, 'Exterior'), (4, 'Almacén'),
(5, 'Exterior'), (5, 'Invernadero'), (5, 'Mostrador');

-- Insertar Productos
INSERT INTO Producto (Nombre, Tipo, Precio_Actual) VALUES
('Rosa de Pitiminí', 'Planta', 12.50),
('Laurel Canario', 'Árbol', 25.00),
('Sustrato Universal', 'Sustrato', 8.75),
('Regadera Verde', 'Herramienta', 15.30),
('Maceta Terracota', 'Decoración', 6.50),
('Tajinaste Rojo', 'Planta', 18.00),
('Fertilizante Orgánico', 'Fertilizante', 12.80);

-- Insertar Puestos
INSERT INTO Puesto (Nombre) VALUES
('Dependiente'),
('Jefe de Vivero'),
('Jardineros'),
('Almacenero'),
('Cajero');

-- Insertar Empleados
INSERT INTO Empleado (DNI_Empleado, Nombre, Fecha_Ingreso, ID_Zona, ID_Vivero) VALUES
('12345678A', 'Ana Pérez Gómez', '2020-05-15', 1, 1),
('23456789B', 'Carlos Rodríguez Díaz', '2019-03-10', 2, 1),
('34567890C', 'María López Hernández', '2021-01-20', 1, 2),
('45678901D', 'Juan García Martín', '2018-11-05', 1, 3),
('56789012E', 'Laura Martínez Castro', '2022-06-30', 3, 3);

-- Insertar Historial de Puestos
INSERT INTO Historial_Puestos (DNI_Empleado, ID_Puesto, Fecha_Inicio, Fecha_Fin) VALUES
('12345678A', 1, '2020-05-15', '2021-06-30'),
('12345678A', 2, '2021-07-01', NULL),
('23456789B', 4, '2019-03-10', NULL),
('34567890C', 1, '2021-01-20', NULL),
('45678901D', 2, '2018-11-05', NULL),
('56789012E', 5, '2022-06-30', NULL);

-- Insertar Clientes Plus
INSERT INTO Cliente_Plus (DNI_Cliente, Nombre, Email, Telefono, Fecha_Ingreso_Plus, Bonificador) VALUES
('11111111X', 'Elena Santos Ruiz', 'elena.santos@email.com', '+34611111111', '2023-01-15', 5.0),
('22222222Y', 'David González Méndez', 'david.gonzalez@email.com', '+34622222222', '2023-03-20', 7.5),
('33333333Z', 'Sofía Ramírez López', 'sofia.ramirez@email.com', '+34633333333', '2024-02-10', 3.0),
('44444444W', 'Pedro Álvarez Suárez', 'pedro.alvarez@email.com', '+34644444444', '2024-05-01', 10.0),
('55555555V', 'Isabel Torres Marrero', 'isabel.torres@email.com', '+34655555555', '2024-07-12', 2.5);

-- Insertar Pedidos
INSERT INTO Pedido (Importe, Fecha, Metodo_Pago, DNI_Cliente, DNI_Empleado) VALUES
(45.90, '2024-10-01', 'tarjeta', '11111111X', '12345678A'),
(32.50, '2024-10-02', 'efectivo', '22222222Y', '34567890C'),
(67.80, '2024-10-03', 'transferencia', '33333333Z', '45678901D'),
(28.75, '2024-10-04', 'tarjeta', '44444444W', '56789012E'),
(15.30, '2024-10-05', 'efectivo', NULL, '12345678A'); -- Pedido sin cliente Plus

-- Insertar Stock
INSERT INTO Stock (ID_Producto, ID_Zona, ID_Vivero, Stock) VALUES
(1, 1, 1, 20), (2, 2, 1, 30), (6, 1, 1, 10), (3, 3, 1, 50),
(1, 4, 2, 100), (5, 5, 2, 25), (7, 4, 2, 40),
(1, 6, 3, 20), (4, 8, 3, 30), (6, 7, 3, 10), (3, 6, 3, 50),
(1, 9, 4, 100), (5, 10, 4, 25), (7, 9, 4, 40),
(1, 11, 5, 20), (4, 13, 5, 30), (6, 12, 5, 10), (3, 11, 5, 50);

-- Insertar Detalles de Pedido
INSERT INTO Detalle_Pedido (ID_Pedido, ID_Producto, Cantidad, Precio_Unitario) VALUES
(1, 1, 2, 12.50), (1, 3, 1, 8.75), (1, 5, 2, 6.50),
(2, 2, 1, 25.00), (2, 4, 1, 15.30),
(3, 6, 3, 18.00), (3, 7, 1, 12.80),
(4, 1, 1, 12.50), (4, 3, 1, 8.75), (4, 5, 1, 6.50),
(5, 4, 1, 15.30);

-- Mostramos los datos insertados para verificación

SELECT * FROM Vivero;
SELECT * FROM Zona;
SELECT * FROM Producto;
SELECT * FROM Puesto;
SELECT * FROM Empleado;
SELECT * FROM Historial_Puestos;
SELECT * FROM Cliente_Plus;
SELECT * FROM Pedido;
SELECT * FROM Stock;
SELECT * FROM Detalle_Pedido;

-- Operaciones DELETE

-- 1. Eliminar un cliente Plus (los pedidos quedan con NULL)
DELETE FROM Cliente_Plus WHERE DNI_Cliente = '22222222Y';

-- 2. Eliminar stock específico de una zona, porque ya no se vende ese producto allí.
DELETE FROM Stock WHERE ID_Zona = 1 AND ID_Vivero = 1 AND ID_Producto = 1;

-- 3. Eliminar un pedido (se eliminan los detalles asociados)
DELETE FROM Pedido WHERE ID_Pedido = 5;

-- Mostramos los datos después de los DELETE para verificación

SELECT * FROM Vivero;
SELECT * FROM Zona;
SELECT * FROM Producto;
SELECT * FROM Puesto;
SELECT * FROM Empleado;
SELECT * FROM Historial_Puestos;
SELECT * FROM Cliente_Plus;
SELECT * FROM Pedido;
SELECT * FROM Stock;
SELECT * FROM Detalle_Pedido;

-- Fin del script