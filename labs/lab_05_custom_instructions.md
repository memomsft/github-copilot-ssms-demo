# Lab 5 — Custom Instructions: Estandariza las Prácticas del Equipo

> 📍 **Estás en:** [Inicio](../README.md) → [Lab 4](lab_04_dba_admin.md) → **Lab 5** → ✅ Fin del Demo

---

**⏱️ Duración:** ~5 minutos  
**🎯 Objetivo:** Demostrar cómo un equipo puede configurar Copilot para que siempre genere código que siga sus estándares internos, sin depender de que cada DBA los recuerde.

---

## 🧠 Concepto Clave (para el presentador)

> "Las Custom Instructions son como el 'manual de estilo de código' de tu equipo, pero que Copilot lee automáticamente en cada conversación. Si tu equipo tiene convenciones de nombres, esquemas prohibidos o patrones de seguridad, Copilot los respetará sin que nadie tenga que pedirlo."

Esta feature está disponible desde **SSMS 22.4.1** (GA, marzo 2026).

---

## ¿Cómo Funciona?

Copilot lee un archivo llamado `copilot-instructions.md` ubicado en la carpeta de perfil del usuario de Windows:

```
%USERPROFILE%\copilot-instructions.md
```

Por ejemplo: `C:\Users\guillermo\copilot-instructions.md`

Este archivo se incluye automáticamente como contexto en cada conversación del chat de Copilot en SSMS.

---

## Ejercicio 5.1 — Crear el Archivo de Custom Instructions

1. Abre el Explorador de Windows y navega a `%USERPROFILE%`
2. Crea un archivo nuevo llamado `copilot-instructions.md`
3. Pega el siguiente contenido (ajústalo a tu equipo):

```markdown
# Instrucciones del Equipo DBA — Empresa XYZ

## Convenciones de Nombres
- Las tablas de staging siempre llevan el prefijo `stg_`
- Los índices deben nombrarse como `IX_NombreTabla_Columna`
- Los stored procedures deben empezar con `usp_`
- Nunca usar SELECT * en queries de producción

## Seguridad
- Nunca generar scripts que afecten tablas de esquema `dbo` directamente sin revisión
- Siempre incluir la cláusula WHERE en DELETE y UPDATE
- Los scripts de DROP siempre deben ir dentro de un BEGIN TRANSACTION ... ROLLBACK para pruebas

## Estándares de Código
- Siempre incluir comentarios en el encabezado de stored procedures con: Autor, Fecha, Descripción
- Usar NOLOCK solo cuando el DBA lo apruebe explícitamente
- Formatear las queries con las palabras clave en mayúsculas (SELECT, FROM, WHERE, etc.)

## Base de Datos Objetivo
- El entorno de producción es SQL Server 2022
- El modo de compatibilidad objetivo es 160
- La base de datos principal se llama AdventureWorks2022

## Idioma
- Genera respuestas en español cuando sea posible
- Los comentarios de código pueden ser en inglés
```

4. Guarda el archivo
5. Reinicia la sesión de Copilot en SSMS (nueva conversación)

---

## Ejercicio 5.2 — Verificar que las Instrucciones Aplican

Abre una nueva conversación en el chat y escribe:

```
Crea un stored procedure que retorne los 10 clientes con más ventas del mes actual
```

**Verifica que Copilot:**
- ✅ Nombró el procedimiento como `usp_...`
- ✅ Incluyó el encabezado con Autor, Fecha, Descripción
- ✅ Usó palabras clave en mayúsculas
- ✅ No usó `SELECT *`
- ✅ Respondió en español

> 💡 **Para el presentador:** Sin custom instructions, Copilot genera código genérico. Con ellas, genera código que ya sigue los estándares del equipo. El tiempo de revisión de code review se reduce significativamente.

---

## Ejercicio 5.3 — Escenario de Valor para Decisores 🎯

Pregunta al público:

*"¿Cuánto tiempo pierde su equipo en revisiones de código por inconsistencias de estilo o estándares de seguridad?"*

Luego muestra este prompt:

```
Un DBA junior me entregó este script. ¿Cumple con nuestros estándares de equipo?
```

```sql
select * from dbo.sales
where customerid = 12345
```

Copilot detectará que el script viola los estándares (usa `SELECT *`, minúsculas, esquema `dbo` directo) y lo indicará.

> 💡 **Para el presentador:** Esto convierte a Copilot en un revisor automatizado de estándares. No solo genera código — valida el código existente contra las reglas del equipo.

---

## ✅ Resumen del Lab 5 y del Demo Completo

| Lab | Capacidad | Impacto |
|-----|-----------|---------|
| Lab 1 | Interfaz y configuración | Barrier de entrada bajo |
| Lab 2 | Exploración de esquema | Onboarding 10x más rápido |
| Lab 3 | NL2SQL + slash commands | Eliminación de tiempo en escritura de T-SQL |
| Lab 4 | Administración DBA | Diagnóstico en segundos, no minutos |
| Lab 5 | Custom Instructions | Estandarización automática del equipo |

---

## 🏁 Cierre del Demo (para el presentador)

> "GitHub Copilot en SSMS no es una herramienta para reemplazar DBAs — es para que cada DBA trabaje como si tuviera un colega senior siempre disponible, que conoce tu esquema, tus estándares y los patrones más comunes de administración. El resultado: menos tiempo en tareas repetitivas, más tiempo en decisiones de alto valor."

**Próximos pasos sugeridos:**
1. Instalar SSMS 22.4.1 y activar el plan gratuito de GitHub Copilot
2. Crear el `copilot-instructions.md` con los estándares del equipo
3. Hacer un piloto de 2 semanas con 2-3 DBAs y medir el tiempo en tareas clave

---

> 📚 **Recurso adicional:** [Mejores prácticas para prompts en SSMS (docs oficiales)](https://learn.microsoft.com/es-es/ssms/github-copilot/best-practices)

---

⬅️ [Lab 4 — Administración DBA](lab_04_dba_admin.md) | 🏠 [Volver al Inicio](../README.md)
