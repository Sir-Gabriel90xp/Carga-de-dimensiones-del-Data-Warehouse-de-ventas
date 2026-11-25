CREATE TEMP TABLE stg_ventas (
    linea_id INTEGER PRIMARY KEY, fecha TEXT NOT NULL,
    sku TEXT NOT NULL, producto TEXT NOT NULL, categoria TEXT NOT NULL,
    cliente_id TEXT NOT NULL, cliente TEXT NOT NULL, segmento TEXT NOT NULL,
    sucursal_id TEXT NOT NULL, sucursal TEXT NOT NULL, ciudad TEXT NOT NULL,
    cantidad INTEGER NOT NULL, precio_centavos INTEGER NOT NULL
);
INSERT INTO stg_ventas VALUES
(1,'2026-11-01',' P01 ',' Camiseta ','Ropa','C01','Cliente Uno','Minorista','S01','Centro','Bayaguana',2,70000),
(2,'2026-11-01','P02','Pantalón','Ropa','C02','Cliente Dos','Minorista','S01','Centro','Bayaguana',1,150000),
(3,'2026-11-02','P01','Camiseta','Ropa','C01','Cliente Uno','Minorista','S02','Norte','Monte Plata',1,70000),
(4,'2026-11-02','P03','Gorra','Accesorios','C03','Cliente Tres','Mayorista','S02','Norte','Monte Plata',3,40000),
(5,'2026-11-03','P02','Pantalón','Ropa','C03','Cliente Tres','Mayorista','S01','Centro','Bayaguana',2,150000),
(6,'2026-11-03','P03','Gorra','Accesorios','C02','Cliente Dos','Minorista','S02','Norte','Monte Plata',1,40000);
