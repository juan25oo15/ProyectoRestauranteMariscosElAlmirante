CREATE TABLE salas (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    mesas INT NOT NULL
    )

CREATE TABLE usuarios(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(200) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    pass VARCHAR(50) NOT NULL,
    rol ENUM('EMPLEADO', 'ADMINISTRADOR') NOT NULL
    )

CREATE TABLE pedidos(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_usuario INT NOT NULL,
    id_sala INT NOT NULL,
    num_mesa INT NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) NOT NULL DEFAULT 0,
    estado ENUM('PENDIENTE','FINALIZADO') NOT NULL DEFAULT 'PENDIENTE',
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id) ON DELETE SET NULL,
    FOREIGN KEY (id_sala) REFERENCES salas(id) ON DELETE CASCADE
)

CREATE TABLE platos(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
	precio DECIMAL(10,2) NOT NULL
)

CREATE TABLE detalle_pedido(
    id_pedido INT NOT NULL,
    id_plato INT NOT NULL,
    cantidad INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
	comentario TEXT DEFAULT NULL,
    PRIMARY KEY (id_pedido, id_plato),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id) ON DELETE CASCADE,
    FOREIGN KEY (id_plato) REFERENCES platos(id) ON DELETE CASCADE
)

CREATE TABLE config(
    id INT PRIMARY KEY NOT NULL,
    rfc VARCHAR(100) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(12) NOT NULL,
    direccion TEXT NOT NULL,
    mensaje VARCHAR(200) NOT NULL
)

INSERT INTO salas (nombre, mesas) VALUES
('Sala Principal', 15),
('Segundo Piso', 10),
('Balcón', 3);

INSERT INTO usuarios (nombre, correo, pass, rol) VALUES
('Juan Pérez', 'juan@example.com', '12345', 'ADMINISTRADOR'),
('María Gómez', 'maria@example.com', '67890', 'EMPLEADO'),
('Carlos Ramírez', 'carlos@example.com', 'abcd1234', 'EMPLEADO');

INSERT INTO pedidos (id_usuario, id_sala, num_mesa, total, estado) VALUES
(1, 1, 3, 250.50, 'PENDIENTE'),
(2, 2, 1, 100.00, 'FINALIZADO'),
(3, 1, 5, 450.75, 'PENDIENTE');

INSERT INTO platos (nombre, precio) VALUES
('Ceviche Mixto', 120.50),
('Tacos de Mariscos', 90.00),
('Langosta a la Plancha', 350.00);

INSERT INTO detalle_pedido (id_pedido, id_plato, cantidad, precio, comentario) VALUES
(1, 1, 2, 120.50, 'Sin picante'),
(1, 2, 1, 90.00, 'Con extra salsa'),
(2, 3, 1, 350.00, NULL);

INSERT INTO config (id, rfc, nombre, telefono, direccion, mensaje) VALUES
(1, 'MAAJ010512HN3', 'Restaurante Mariscos "El Almirante"', '0528131406079', 'Pesquería, Nuevo León', '¡Bienvenido a nuestro restaurante!')