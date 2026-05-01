# Instrucciones del Equipo DBA

> Este archivo debe colocarse en `%USERPROFILE%\copilot-instructions.md`
> GitHub Copilot en SSMS lo leerá automáticamente en cada conversación.
> Personaliza estas instrucciones según los estándares de tu organización.

## Convenciones de Nombres

- Las tablas de staging llevan prefijo `stg_`
- Los índices se nombran como `IX_NombreTabla_Columna`
- Los stored procedures empiezan con `usp_`
- Los triggers empiezan con `tr_`
- Nunca usar `SELECT *` en queries de producción

## Estándares de Código T-SQL

- Palabras clave siempre en MAYÚSCULAS (SELECT, FROM, WHERE, JOIN, etc.)
- Siempre usar alias descriptivos para las tablas (no `a`, `b` — usar `ord`, `cust`, etc.)
- Incluir comentarios en el encabezado de stored procedures:
  ```sql
  -- ============================================
  -- Autor:       [Nombre]
  -- Fecha:       [YYYY-MM-DD]
  -- Descripción: [Qué hace este procedimiento]
  -- ============================================
  ```
- Siempre incluir la cláusula `WHERE` en `DELETE` y `UPDATE`

## Seguridad y Buenas Prácticas

- Los scripts de `DROP` deben ir dentro de `BEGIN TRANSACTION ... ROLLBACK` para pruebas
- No usar `NOLOCK` sin aprobación explícita del DBA líder
- Nunca generar scripts que accedan directamente a tablas del esquema `dbo` sin revisión
- Usar siempre schemas explícitos: `Sales.Orders`, no solo `Orders`

## Entorno Objetivo

- SQL Server 2022 (versión 16.x)
- Modo de compatibilidad: 160
- Base de datos principal: AdventureWorks2022
- Instancia: [ajusta según tu entorno]

## Idioma y Formato de Respuestas

- Responde en español cuando sea posible
- Los comentarios dentro del código pueden ir en inglés o español
- Los resultados de queries se prefieren en formato tabla cuando sea posible
- Al generar scripts largos, incluye secciones con comentarios separadores
