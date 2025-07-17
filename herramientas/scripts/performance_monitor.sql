-- =====================================================
-- SCRIPT DE MONITOREO DE RENDIMIENTO
-- =====================================================
-- Este script proporciona análisis completo del rendimiento
-- de la base de datos incluyendo consultas lentas, uso de recursos
-- y estadísticas de tablas.

-- =====================================================
-- 1. CONSULTAS LENTAS Y PROBLEMÁTICAS
-- =====================================================

-- Consultas más lentas (MySQL)
SELECT 
    query_time,
    lock_time,
    rows_sent,
    rows_examined,
    db,
    sql_text
FROM mysql.slow_log 
WHERE start_time >= DATE_SUB(NOW(), INTERVAL 1 DAY)
ORDER BY query_time DESC 
LIMIT 10;

-- Consultas con mayor uso de CPU
SELECT 
    sql_text,
    exec_count,
    total_latency,
    avg_latency,
    lock_latency,
    rows_sent,
    rows_examined,
    tmp_tables,
    tmp_disk_tables
FROM sys.x$statement_analysis 
ORDER BY total_latency DESC 
LIMIT 20;

-- =====================================================
-- 2. ANÁLISIS DE ÍNDICES
-- =====================================================

-- Índices no utilizados
SELECT 
    object_schema,
    object_name,
    index_name
FROM sys.schema_unused_indexes
ORDER BY object_schema, object_name;

-- Índices duplicados o redundantes
SELECT 
    table_schema,
    table_name,
    redundant_index_name,
    redundant_index_columns,
    dominant_index_name,
    dominant_index_columns
FROM sys.schema_redundant_indexes;

-- Estadísticas de uso de índices
SELECT 
    object_schema,
    object_name,
    index_name,
    count_read,
    count_write,
    count_read + count_write as total_usage
FROM sys.schema_index_statistics 
WHERE object_schema NOT IN ('mysql', 'sys', 'information_schema', 'performance_schema')
ORDER BY total_usage DESC;

-- =====================================================
-- 3. ANÁLISIS DE TABLAS
-- =====================================================

-- Tablas más grandes por tamaño
SELECT 
    table_schema,
    table_name,
    ROUND(((data_length + index_length) / 1024 / 1024), 2) as size_mb,
    table_rows,
    ROUND((data_length / 1024 / 1024), 2) as data_mb,
    ROUND((index_length / 1024 / 1024), 2) as index_mb
FROM information_schema.tables 
WHERE table_schema NOT IN ('mysql', 'sys', 'information_schema', 'performance_schema')
ORDER BY (data_length + index_length) DESC 
LIMIT 20;

-- Tablas con más actividad de lectura/escritura
SELECT 
    object_schema,
    object_name,
    count_read,
    count_write,
    count_read + count_write as total_io
FROM sys.schema_table_statistics 
WHERE object_schema NOT IN ('mysql', 'sys', 'information_schema', 'performance_schema')
ORDER BY total_io DESC 
LIMIT 15;

-- Fragmentación de tablas
SELECT 
    table_schema,
    table_name,
    ROUND((data_free / 1024 / 1024), 2) as fragmented_mb,
    ROUND((data_free / (data_length + index_length + data_free)) * 100, 2) as fragmentation_pct
FROM information_schema.tables 
WHERE table_schema NOT IN ('mysql', 'sys', 'information_schema', 'performance_schema')
    AND data_free > 0
ORDER BY fragmented_mb DESC;

-- =====================================================
-- 4. MONITOREO DE CONEXIONES
-- =====================================================

-- Conexiones activas por usuario
SELECT 
    user,
    host,
    db,
    command,
    time,
    state,
    info
FROM information_schema.processlist 
WHERE command != 'Sleep'
ORDER BY time DESC;

-- Estadísticas de conexiones
SELECT 
    user,
    total_connections,
    current_connections,
    unique_hosts
FROM sys.user_summary
ORDER BY total_connections DESC;

-- Conexiones por host
SELECT 
    host,
    current_connections,
    total_connections
FROM sys.host_summary
ORDER BY current_connections DESC;

-- =====================================================
-- 5. USO DE MEMORIA Y RECURSOS
-- =====================================================

-- Uso de memoria por usuario
SELECT 
    user,
    current_allocated,
    current_avg_alloc,
    current_max_alloc,
    total_allocated
FROM sys.user_summary_by_memory_usage
ORDER BY current_allocated DESC;

-- Uso de memoria por statement
SELECT 
    query,
    exec_count,
    total_latency,
    memory_tmp_tables,
    memory_tmp_disk_tables,
    avg_memory_tmp_table_size
FROM sys.x$statement_analysis
WHERE memory_tmp_tables > 0 OR memory_tmp_disk_tables > 0
ORDER BY memory_tmp_disk_tables DESC, memory_tmp_tables DESC;

-- =====================================================
-- 6. ANÁLISIS DE LOCKS Y BLOQUEOS
-- =====================================================

-- Bloqueos actuales
SELECT 
    r.trx_id waiting_trx_id,
    r.trx_mysql_thread_id waiting_thread,
    r.trx_query waiting_query,
    b.trx_id blocking_trx_id,
    b.trx_mysql_thread_id blocking_thread,
    b.trx_query blocking_query
FROM information_schema.innodb_lock_waits w
INNER JOIN information_schema.innodb_trx b ON b.trx_id = w.blocking_trx_id
INNER JOIN information_schema.innodb_trx r ON r.trx_id = w.requesting_trx_id;

-- Estadísticas de locks por tabla
SELECT 
    object_schema,
    object_name,
    count_read_with_shared_locks,
    count_read_high_priority,
    count_read_no_insert,
    count_write_allow_write,
    count_write_concurrent_insert,
    count_write_low_priority
FROM sys.schema_table_lock_waits
ORDER BY (count_read_with_shared_locks + count_write_allow_write) DESC;

-- =====================================================
-- 7. ESTADÍSTICAS DE RENDIMIENTO GENERAL
-- =====================================================

-- Variables de estado importantes
SELECT 
    variable_name,
    variable_value
FROM information_schema.global_status 
WHERE variable_name IN (
    'Threads_connected',
    'Threads_running',
    'Questions',
    'Queries',
    'Slow_queries',
    'Opens',
    'Open_tables',
    'Qcache_hits',
    'Qcache_inserts',
    'Qcache_not_cached',
    'Created_tmp_tables',
    'Created_tmp_disk_tables',
    'Sort_merge_passes',
    'Table_locks_waited',
    'Innodb_buffer_pool_read_requests',
    'Innodb_buffer_pool_reads'
);

-- Ratio de hit del buffer pool
SELECT 
    ROUND(
        (1 - (
            (SELECT variable_value FROM information_schema.global_status WHERE variable_name = 'Innodb_buffer_pool_reads') /
            (SELECT variable_value FROM information_schema.global_status WHERE variable_name = 'Innodb_buffer_pool_read_requests')
        )) * 100, 2
    ) as buffer_pool_hit_ratio_pct;

-- =====================================================
-- 8. RECOMENDACIONES AUTOMÁTICAS
-- =====================================================

-- Tablas que necesitan optimización
SELECT 
    CONCAT(table_schema, '.', table_name) as tabla,
    CASE 
        WHEN data_free > (data_length * 0.1) THEN 'OPTIMIZE TABLE recomendado'
        WHEN (index_length / data_length) > 1.5 THEN 'Revisar índices excesivos'
        WHEN table_rows > 1000000 AND index_length < (data_length * 0.1) THEN 'Considerar más índices'
        ELSE 'OK'
    END as recomendacion,
    ROUND((data_length / 1024 / 1024), 2) as data_mb,
    ROUND((index_length / 1024 / 1024), 2) as index_mb,
    ROUND((data_free / 1024 / 1024), 2) as fragmented_mb
FROM information_schema.tables 
WHERE table_schema NOT IN ('mysql', 'sys', 'information_schema', 'performance_schema')
    AND table_type = 'BASE TABLE'
HAVING recomendacion != 'OK'
ORDER BY fragmented_mb DESC;

-- Consultas que necesitan optimización
SELECT 
    LEFT(digest_text, 100) as query_preview,
    exec_count,
    ROUND(avg_timer_wait / 1000000000, 3) as avg_time_seconds,
    ROUND(sum_timer_wait / 1000000000, 3) as total_time_seconds,
    CASE 
        WHEN avg_timer_wait > 5000000000 THEN 'CRÍTICO: Optimizar inmediatamente'
        WHEN avg_timer_wait > 1000000000 THEN 'ALTO: Revisar y optimizar'
        WHEN avg_timer_wait > 500000000 THEN 'MEDIO: Considerar optimización'
        ELSE 'BAJO: Monitorear'
    END as prioridad
FROM performance_schema.events_statements_summary_by_digest
WHERE schema_name NOT IN ('mysql', 'sys', 'information_schema', 'performance_schema')
    AND exec_count > 10
ORDER BY avg_timer_wait DESC
LIMIT 20;

-- =====================================================
-- 9. SCRIPT DE LIMPIEZA Y MANTENIMIENTO
-- =====================================================

-- Comandos de mantenimiento (ejecutar con precaución)
/*
-- Limpiar logs de consultas lentas
TRUNCATE TABLE mysql.slow_log;

-- Optimizar tablas fragmentadas
-- (Generar comandos OPTIMIZE TABLE para tablas fragmentadas)
SELECT CONCAT('OPTIMIZE TABLE ', table_schema, '.', table_name, ';') as optimize_commands
FROM information_schema.tables 
WHERE table_schema NOT IN ('mysql', 'sys', 'information_schema', 'performance_schema')
    AND data_free > (data_length * 0.1)
    AND data_free > 100 * 1024 * 1024; -- Solo si fragmentación > 100MB

-- Actualizar estadísticas de tablas
-- ANALYZE TABLE schema.table_name;

-- Reconstruir índices si es necesario
-- ALTER TABLE schema.table_name ENGINE=InnoDB;
*/

-- =====================================================
-- 10. MONITOREO EN TIEMPO REAL
-- =====================================================

-- Query para monitoreo continuo (ejecutar cada 30 segundos)
SELECT 
    NOW() as timestamp,
    (SELECT variable_value FROM information_schema.global_status WHERE variable_name = 'Threads_connected') as connections,
    (SELECT variable_value FROM information_schema.global_status WHERE variable_name = 'Threads_running') as running_threads,
    (SELECT COUNT(*) FROM information_schema.processlist WHERE command != 'Sleep') as active_queries,
    (SELECT variable_value FROM information_schema.global_status WHERE variable_name = 'Queries') as total_queries,
    ROUND(
        (SELECT variable_value FROM information_schema.global_status WHERE variable_name = 'Innodb_buffer_pool_read_requests') /
        (SELECT variable_value FROM information_schema.global_status WHERE variable_name = 'Uptime'), 2
    ) as reads_per_second;

-- =====================================================
-- NOTAS DE USO
-- =====================================================
/*
INSTRUCCIONES:
1. Ejecutar secciones según necesidad de análisis
2. Algunas consultas requieren privilegios de SUPER o PROCESS
3. Para MySQL 8.0+, usar sys schema para mejores insights
4. Ejecutar durante horas de menor carga para análisis completo
5. Guardar resultados para comparación histórica

FRECUENCIA RECOMENDADA:
- Consultas lentas: Diario
- Análisis de índices: Semanal
- Estadísticas de tablas: Semanal
- Monitoreo de conexiones: Tiempo real
- Análisis completo: Mensual

ALERTAS SUGERIDAS:
- Consultas > 5 segundos promedio
- Fragmentación > 20%
- Conexiones > 80% del máximo
- Buffer pool hit ratio < 95%
- Tablas sin índices con > 100K registros
*/

