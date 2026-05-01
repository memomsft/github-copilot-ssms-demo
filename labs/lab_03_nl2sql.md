# Lab 3 — NL2SQL: De Lenguaje Natural a T-SQL + Slash Commands

**⏱️ Duración:** ~15 minutos  
**🎯 Objetivo:** Demostrar cómo generar queries T-SQL complejas desde descripciones en español, refinarlas en conversación, y optimizarlas con slash commands.

---

## 🧠 Concepto Clave (para el presentador)

> "NL2SQL (Natural Language to SQL) es la killer feature para DBAs. En lugar de recordar sintaxis compleja, joins, funciones de ventana o CTEs, describes lo que necesitas y Copilot lo escribe. Luego tú revisas, ajustas y ejecutas."

**Regla de oro:** Copilot genera el código — el DBA decide si ejecutarlo. Siempre revisa antes de correr en producción.

---

## Ejercicio 3.1 — NL2SQL Básico

Escribe en el chat:

```
Dame los 10 clientes con mayor volumen de ventas total en 2013, mostrando su nombre, ciudad y el total en dólares formateado
```

Copilot generará una query. Haz clic en **"Insert into Editor"** (botón que aparece sobre el código generado) para insertarla en el Query Editor.

**Ejecuta la query** con `F5` y muestra los resultados al público.

> 💡 **Para el presentador:** Señala que Copilot generó el JOIN entre `Sales.Customer`, `Person.Person`, `Sales.SalesOrderHeader` y probablemente `Person.Address` — todo sin que lo pidieras explícitamente. Entendió la intención.

---

## Ejercicio 3.2 — Refinamiento Multi-Turn (el poder del contexto)

Sobre la misma conversación, continúa:

```
Ahora agrupa esos resultados por territorio de ventas y muestra cuántos clientes hay en cada territorio
```

```
Agrega una columna que muestre el porcentaje que representa cada territorio sobre el total de ventas
```

```
Ordena por porcentaje descendente y limita a los 5 territorios con más ventas
```

> 💡 **Para el presentador:** Esto es lo que antes requería 3 iteraciones de query, debugging y búsquedas en Stack Overflow. Con Copilot, es una conversación lineal. El código evoluciona incrementalmente.

---

## Ejercicio 3.3 — Slash Commands: El DBA como Code Reviewer

### `/explain` — Entiende código heredado

Escribe esta query en el editor (simula código heredado que nadie entiende):

```sql
SELECT 
    p.ProductID,
    p.Name,
    SUM(od.OrderQty) AS TotalVendido,
    RANK() OVER (PARTITION BY pc.Name ORDER BY SUM(od.OrderQty) DESC) AS RankEnCategoria
FROM Production.Product p
JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
JOIN Sales.SalesOrderDetail od ON p.ProductID = od.ProductID
JOIN Sales.SalesOrderHeader oh ON od.SalesOrderID = oh.SalesOrderID
WHERE oh.OrderDate >= '2013-01-01' AND oh.OrderDate < '2014-01-01'
GROUP BY p.ProductID, p.Name, pc.Name
HAVING SUM(od.OrderQty) > 100
ORDER BY pc.Name, RankEnCategoria;
```

Selecciona toda la query, clic derecho → **Explain** (o escribe `/explain` en el chat):

```
/explain
```

> 💡 **Para el presentador:** Copilot explicará en lenguaje natural qué hace esta query, incluyendo la función de ventana RANK() y el HAVING. Esto es invaluable cuando un DBA hereda código sin documentación.

---

### `/optimize` — Mejora el rendimiento

Con la misma query seleccionada, escribe en el chat:

```
/optimize
```

O en el chat:

```
Esta query tarda más de 10 segundos en producción con millones de registros. ¿Cómo la optimizas? ¿Qué índices recomiendas?
```

> 💡 **Para el presentador:** Copilot puede sugerir índices, reescribir el WHERE, o proponer CTEs para mejorar la legibilidad y rendimiento. Importante: siempre valida las sugerencias de índices antes de crearlos en producción.

---

### `/doc` — Documenta automáticamente

Selecciona la query original y escribe:

```
/doc
```

Copilot generará comentarios explicativos sobre cada sección de la query.

> 💡 **Para el presentador:** Para un equipo, esto es transformador. La documentación suele ser lo primero que se omite bajo presión. Ahora tarda segundos.

---

## Ejercicio 3.4 — Autocompletions en el Editor (SSMS 22.2+)

Abre un nuevo Query Editor conectado a AdventureWorks y empieza a escribir:

```sql
SELECT TOP 10
    c.CustomerID,
    p.FirstName + ' ' + p.LastName AS NombreCliente,
    -- empieza a escribir aquí y espera la sugerencia en gris
```

Pausa después de escribir el último comma. Copilot debería sugerir en texto gris la siguiente columna lógica.

Presiona **Tab** para aceptar la sugerencia.

> ⚠️ **Nota para el presentador:** Las autocompletions no siempre aparecen inmediatamente — dependen del contexto del editor y la conexión. Si no aparece en el demo en vivo, muéstralo como concepto explicando que funciona igual que Copilot en VS Code.

---

## ✅ Resumen del Lab 3

| Feature | Cómo se usa | Valor para el DBA |
|---------|-------------|-------------------|
| NL2SQL | Chat: describe lo que necesitas | Elimina tiempo de escritura de T-SQL |
| Multi-turn | Refinamiento conversacional | Itera sin repetir contexto |
| `/explain` | Selecciona query + clic derecho | Entiende código heredado al instante |
| `/optimize` | Selecciona query + `/optimize` | Detecta cuellos de botella |
| `/doc` | Selecciona query + `/doc` | Documenta código automáticamente |
| Autocompletions | Escribe en el editor | Acelera escritura con sugerencias inline |

**➡️ Siguiente: [Lab 4 — Tareas de Administración DBA](lab_04_dba_admin.md)**
