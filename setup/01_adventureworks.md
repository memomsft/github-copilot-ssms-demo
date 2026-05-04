# 🗄️ Setup - AdventureWorks

> 📍 **Estás en:** [Inicio](../README.md) → [Prerrequisitos](00_prerequisitos.md) → **Instalar AdventureWorks** → [Lab 1](../labs/lab_01_primer_contacto.md)

---

AdventureWorks es la base de datos de ejemplo oficial de Microsoft. Simula una empresa de manufactura y ventas de bicicletas — perfecta para demos de DBA porque tiene esquemas ricos, relaciones, índices y datos suficientes para generar escenarios realistas.

---

## Opción A - Restaurar desde backup (SQL Server local)

1. Descarga el archivo `.bak` desde el repositorio oficial de Microsoft:
   👉 [github.com/microsoft/sql-server-samples](https://github.com/microsoft/sql-server-samples/releases/tag/adventureworks)
   - Recomendado: **AdventureWorks2022.bak**

2. Copia el archivo a tu carpeta de backups de SQL Server (usualmente `C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\`)

3. En SSMS: clic derecho en **Databases > Restore Database...**

4. Selecciona **Device**, navega al `.bak` y haz clic en **OK**

5. Verifica que la base de datos aparezca en el Object Explorer

---

## Opción B - Azure SQL Database

Si usas Azure SQL, puedes restaurar AdventureWorks directamente desde el portal:

1. En el portal de Azure, crea un nuevo **Azure SQL Database**
2. En la sección **Additional settings**, selecciona `AdventureWorksLT` como **Sample data**
3. Conecta SSMS a tu servidor de Azure SQL

> ⚠️ Nota: AdventureWorksLT es una versión reducida. Para el demo completo usa la versión full (`AdventureWorks2022`).

---

## Validar la instalación

Ejecuta esto en SSMS para confirmar que tienes las tablas correctas:

```sql
-- Verifica que AdventureWorks está disponible
USE AdventureWorks2022;
GO

-- Cuenta de tablas por esquema
SELECT 
    TABLE_SCHEMA AS Esquema,
    COUNT(*) AS NumeroDeTablas
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
GROUP BY TABLE_SCHEMA
ORDER BY NumeroDeTablas DESC;
```

**Resultado esperado:** Deberías ver esquemas como `Sales`, `Production`, `HumanResources`, `Person`, `Purchasing` con varias tablas cada uno.

---

## Esquemas clave para el demo

| Esquema | Descripción | Tablas relevantes |
|---------|-------------|-------------------|
| `Sales` | Órdenes, clientes, territorios | `SalesOrderHeader`, `Customer`, `SalesTerritory` |
| `Production` | Productos, inventario, manufactura | `Product`, `ProductCategory`, `WorkOrder` |
| `HumanResources` | Empleados, departamentos | `Employee`, `Department` |
| `Person` | Personas, contactos, direcciones | `Person`, `Address` |

---

> 💡 **Para el presentador:** Siempre conéctate a `AdventureWorks2022` (no a `master`) antes de abrir el Chat de Copilot. El contexto del chat se basa en la conexión activa del Query Editor.

---

⬅️ [Prerrequisitos](00_prerequisitos.md) | ➡️ **Siguiente: [Lab 1 - Primer Contacto](../labs/lab_01_primer_contacto.md)**
