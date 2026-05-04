-- ============================================================
-- Script: diagnostico_bloqueos.sql
-- Descripción: Diagnóstico de bloqueos activos en SQL Server
-- Rol en el repo: SOLUCIÓN DE REFERENCIA
-- → Genera tu propia versión en Lab 4 (Ejercicio 4.1) con Copilot y compara.
-- ============================================================

-- -----------------------------------------------
-- 1. Ver bloqueos activos (sesión bloqueadora vs bloqueada)
-- -----------------------------------------------
SELECT 
    r.session_id                                        AS SesionBloqueada,
    r.blocking_session_id                               AS SesionBloqueadora,
    r.wait_type                                         AS TipoEspera,
    r.wait_time / 1000                                  AS EsperaSegundos,
    r.status                                            AS EstadoSesion,
    DB_NAME(r.database_id)                              AS BaseDeDatos,
    SUBSTRING(t.text, (r.statement_start_offset/2)+1,
        ((CASE r.statement_end_offset 
            WHEN -1 THEN DATALENGTH(t.text) 
            ELSE r.statement_end_offset 
          END - r.statement_start_offset)/2)+1)         AS QueryBloqueada,
    s.login_name                                        AS Usuario,
    s.host_name                                         AS Servidor,
    s.program_name                                      AS Aplicacion
FROM sys.dm_exec_requests r
JOIN sys.dm_exec_sessions s   ON r.session_id = s.session_id
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) t
WHERE r.blocking_session_id > 0
ORDER BY r.wait_time DESC;

-- -----------------------------------------------
-- 2. Ver la query que está CAUSANDO el bloqueo
-- -----------------------------------------------
SELECT 
    s.session_id                                        AS SesionBloqueadora,
    s.login_name                                        AS Usuario,
    s.host_name                                         AS Servidor,
    s.program_name                                      AS Aplicacion,
    s.last_request_start_time                           AS InicioUltimaQuery,
    SUBSTRING(t.text, 1, 500)                           AS TextoQuery
FROM sys.dm_exec_sessions s
CROSS APPLY sys.dm_exec_sql_text(s.most_recent_sql_handle) t
WHERE s.session_id IN (
    SELECT DISTINCT blocking_session_id 
    FROM sys.dm_exec_requests 
    WHERE blocking_session_id > 0
);

-- -----------------------------------------------
-- 3. Resumen de bloqueos en tiempo real
-- -----------------------------------------------
SELECT 
    COUNT(*) AS TotalSesionesBloqueadas,
    MAX(wait_time) / 1000 AS MaxEsperaSegundos,
    AVG(wait_time) / 1000 AS PromedioEsperaSegundos
FROM sys.dm_exec_requests
WHERE blocking_session_id > 0;
