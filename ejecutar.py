"""Ejecuta y verifica el ETL sobre una base SQLite local."""
import sqlite3
from pathlib import Path

ROOT = Path(__file__).resolve().parent
TABLES = ("DimProducto", "DimCliente", "DimSucursal", "DimFecha", "FactVentas")

def ejecutar():
    scripts = [(ROOT / name).read_text(encoding="utf-8")
               for name in ("modelo.sql", "origen.sql", "carga.sql")]
    db = sqlite3.connect(ROOT / "ventas.sqlite")
    try:
        db.execute("PRAGMA foreign_keys = ON")
        with db:
            db.executescript("BEGIN IMMEDIATE;\n" + "\n".join(scripts))
            origen = db.execute(
                "SELECT COUNT(*), SUM(cantidad), SUM(cantidad*precio_centavos) FROM stg_ventas"
            ).fetchone()
            destino = db.execute(
                "SELECT COUNT(*), SUM(cantidad), SUM(importe_centavos) FROM FactVentas"
            ).fetchone()
            errores_fk = db.execute("PRAGMA foreign_key_check").fetchall()
            if origen != destino or errores_fk:
                raise RuntimeError("Falló la conciliación o la integridad referencial")
        print(f"SQLite {sqlite3.sqlite_version}")
        for table in TABLES:
            count, = db.execute(f"SELECT COUNT(*) FROM {table}").fetchone()
            print(f"{table:<15} {count:>3} filas")
        print(f"Origen y destino: {destino[0]} líneas, {destino[1]} unidades")
        print(f"Importe conciliado: RD$ {destino[2] / 100:,.2f}")
        print(f"Violaciones de claves foráneas: {len(errores_fk)}")
    finally:
        db.close()

if __name__ == "__main__":
    ejecutar()
