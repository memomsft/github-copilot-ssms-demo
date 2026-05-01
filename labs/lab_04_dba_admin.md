# Lab 4 — Tareas de Administración DBA con Copilot

> 📍 **Estás en:** [Inicio](../README.md) → [Lab 3](lab_03_nl2sql.md) → **Lab 4** → [Lab 5](lab_05_custom_instructions.md)

---

**⏱️ Duración:** ~10 minutos  
**🎯 Objetivo:** Demostrar cómo Copilot acelera las tareas más comunes y críticas de un DBA: diagnóstico de bloqueos, análisis de performance y automatización de backups.

---

## 🧠 Concepto Clave (para el presentador)

> "Un DBA de alto rendimiento no es el que memoriza más DMVs (Dynamic Management Views) — es el que sabe hacer las preguntas correctas. Copilot convierte preguntas de negocio en queries de sistema sin que el DBA tenga que recordar sintaxis de `sys.dm_exec_*`."

**Escenario del demo:** *"Son las 2 AM. Hay alertas de lentitud en producción. Tienes 5 minutos para diagnosticar el problema."*

---

## Ejercicio 4.1 — Diagnóstico de Bloqueos

Escribe en el chat:

```
¿Hay bloqueos activos en la base de datos ahora mismo? Si los hay, muéstrame qué sesión está bloqueando y qué sesión está siendo bloqueada
```

Si no hay bloqueos activos (probable en AdventureWorks de demo), Copilot lo indicará. Entonces pregunta:

```
Dame la query que debería ejecutar para monitorear bloqueos en tiempo real, con el texto de la query que está causando el bloqueo
```

> 💡 **Para el presentador:** Copia el script generado al editor y muéstralo. Copilot generará algo sobre `sys.dm_exec_requests` + `sys.dm_exec_sql_text`. El valor aquí es que el DBA no necesitó recordar esas DMVs — solo describió el problema.

Guarda el script generado en `scripts/diagnostico_bloqueos.sql` de este repositorio.

---

## Ejercicio 4.2 — Análisis de Performance

```
¿Cuáles son las queries que más recursos han consumido en las últimas 2 horas? Muéstrame el texto de la query, el número de ejecuciones y el tiempo promedio de CPU
```

```
¿Qué índices no se están usando en esta base de datos? Lista los 5 índices con mayor costo de mantenimiento y menor uso
```

```
¿Cuáles son los tiempos de espera más altos (wait stats) en este servidor?
```

> 💡 **Para el presentador:** Estos tres prompts cubren el triángulo del diagnóstico de performance: queries lentas, índices innecesarios y wait stats. Antes requería conocimiento profundo de `sys.dm_exec_query_stats`, `sys.dm_db_index_usage_stats` y `sys.dm_os_wait_stats`.

---

## Ejercicio 4.3 — Estrategia de Backup (multi-turn educativo)

Este ejercicio muestra el valor de Copilot para tomar decisiones de administración:

```
¿Qué modelo de recuperación tiene esta base de datos?
```

```
¿Cuál es la diferencia entre un backup completo y un backup de log de transacciones?
```

```
Si el objetivo de punto de recuperación (RPO) es de 1 hora, ¿qué estrategia de backup recomiendas?
```

```
Crea el script completo para implementar esa estrategia con SQL Agent Jobs
```

> 💡 **Para el presentador:** Este es el "momento wow" para decisores. Pasamos de una pregunta conceptual a un script completo de SQL Agent en 4 preguntas. Lo que antes tomaba 30 minutos de documentación y escritura, tomó 2 minutos de conversación.

El script generado va en `scripts/backup_automatizado.sql`.

---

## Ejercicio 4.4 — Preguntas de Configuración del Servidor

```
Lista las configuraciones del servidor que han sido modificadas desde sus valores predeterminados, en formato tabla
```

```
¿Cuántas conexiones activas hay al servidor ahora mismo y de qué aplicaciones vienen?
```

```
¿Cómo cambio el modo de compatibilidad de esta base de datos y cuál es el impacto en las queries existentes?
```

> 💡 **Para el presentador:** Esta última pregunta es excelente para mostrar el multi-turn educativo — Copilot no solo da el comando, explica el impacto y puede guiar paso a paso por el proceso de prueba antes de hacer el cambio en producción.

---

## ⚠️ Limitación Importante a Señalar Aquí

> **Para el presentador:** Este es el momento ideal para mencionar la limitación de Agent Mode.

Intenta este prompt:

```
Elimina todos los registros de la tabla HumanResources.JobCandidate que tengan más de 2 años de antigüedad
```

Copilot **generará el script** pero **no lo ejecutará automáticamente**. Deberás copiarlo al editor y ejecutarlo manualmente.

**Mensaje para la audiencia:** *"Esto es por diseño — Copilot no ejecuta comandos destructivos (DELETE, UPDATE, DROP) de forma autónoma. Microsoft tiene Agent Mode en el roadmap, que permitirá esto con aprobación explícita del usuario. Hoy, el DBA siempre tiene el control final."*

---

## ✅ Resumen del Lab 4

| Tarea DBA | Antes | Con Copilot |
|-----------|-------|-------------|
| Diagnosticar bloqueos | Recordar DMVs, 10+ min | 30 segundos de chat |
| Análisis de queries lentas | Query manual compleja | 1 prompt |
| Estrategia de backup + script | 30+ min de documentación | 4 prompts |
| Configuración del servidor | Navegar sys.configurations | 1 prompt |

---

⬅️ [Lab 3 — NL2SQL](lab_03_nl2sql.md) | ➡️ **Siguiente: [Lab 5 — Custom Instructions](lab_05_custom_instructions.md)**
