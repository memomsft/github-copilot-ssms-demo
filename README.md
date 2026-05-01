# 🤖 GitHub Copilot en SSMS — Demo para DBAs

> **Demo replicable | AdventureWorks | SSMS 22.4.1 | Español**

Este repositorio contiene una guía práctica y didáctica para demostrar cómo **GitHub Copilot en SQL Server Management Studio (SSMS)** acelera el flujo de trabajo de un DBA, desde la exploración del esquema hasta diagnósticos de rendimiento y administración, todo usando lenguaje natural.

---

## 🎯 Objetivo del Demo

Mostrar, con ejercicios replicables paso a paso, que un DBA puede:

- Explorar esquemas y entornos de forma conversacional
- Generar T-SQL complejo desde lenguaje natural (NL2SQL)
- Diagnosticar problemas de rendimiento y bloqueos en segundos
- Automatizar tareas repetitivas de administración
- Estandarizar prácticas del equipo con instrucciones personalizadas

**Mensaje clave:** *"Copilot no reemplaza al DBA — amplifica su capacidad. Lo que antes tomaba 30 minutos, ahora toma 30 segundos."*

---

## 👥 Audiencia

| Perfil | Qué verá en el demo |
|--------|---------------------|
| **DBA / Técnico** | Slash commands, multi-turn, NL2SQL avanzado, custom instructions |
| **Decisor / Manager** | Reducción de tiempo en diagnóstico, onboarding acelerado, estandarización |

---

## 🗂️ Estructura del Repositorio

```
copilot-ssms-demo/
├── README.md                    ← Este archivo
├── setup/
│   ├── 00_prerequisitos.md      ← Qué necesitas antes de empezar
│   └── 01_adventureworks.md     ← Cómo instalar AdventureWorks
├── labs/
│   ├── lab_01_primer_contacto.md      ← Configuración e interfaz
│   ├── lab_02_exploracion_schema.md   ← Explorar la BD con lenguaje natural
│   ├── lab_03_nl2sql.md               ← NL a T-SQL + slash commands
│   ├── lab_04_dba_admin.md            ← Diagnóstico y administración
│   └── lab_05_custom_instructions.md  ← Instrucciones personalizadas
└── scripts/
    ├── diagnostico_bloqueos.sql
    ├── performance_queries.sql
    └── backup_automatizado.sql
```

---

## ⚡ Requisitos

- **SSMS 22.4.1** o superior ([Descargar](https://learn.microsoft.com/es-es/ssms/download-sql-server-management-studio-ssms))
- **Cuenta GitHub** con Copilot activo (hay plan gratuito disponible)
- **Base de datos AdventureWorks** restaurada en SQL Server local o Azure SQL
- Workload **AI Assistance** instalado (ver `setup/00_prerequisitos.md`)

---

## 🚀 Flujo del Demo (resumen ejecutivo)

```
Lab 1 → Instalar y conectar Copilot          (~5 min)
Lab 2 → Explorar esquema con chat natural    (~10 min)
Lab 3 → Generar T-SQL complejo + optimizar   (~15 min)
Lab 4 → Tareas DBA: bloqueos, performance    (~10 min)
Lab 5 → Custom instructions del equipo       (~5 min)
```

**Tiempo total estimado: ~45 minutos**

---

## 📚 Referencias Oficiales

- [Documentación oficial — GitHub Copilot en SSMS](https://learn.microsoft.com/es-es/ssms/github-copilot/get-started)
- [Escenarios de uso documentados por Microsoft](https://learn.microsoft.com/es-es/ssms/github-copilot/scenarios)
- [Mejores prácticas para prompts en SSMS](https://learn.microsoft.com/es-es/ssms/github-copilot/best-practices)
- [GitHub Copilot Trust Center (privacidad y datos)](https://copilot.github.trust.page/faq)

---

## ⚠️ Limitaciones Importantes (validadas en docs oficiales)

| Limitación | Detalle |
|------------|---------|
| **No Agent Mode aún** | No ejecuta comandos destructivos (DELETE, DROP). En roadmap. |
| **No lee el editor directamente** | No detecta texto seleccionado; usa el chat o inline chat |
| **No exporta el historial** | El chat no se puede exportar actualmente |
| **Respeta permisos del login** | Si tu usuario no tiene SELECT en una tabla, Copilot tampoco |
| **Puede generar errores** | Siempre revisar los scripts antes de ejecutar en producción |

---

> 💡 **Nota de privacidad:** GitHub Copilot en SSMS **no retiene tus prompts ni datos** y no los usa para reentrenar modelos. Ver [GitHub Copilot Trust Center](https://copilot.github.trust.page/faq).
