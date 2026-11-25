INSERT INTO DimProducto (codigo,nombre,categoria)
SELECT DISTINCT upper(trim(sku)),trim(producto),trim(categoria) FROM stg_ventas WHERE 1
ON CONFLICT(codigo) DO UPDATE SET nombre=excluded.nombre,categoria=excluded.categoria;

INSERT INTO DimCliente (codigo,nombre,segmento)
SELECT DISTINCT upper(trim(cliente_id)),trim(cliente),trim(segmento) FROM stg_ventas WHERE 1
ON CONFLICT(codigo) DO UPDATE SET nombre=excluded.nombre,segmento=excluded.segmento;

INSERT INTO DimSucursal (codigo,nombre,ciudad)
SELECT DISTINCT upper(trim(sucursal_id)),trim(sucursal),trim(ciudad) FROM stg_ventas WHERE 1
ON CONFLICT(codigo) DO UPDATE SET nombre=excluded.nombre,ciudad=excluded.ciudad;

INSERT INTO DimFecha
SELECT DISTINCT CAST(strftime('%Y%m%d',fecha) AS INTEGER), fecha,
    CAST(strftime('%Y',fecha) AS INTEGER), CAST(strftime('%m',fecha) AS INTEGER),
    CAST(strftime('%d',fecha) AS INTEGER)
FROM stg_ventas WHERE 1
ON CONFLICT(fecha_key) DO NOTHING;

INSERT INTO FactVentas
SELECT v.linea_id,p.producto_key,c.cliente_key,s.sucursal_key,f.fecha_key,
    v.cantidad,v.cantidad*v.precio_centavos
FROM stg_ventas v
JOIN DimProducto p ON p.codigo=upper(trim(v.sku))
JOIN DimCliente c ON c.codigo=upper(trim(v.cliente_id))
JOIN DimSucursal s ON s.codigo=upper(trim(v.sucursal_id))
JOIN DimFecha f ON f.fecha=v.fecha
WHERE 1
ON CONFLICT(linea_id) DO UPDATE SET producto_key=excluded.producto_key,
    cliente_key=excluded.cliente_key,sucursal_key=excluded.sucursal_key,
    fecha_key=excluded.fecha_key,cantidad=excluded.cantidad,importe_centavos=excluded.importe_centavos;
