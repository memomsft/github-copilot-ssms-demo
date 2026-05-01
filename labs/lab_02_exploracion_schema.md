# Lab 2 — Exploración del Esquema con Lenguaje Natural

> 📍 **Estás en:** [Inicio](../README.md) → [Lab 1](lab_01_primer_contacto.md) → **Lab 2** → [Lab 3](lab_03_nl2sql.md)

---

**⏱️ Duración:** ~10 minutos  
**🎯 Objetivo:** Demostrar cómo un DBA puede entender un esquema desconocido en minutos usando solo lenguaje natural — sin escribir una línea de T-SQL.

---

## 🧠 Concepto Clave (para el presentador)

> "Uno de los trabajos más tediosos de un DBA es llegar a una base de datos desconocida y mapear su estructura. Normalmente toma horas navegar el Object Explorer, leer documentación y ejecutar queries de sistema. Con Copilot, ese proceso se reduce a una conversación."

**Escenario del demo:** *"Acabas de unirte a un nuevo equipo. Tu primera tarea es entender la base de datos AdventureWorks antes de una reunión en 15 minutos."*

---

## Ejercicio 2.1 — Mapa General de la Base de Datos

Copia y pega estos prompts en el chat **uno por uno**, esperando la respuesta de cada uno antes de continuar:

```
¿Cuántas tablas tiene esta base de datos y cuáles son los esquemas principales?
```

```
¿Cuál es la tabla más grande de la base de datos por número de filas?
```

```
¿Qué columnas almacenan correos electrónicos en la base de datos?
```

> 💡 **Para el presentador:** Estos tres prompts normalmente requerirían 3 queries diferentes sobre `sys.tables`, `sys.dm_db_partition_stats` y `INFORMATION_SCHEMA.COLUMNS`. Copilot los ejecuta y te presenta los resultados de forma legible.

---

## Ejercicio 2.2 — Exploración Multi-Turn (conversación encadenada)

Esta es una de las capacidades más poderosas. Copilot recuerda el contexto de la conversación:

```
¿Qué tablas están relacionadas con ventas?
```

```
De esas tablas, ¿cuál tiene más registros?
```

```
¿Qué columnas clave debería conocer de esa tabla para hacer análisis de ventas?
```

```
Dame un ejemplo de los primeros 5 registros de esa tabla en formato tabla
```

> 💡 **Para el presentador:** Muestra cómo cada pregunta se construye sobre la anterior. No tuviste que repetir el contexto — Copilot mantiene el hilo de la conversación. Esto es especialmente valioso para onboarding de nuevos DBAs.

---

## Ejercicio 2.3 — Preguntas de Administración del Entorno

Cambia el contexto: ahora eres el DBA responsable del ambiente. Pregunta:

```
¿Cuál es el tamaño actual de la base de datos y cuánto espacio libre tienen sus archivos?
```

```
Lista los índices de la tabla Sales.SalesOrderHeader con su tipo y tamaño estimado
```

```
¿Han fallado trabajos del SQL Agent en la última semana?
```

> ⚠️ **Nota para el presentador:** Esta última pregunta requiere que el SQL Agent esté activo. Si no hay jobs configurados, Copilot lo indicará. Es un buen momento para explicar que Copilot respeta el estado real del entorno.

---

## Ejercicio 2.4 — "Momento Decisor" 🎯

Este prompt está diseñado para impactar a la audiencia no técnica:

```
Si tuviera que explicarle a un director de empresa qué datos tenemos en esta base de datos y para qué sirven, ¿cómo lo describirías en lenguaje de negocio, sin términos técnicos?
```

> 💡 **Para el presentador:** Este prompt demuestra que Copilot no es solo una herramienta técnica — puede traducir el mundo de los datos al lenguaje del negocio. Los decisores ven valor inmediato aquí.

---

## ✅ Resumen del Lab 2

| Capacidad demostrada | Prompt utilizado |
|---------------------|-----------------|
| Mapa de esquema | "¿Cuántas tablas tiene...?" |
| Tabla más grande | "¿Cuál es la tabla más grande...?" |
| Búsqueda semántica en columnas | "¿Qué columnas almacenan emails...?" |
| Conversación multi-turn | Cadena de 4 preguntas sobre Sales |
| Traducción a lenguaje de negocio | Último prompt del Lab |

**Mensaje clave para decisores:** *"En 10 minutos, un DBA nuevo puede conocer una base de datos que normalmente tomaría días entender."*

---

⬅️ [Lab 1 — Primer Contacto](lab_01_primer_contacto.md) | ➡️ **Siguiente: [Lab 3 — NL2SQL y Slash Commands](lab_03_nl2sql.md)**
