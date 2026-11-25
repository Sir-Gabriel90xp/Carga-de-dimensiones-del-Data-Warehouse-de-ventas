# Data Warehouse de ventas

Práctica de Electiva. Modelo estrella con una fila por línea de venta y cuatro dimensiones: producto, cliente, sucursal y fecha. El origen contiene datos ficticios de una tienda de ropa.

## Ejecutar

Desde esta carpeta, con Python 3 y SQLite 3.24 o posterior:

```sh
python ejecutar.py
python ejecutar.py
```

El primer comando crea y carga `ventas.sqlite`. El segundo vuelve a cargar los mismos datos para verificar que las claves naturales y los identificadores de línea evitan duplicados. Los scripts SQL crean el modelo, simulan la extracción a staging y aplican la carga. El programa compara las filas, cantidades e importes con el origen y revisa las claves foráneas antes de confirmar la transacción.

El archivo `evidencia.txt` conserva la salida de las dos ejecuciones. Para inspeccionar todas las filas, abre `ventas.sqlite` con un cliente SQLite y consulta las tablas listadas en esa salida.
