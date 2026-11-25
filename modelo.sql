CREATE TABLE IF NOT EXISTS DimProducto (
    producto_key INTEGER PRIMARY KEY,
    codigo TEXT NOT NULL UNIQUE, nombre TEXT NOT NULL, categoria TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS DimCliente (
    cliente_key INTEGER PRIMARY KEY,
    codigo TEXT NOT NULL UNIQUE, nombre TEXT NOT NULL, segmento TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS DimSucursal (
    sucursal_key INTEGER PRIMARY KEY,
    codigo TEXT NOT NULL UNIQUE, nombre TEXT NOT NULL, ciudad TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS DimFecha (
    fecha_key INTEGER PRIMARY KEY,
    fecha TEXT NOT NULL UNIQUE, anio INTEGER NOT NULL, mes INTEGER NOT NULL, dia INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS FactVentas (
    linea_id INTEGER PRIMARY KEY,
    producto_key INTEGER NOT NULL REFERENCES DimProducto,
    cliente_key INTEGER NOT NULL REFERENCES DimCliente,
    sucursal_key INTEGER NOT NULL REFERENCES DimSucursal,
    fecha_key INTEGER NOT NULL REFERENCES DimFecha,
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    importe_centavos INTEGER NOT NULL CHECK (importe_centavos >= 0)
);
