# 🛠️ Herramientas SQL

Colección de scripts y utilidades para mejorar tu productividad trabajando con bases de datos.

## 📜 [Scripts](./scripts/)

Scripts automatizados para tareas comunes de administración:

### 🔧 Mantenimiento de Base de Datos
- **backup_database.sql** - Scripts de respaldo automatizado
- **cleanup_logs.sql** - Limpieza de logs y archivos temporales
- **index_analysis.sql** - Análisis y optimización de índices
- **table_statistics.sql** - Estadísticas detalladas de tablas

### 📊 Monitoreo y Diagnóstico
- **performance_monitor.sql** - Monitoreo de rendimiento en tiempo real
- **slow_queries.sql** - Identificación de consultas lentas
- **connection_monitor.sql** - Monitoreo de conexiones activas
- **space_usage.sql** - Análisis de uso de espacio en disco

### 🔄 Migración y Sincronización
- **schema_compare.sql** - Comparación de esquemas entre entornos
- **data_migration.sql** - Scripts de migración de datos
- **sync_tables.sql** - Sincronización de tablas entre bases de datos
- **version_control.sql** - Control de versiones de esquemas

### 🛡️ Seguridad y Auditoría
- **user_audit.sql** - Auditoría de usuarios y permisos
- **security_check.sql** - Verificación de configuraciones de seguridad
- **access_log.sql** - Análisis de logs de acceso
- **permission_report.sql** - Reportes de permisos por usuario

## ⚡ [Utilidades](./utilidades/)

Herramientas de productividad y automatización:

### 🎯 Generadores de Código
- **table_generator.py** - Generador automático de tablas
- **query_builder.py** - Constructor visual de consultas
- **test_data_generator.py** - Generador de datos de prueba
- **documentation_generator.py** - Generador de documentación automática

### 📈 Análisis y Reportes
- **query_analyzer.py** - Analizador de rendimiento de consultas
- **schema_visualizer.py** - Visualizador de esquemas de base de datos
- **data_profiler.py** - Perfilador de calidad de datos
- **report_generator.py** - Generador de reportes automáticos

### 🔄 Automatización
- **batch_processor.py** - Procesador de consultas en lote
- **scheduler.py** - Programador de tareas SQL
- **config_manager.py** - Gestor de configuraciones
- **deployment_tool.py** - Herramienta de despliegue automático

### 🧪 Testing y Validación
- **unit_tester.py** - Framework de pruebas unitarias para SQL
- **data_validator.py** - Validador de integridad de datos
- **performance_tester.py** - Tester de rendimiento automatizado
- **regression_tester.py** - Tester de regresión para cambios

## 🚀 Inicio Rápido

### Instalación
```bash
# Clonar el repositorio
git clone https://github.com/tu-usuario/sql-repository.git
cd sql-repository/herramientas

# Instalar dependencias de Python (para utilidades)
pip install -r requirements.txt
```

### Uso de Scripts SQL
```sql
-- Ejecutar directamente en tu cliente SQL
SOURCE scripts/backup_database.sql;

-- O copiar y pegar el contenido según necesites
```

### Uso de Utilidades Python
```bash
# Ejemplo: Generar datos de prueba
python utilidades/test_data_generator.py --table usuarios --rows 1000

# Ejemplo: Analizar rendimiento
python utilidades/query_analyzer.py --query "SELECT * FROM ventas WHERE fecha > '2023-01-01'"
```

## 📋 Configuración

### Prerrequisitos
- **Para Scripts**: Cliente SQL compatible
- **Para Utilidades**: Python 3.7+ y dependencias listadas

### Variables de Entorno
```bash
# Configurar conexión a base de datos
export DB_HOST=localhost
export DB_PORT=3306
export DB_USER=tu_usuario
export DB_PASSWORD=tu_password
export DB_NAME=tu_base_datos
```

### Archivo de Configuración
```yaml
# config.yaml
database:
  host: localhost
  port: 3306
  user: admin
  password: password
  name: production_db

settings:
  backup_path: /backups/
  log_level: INFO
  max_connections: 100
```

## 🎯 Casos de Uso Comunes

### Para Desarrolladores
- Generar datos de prueba realistas
- Automatizar pruebas de base de datos
- Analizar rendimiento de consultas
- Documentar esquemas automáticamente

### Para Administradores de BD
- Monitorear rendimiento en tiempo real
- Automatizar tareas de mantenimiento
- Generar reportes de uso y estadísticas
- Implementar políticas de seguridad

### Para Analistas de Datos
- Perfilar calidad de datos
- Generar reportes automáticos
- Validar integridad de información
- Automatizar procesos ETL

## 🔧 Personalización

Todas las herramientas están diseñadas para ser:
- **Configurables**: Parámetros ajustables vía archivos de configuración
- **Extensibles**: Código modular fácil de modificar
- **Portables**: Compatible con múltiples sistemas de bases de datos
- **Documentadas**: Comentarios detallados y ejemplos de uso

## 🤝 Contribuciones

¿Tienes una herramienta útil? ¡Compártela!

1. Asegúrate de que sea genérica y reutilizable
2. Incluye documentación clara y ejemplos
3. Añade pruebas si es aplicable
4. Sigue las convenciones de código del proyecto

---

⚡ **Tip**: Combina múltiples herramientas para crear flujos de trabajo automatizados potentes.

