# Lab 1 — Primer Contacto con GitHub Copilot en SSMS

**⏱️ Duración:** ~5 minutos  
**🎯 Objetivo:** Conocer la interfaz, entender los dos modos de interacción y hacer el primer prompt.

---

## 🧠 Concepto Clave (para el presentador)

> "GitHub Copilot en SSMS no es un simple autocompletador de código. Es un asistente conversacional que entiende el contexto de tu base de datos. Piensa en él como tener un DBA senior al lado que conoce tu esquema."

Este lab cubre los dos modos de interacción:
1. **Chat lateral (sidecar)** — conversación continua con contexto de la BD
2. **Inline Chat** — asistencia directa mientras escribes en el editor

---

## Paso 1 — Conectar el Query Editor a AdventureWorks

Antes de abrir Copilot, **conecta el Query Editor a AdventureWorks**. Copilot toma el contexto de la conexión activa.

1. Abre un nuevo Query Editor (`Ctrl + N`)
2. En la barra de conexión, selecciona tu servidor
3. Cambia la base de datos a `AdventureWorks2022`

> ⚠️ **Error común:** Si el Query Editor está conectado a `master`, Copilot no tendrá contexto de tus tablas de negocio. Siempre verifica la BD activa.

---

## Paso 2 — Abrir el Chat de Copilot

**Opción A (botón):**
- Clic en el ícono de Copilot (estrella ⭐) en la esquina superior derecha
- Selecciona **Open Chat Window**

**Opción B (menú):**
- `View > GitHub Copilot Chat`

**Opción C (teclado):**
- No hay shortcut por defecto, pero puedes configurarlo en `Tools > Options > Keyboard`

Deberías ver el panel de chat abrirse en el lateral derecho de SSMS.

---

## Paso 3 — El Primer Prompt

Escribe este prompt en el chat y presiona Enter:

```
¿Qué versión de SQL Server estoy usando y cuál es el modo de compatibilidad de esta base de datos?
```

**Qué esperar:** Copilot ejecuta una consulta sobre la conexión activa y responde con la versión del servidor y el `compatibility_level` de AdventureWorks.

> 💡 **Para el presentador:** Muestra al público que Copilot no solo responde con texto — puede ejecutar queries en tu nombre y mostrar los resultados. Aquí está el "momento wow" #1.

---

## Paso 4 — Explorar la Interfaz

Señala los elementos del panel de chat:

| Elemento | Descripción |
|----------|-------------|
| **Selector de modelo** | Puedes cambiar el modelo de IA (GPT-4o, Claude, etc.) |
| **Nueva conversación** | Inicia un thread limpio (ícono de lápiz) |
| **Área de chat** | Historial de la conversación actual |
| **Campo de texto** | Donde escribes tus prompts |
| **Slash commands** | Escribe `/` para ver comandos disponibles |

---

## Paso 5 — Inline Chat (bonus)

Escribe esta query en el editor:

```sql
SELECT * FROM Sales.SalesOrderHeader
```

Con el cursor sobre la query, presiona **`Alt + /`** para abrir el inline chat y escribe:

```
¿Qué hace esta query y cómo podría mejorarla?
```

> 💡 **Para el presentador:** El inline chat es útil cuando ya tienes código escrito y quieres asistencia contextual sin salir del editor.

---

## ✅ Resumen del Lab 1

- ✔️ Copilot requiere conexión activa del Query Editor para tener contexto de BD
- ✔️ Hay dos modos: **Chat lateral** (conversacional) e **Inline Chat** (contextual en el editor)
- ✔️ El primer prompt ya te da información del servidor sin escribir T-SQL

**➡️ Siguiente: [Lab 2 — Exploración del Esquema](lab_02_exploracion_schema.md)**
