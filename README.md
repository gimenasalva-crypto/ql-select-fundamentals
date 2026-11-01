# sql-select-fundamentals

**Autora:** Salva, María Gimena

**Motor:** SQL Server Express 17, ejecutado en SQL Server Management Studio 22

Consultas básicas `SELECT` y alias sobre la tabla `sales` de TechStore, para tres reportes pedidos por el equipo de finanzas.

## Contenido

| Archivo | Qué contiene |
|---|---|
| `consultas_basicas.sql` | Tres consultas: exploración general (`SELECT *`), selección de columnas específicas y selección con alias en español. |
| `README.md` | Esta documentación. |

Las tres consultas se ejecutaron en SQL Server sobre la tabla `sales` (10 registros) sin errores.

## ¿Por qué es mala práctica usar `SELECT *` en producción?

`SELECT *` sirve para explorar una tabla que no conocemos, pero en un reporte o en un sistema en producción trae problemas:

1. **Rendimiento.** Trae todas las columnas aunque no se usen. En la tabla `sales` son 9 columnas, pero finanzas solo necesita 3 (`customer_id`, `product_id`, `total_amount`). En una tabla real con millones de filas, eso significa leer y transferir el triple de datos, y la consulta tarda más.
2. **Mantenibilidad.** Si mañana alguien agrega una columna a `sales` o cambia el orden de las columnas, el resultado de `SELECT *` cambia sin aviso. Un reporte o un tablero que esperaba ciertas columnas en cierto orden puede romperse. Si las columnas están nombradas, la consulta siempre devuelve lo mismo y queda claro qué datos usa.
3. **Seguridad.** Si la tabla tiene datos sensibles (por ejemplo, email, teléfono o datos de pago de clientes), `SELECT *` los expone a quien reciba el resultado aunque no los necesite. Pedir solo las columnas necesarias limita qué información sale de la base.

Ejemplo, en lugar de:

```sql
SELECT * FROM sales;
```

conviene pedir solo lo necesario:

```sql
SELECT customer_id, product_id, total_amount
FROM sales;
```

## ¿Por qué son importantes los alias para un stakeholder no técnico?

Los nombres de columnas de una base están pensados para quienes la programan: suelen estar en inglés, abreviados o con nombres técnicos. Una persona de finanzas que recibe un reporte con la columna `total_amount` tiene que adivinar qué significa: ¿es el precio unitario? ¿incluye impuestos? ¿es en pesos o en dólares?

El alias renombra la columna **solo en el resultado**, sin modificar la tabla, para que el reporte se lea directamente:

```sql
SELECT order_date   AS fecha_pedido,
       total_amount AS monto_total_venta
FROM sales;
```

| Sin alias | Con alias |
|---|---|
| `order_date` | `fecha_pedido` |
| `total_amount` | `monto_total_venta` |

Con `monto_total_venta`, cualquier persona del área entiende que es lo que se cobró en esa venta (cantidad × precio unitario), sin conocer la base de datos ni preguntar al analista. Así el reporte se puede usar tal cual, se evitan malas interpretaciones y se ahorra tiempo de ida y vuelta.

Los alias se escriben en **snake_case** (palabras unidas con guion bajo), porque un alias con espacios como `AS Monto Total` da error de sintaxis.
