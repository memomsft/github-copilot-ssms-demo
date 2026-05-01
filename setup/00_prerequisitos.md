# 🛠️ Setup — Prerrequisitos

Antes de ejecutar cualquier lab, asegúrate de tener todo configurado correctamente.

---

## 1. Versión de SSMS

GitHub Copilot **requiere SSMS 22 o superior**. La versión GA actual es **22.4.1**.

Verifica tu versión: `Help > About Microsoft SQL Server Management Studio`

📥 [Descargar SSMS 22](https://learn.microsoft.com/es-es/ssms/download-sql-server-management-studio-ssms)

---

## 2. Instalar el Workload de AI Assistance

Copilot no viene activo por defecto. Se instala como un workload adicional:

1. Abre el **Visual Studio Installer**
   - Búscalo en el menú de inicio como "Visual Studio Installer"
2. Encuentra tu instalación de SSMS 22 y selecciona **Modify**
3. En la pestaña **Workloads**, marca **AI Assistance**
4. Haz clic en **Modify** para instalar
5. Reinicia SSMS

> 💡 Si no tienes el Visual Studio Installer, también puedes hacer clic en el badge de Copilot en la esquina superior derecha de SSMS y seleccionar **Install Copilot**.

---

## 3. Cuenta GitHub con Copilot

Necesitas una cuenta de GitHub con acceso a Copilot.

### Opción A — Plan Gratuito (recomendado para el demo)
- Ve a [github.com/features/copilot](https://github.com/features/copilot)
- Selecciona **Get Copilot for free**
- El plan gratuito incluye 2,000 completions/mes y 50 mensajes de chat

### Opción B — Plan Individual/Business
- Requiere suscripción de pago en GitHub

---

## 4. Conectar tu cuenta GitHub en SSMS

1. Abre SSMS
2. En la esquina superior derecha, haz clic en el **badge de Copilot** (ícono de estrella)
3. Selecciona **Open Chat Window to Sign In**
4. Sigue el flujo de autenticación en el navegador
5. Regresa a SSMS — el badge debe mostrar ícono verde (activo)

---

## 5. Verificar la conexión

Una vez configurado, el ícono de Copilot en la esquina superior derecha de SSMS debe verse en **verde** (activo).

Si aparece en rojo o gris, revisa:
- ¿Tu cuenta GitHub tiene Copilot activo?
- ¿Instalaste el workload AI Assistance?
- ¿Estás conectado a internet?

---

## ✅ Checklist antes del demo

- [ ] SSMS 22.4.1 instalado
- [ ] Workload AI Assistance instalado
- [ ] Cuenta GitHub conectada en SSMS (badge verde)
- [ ] AdventureWorks restaurada (ver `01_adventureworks.md`)
- [ ] Query Editor conectado a `AdventureWorks` (no a `master`)
