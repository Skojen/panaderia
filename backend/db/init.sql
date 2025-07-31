CREATE TABLE IF NOT EXISTS productos (
  id SERIAL PRIMARY KEY,
  nombre TEXT NOT NULL,
  precio INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS pedidos (
  id SERIAL PRIMARY KEY,
  cliente TEXT NOT NULL,
  total INTEGER,
  fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS pedido_productos (
  pedido_id INTEGER REFERENCES pedidos(id) ON DELETE CASCADE,
  producto_id INTEGER REFERENCES productos(id),
  cantidad INTEGER
);

INSERT INTO productos (nombre, precio) VALUES 
('Marraqueta', 150),
('Pan Amasado', 200),
('Hallulla', 180),
('Baguette', 350),
('Croissant', 500),
('Pan Integral', 220),
('Pan de Molde', 300),
('Pan Ciabatta', 400),
('Pan de Queso', 450),
('Pan de Chocolate', 550);