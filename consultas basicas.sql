-- ══════════════════════════════════════════
-- TechStore — Consultas Básicas SELECT
-- Autora: Salva, María Gimena
-- Fecha: 01/11/2026
-- Motor: SQL Server (SSMS)
-- ══════════════════════════════════════════

USE PRACTICA;
GO

-- Consulta 1: Exploración general de la tabla sales
-- SELECT * trae TODAS las columnas. Tiene sentido para explorar una tabla
-- que no conocemos (ver qué columnas tiene y qué tipo de datos guarda),
-- sobre todo en tablas chicas o en pruebas.
-- No conviene usarlo en reportes ni en producción: trae columnas que nadie
-- necesita, es más lento en tablas grandes y, si la tabla cambia, el
-- resultado cambia sin aviso. En esos casos hay que nombrar las columnas.
SELECT *
FROM sales;

-- Consulta 2: Selección de columnas específicas para finanzas
-- Finanzas solo necesita identificar al cliente, el producto y el monto,
-- así que se piden únicamente esas tres columnas.
SELECT customer_id,
       product_id,
       total_amount
FROM sales;

-- Consulta 3: Selección con alias en español para stakeholders
-- AS renombra cada columna en el resultado (no cambia la tabla).
-- Los alias van en snake_case, sin espacios ni tildes.
SELECT order_date   AS fecha_pedido,
       product_name AS nombre_producto,
       quantity     AS cantidad_unidades
FROM sales;
