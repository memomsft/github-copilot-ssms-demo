-- ============================================================
-- Script: performance_queries.sql
-- Descripción: Análisis de performance — queries lentas, índices
--              y wait stats
-- Rol en el repo: SOLUCIÓN DE REFERENCIA
-- → Genera tu propia versión en Lab 4 (Ejercicio 4.2) con Copilot y compara.
-- ============================================================

-- -----------------------------------------------
-- 1. Top 10 queries por tiempo de CPU (últimas ejecuciones)
-- -----------------------------------------------
SELECT TOP 10
    qs.total_worker_time / qs.execution_count / 1000   AS PromCPU_ms,
    qs.total_elapsed_time / qs.execution_count / 1000  AS PromDuracion_ms,
    qs.execution_count                                  AS NumEjecuciones,
    qs.total_logical_reads / qs.execution_count        AS PromLecturas,
    SUBSTRING(qt.text, (qs.statement_start_offset/2)+1,
        ((CASE qs.statement_end_offset 
            WHEN -1 THEN DATALENGTH(qt.text) 
            ELSE qs.statement_end_offset 
          END - qs.statement_start_offset)/2)+1)        AS TextoQuery,
    DB_NAME(qt.dbid)                                    AS BaseDeDatos
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) qt
WHERE qs.last_execution_time > DATEADD(HOUR, -2, GETDATE())
ORDER BY PromCPU_ms DESC;

-- -----------------------------------------------
-- 2. Índices que no se han usado (candidatos a eliminar)
-- -----------------------------------------------
SELECT 
    OBJECT_NAME(i.object_id)        AS Tabla,
    i.name                          AS NombreIndice,
    i.type_desc                     AS TipoIndice,
    ius.user_seeks                  AS Busquedas,
    ius.user_scans                  AS Escaneos,
    ius.user_lookups                AS Lookups,
    ius.user_updates                AS Actualizaciones,
    ius.last_user_seek              AS UltimaBusqueda,
    ius.last_user_scan              AS UltimoEscaneo
FROM sys.indexes i
LEFT JOIN sys.dm_db_index_usage_stats ius 
    ON i.object_id = ius.object_id 
    AND i.index_id = ius.index_id 
    AND ius.database_id = DB_ID()
WHERE i.type > 0  -- Excluye heap
    AND OBJECT_NAME(i.object_id) NOT LIKE 'sys%'
    AND (ius.user_seeks IS NULL OR ius.user_seeks = 0)
    AND (ius.user_scans IS NULL OR ius.user_scans = 0)
    AND (ius.user_lookups IS NULL OR ius.user_lookups = 0)
ORDER BY ius.user_updates DESC NULLS LAST;

-- -----------------------------------------------
-- 3. Wait Stats — Tiempos de espera del servidor
-- -----------------------------------------------
SELECT TOP 10
    wait_type                                           AS TipoEspera,
    waiting_tasks_count                                 AS TareasEnEspera,
    wait_time_ms / 1000                                 AS TiempoEspera_seg,
    max_wait_time_ms / 1000                             AS MaxEspera_seg,
    CAST(100.0 * wait_time_ms / 
        SUM(wait_time_ms) OVER ()  AS DECIMAL(5,2))    AS PorcentajeTotal
FROM sys.dm_os_wait_stats
WHERE wait_type NOT IN (  -- Excluir waits normales de sistema
    'SLEEP_TASK', 'BROKER_TO_FLUSH', 'BROKER_TASK_STOP',
    'CLR_AUTO_EVENT', 'DISPATCHER_QUEUE_SEMAPHORE',
    'FT_IFTS_SCHEDULER_IDLE_WAIT', 'HADR_WORK_QUEUE',
    'LOGMGR_QUEUE', 'REQUEST_FOR_DEADLOCK_SEARCH',
    'RESOURCE_QUEUE', 'SERVER_IDLE_CHECK', 'SLEEP_DBSTARTUP',
    'SLEEP_DCOMSTARTUP', 'SLEEP_MASTERDBREADY', 'SLEEP_MASTERMDREADY',
    'SLEEP_MASTERUPGRADED', 'SLEEP_MSDBSTARTUP', 'SLEEP_SYSTEMTASK',
    'SLEEP_TEMPDBSTARTUP', 'SNI_HTTP_ACCEPT', 'SP_SERVER_DIAGNOSTICS_SLEEP',
    'SQLTRACE_BUFFER_FLUSH', 'WAITFOR', 'XE_DISPATCHER_WAIT', 'XE_TIMER_EVENT'
)
ORDER BY wait_time_ms DESC;

-- -----------------------------------------------
-- 4. Espacio en archivos de la base de datos
-- -----------------------------------------------
SELECT 
    name                            AS NombreArchivo,
    type_desc                       AS TipoArchivo,
    physical_name                   AS RutaFisica,
    size * 8 / 1024                 AS TamañoMB,
    FILEPROPERTY(name, 'SpaceUsed') * 8 / 1024 AS UsoMB,
    (size - FILEPROPERTY(name, 'SpaceUsed')) * 8 / 1024 AS EspacioLibreMB,
    CAST(100.0 * FILEPROPERTY(name, 'SpaceUsed') / size AS DECIMAL(5,2)) AS PorcentajeUso
FROM sys.database_files
ORDER BY type, name;
