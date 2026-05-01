-- ============================================================
-- Script: backup_automatizado.sql
-- Descripción: Estrategia de backup con RPO de 1 hora
--              Full backup diario + Log backup cada 30 minutos
-- Generado con asistencia de GitHub Copilot en SSMS
-- ⚠️  Revisar y ajustar rutas y nombres antes de ejecutar
-- Repo: copilot-ssms-demo
-- ============================================================

-- -----------------------------------------------
-- PASO 1: Verificar el modelo de recuperación
-- (debe ser FULL para habilitar log backups)
-- -----------------------------------------------
SELECT 
    name                AS BaseDeDatos,
    recovery_model_desc AS ModeloRecuperacion,
    log_reuse_wait_desc AS EsperaReusoLog
FROM sys.databases
WHERE name = DB_NAME();

-- Si el modelo NO es FULL, ejecuta:
-- ALTER DATABASE AdventureWorks2022 SET RECOVERY FULL;

-- -----------------------------------------------
-- PASO 2: Crear carpeta de backups (ejecutar en PowerShell)
-- -----------------------------------------------
-- New-Item -ItemType Directory -Path "C:\SQLBackups\AdventureWorks" -Force

-- -----------------------------------------------
-- PASO 3: Job 1 — Full Backup diario (1:00 AM)
-- -----------------------------------------------
USE msdb;
GO

EXEC sp_add_job 
    @job_name = N'AdventureWorks - Full Backup Diario';

EXEC sp_add_jobstep 
    @job_name = N'AdventureWorks - Full Backup Diario',
    @step_name = N'Ejecutar Full Backup',
    @command = N'
DECLARE @BackupPath NVARCHAR(500);
DECLARE @BackupFile NVARCHAR(500);

SET @BackupPath = N''C:\SQLBackups\AdventureWorks\'';
SET @BackupFile = @BackupPath + N''Full_'' + 
    REPLACE(REPLACE(CONVERT(NVARCHAR, GETDATE(), 120), '':'', ''-''), '' '', ''_'') + 
    N''.bak'';

BACKUP DATABASE [AdventureWorks2022]
TO DISK = @BackupFile
WITH 
    COMPRESSION,
    CHECKSUM,
    STATS = 10,
    DESCRIPTION = N''Full Backup Automático'';

PRINT ''Full Backup completado: '' + @BackupFile;
';

EXEC sp_add_schedule
    @schedule_name = N'Diario 1AM',
    @freq_type = 4,         -- Diario
    @freq_interval = 1,
    @active_start_time = 010000;  -- 01:00 AM

EXEC sp_attach_schedule
    @job_name = N'AdventureWorks - Full Backup Diario',
    @schedule_name = N'Diario 1AM';

EXEC sp_add_jobserver
    @job_name = N'AdventureWorks - Full Backup Diario';

GO

-- -----------------------------------------------
-- PASO 4: Job 2 — Log Backup cada 30 minutos
-- -----------------------------------------------
EXEC sp_add_job 
    @job_name = N'AdventureWorks - Log Backup 30min';

EXEC sp_add_jobstep 
    @job_name = N'AdventureWorks - Log Backup 30min',
    @step_name = N'Ejecutar Log Backup',
    @command = N'
DECLARE @BackupPath NVARCHAR(500);
DECLARE @BackupFile NVARCHAR(500);

SET @BackupPath = N''C:\SQLBackups\AdventureWorks\'';
SET @BackupFile = @BackupPath + N''Log_'' + 
    REPLACE(REPLACE(CONVERT(NVARCHAR, GETDATE(), 120), '':'', ''-''), '' '', ''_'') + 
    N''.trn'';

BACKUP LOG [AdventureWorks2022]
TO DISK = @BackupFile
WITH 
    COMPRESSION,
    CHECKSUM,
    STATS = 10;

PRINT ''Log Backup completado: '' + @BackupFile;
';

EXEC sp_add_schedule
    @schedule_name = N'Cada 30 Minutos',
    @freq_type = 4,         -- Diario
    @freq_interval = 1,
    @freq_subday_type = 4,  -- Minutos
    @freq_subday_interval = 30;

EXEC sp_attach_schedule
    @job_name = N'AdventureWorks - Log Backup 30min',
    @schedule_name = N'Cada 30 Minutos';

EXEC sp_add_jobserver
    @job_name = N'AdventureWorks - Log Backup 30min';

GO

-- -----------------------------------------------
-- PASO 5: Verificar los jobs creados
-- -----------------------------------------------
SELECT 
    j.name          AS NombreJob,
    j.enabled       AS Habilitado,
    s.name          AS NombreSchedule,
    s.freq_type,
    s.freq_subday_interval
FROM msdb.dbo.sysjobs j
JOIN msdb.dbo.sysjobschedules js ON j.job_id = js.job_id
JOIN msdb.dbo.sysschedules s     ON js.schedule_id = s.schedule_id
WHERE j.name LIKE N'AdventureWorks%'
ORDER BY j.name;
