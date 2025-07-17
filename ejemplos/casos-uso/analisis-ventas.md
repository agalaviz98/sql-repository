# 📊 Análisis de Ventas - Caso de Uso Práctico

## 🎯 Objetivo
Aprender a realizar análisis de ventas utilizando SQL para obtener insights valiosos del negocio.

## 📋 Contexto del Problema
Eres analista de datos en una empresa de software y necesitas generar reportes de ventas para la dirección. Los stakeholders requieren información sobre:

- Rendimiento de ventas por período
- Desempeño de vendedores
- Análisis de clientes
- Tendencias de productos
- Proyecciones y KPIs

## 🗄️ Estructura de Datos
Utilizaremos la base de datos `empresa_ejemplo.sql` que incluye las siguientes tablas principales:
- `ventas` - Transacciones de venta
- `empleados` - Información de vendedores
- `clientes` - Datos de clientes
- `departamentos` - Organización interna

## 📈 Análisis Paso a Paso

### 1. Análisis de Ventas Totales

#### Ventas por Mes
```sql
-- Ventas mensuales del año actual
SELECT 
    YEAR(fecha_venta) as año,
    MONTH(fecha_venta) as mes,
    MONTHNAME(fecha_venta) as nombre_mes,
    COUNT(*) as num_ventas,
    SUM(monto) as total_ventas,
    AVG(monto) as venta_promedio
FROM ventas 
WHERE YEAR(fecha_venta) = 2023
GROUP BY YEAR(fecha_venta), MONTH(fecha_venta)
ORDER BY año, mes;
```

#### Ventas Acumuladas
```sql
-- Ventas acumuladas por mes
SELECT 
    MONTHNAME(fecha_venta) as mes,
    SUM(monto) as ventas_mes,
    SUM(SUM(monto)) OVER (ORDER BY MONTH(fecha_venta)) as ventas_acumuladas
FROM ventas 
WHERE YEAR(fecha_venta) = 2023
GROUP BY MONTH(fecha_venta), MONTHNAME(fecha_venta)
ORDER BY MONTH(fecha_venta);
```

### 2. Análisis de Rendimiento de Vendedores

#### Top Vendedores
```sql
-- Ranking de vendedores por ventas
SELECT 
    CONCAT(e.nombre, ' ', e.apellido) as vendedor,
    COUNT(v.id) as num_ventas,
    SUM(v.monto) as total_ventas,
    AVG(v.monto) as venta_promedio,
    RANK() OVER (ORDER BY SUM(v.monto) DESC) as ranking
FROM ventas v
JOIN empleados e ON v.empleado_id = e.id
WHERE YEAR(v.fecha_venta) = 2023
GROUP BY v.empleado_id, e.nombre, e.apellido
ORDER BY total_ventas DESC;
```

#### Comparación con Objetivos
```sql
-- Rendimiento vs objetivo (asumiendo objetivo de 100K por vendedor)
SELECT 
    CONCAT(e.nombre, ' ', e.apellido) as vendedor,
    SUM(v.monto) as ventas_reales,
    100000 as objetivo_anual,
    SUM(v.monto) - 100000 as diferencia,
    ROUND((SUM(v.monto) / 100000) * 100, 2) as porcentaje_objetivo
FROM ventas v
JOIN empleados e ON v.empleado_id = e.id
WHERE YEAR(v.fecha_venta) = 2023
GROUP BY v.empleado_id, e.nombre, e.apellido
ORDER BY porcentaje_objetivo DESC;
```

### 3. Análisis de Clientes

#### Segmentación de Clientes por Valor
```sql
-- Clasificación de clientes por valor total
SELECT 
    c.nombre,
    c.empresa,
    COUNT(v.id) as num_compras,
    SUM(v.monto) as valor_total,
    AVG(v.monto) as compra_promedio,
    CASE 
        WHEN SUM(v.monto) >= 50000 THEN 'VIP'
        WHEN SUM(v.monto) >= 25000 THEN 'Premium'
        WHEN SUM(v.monto) >= 10000 THEN 'Regular'
        ELSE 'Básico'
    END as segmento
FROM clientes c
LEFT JOIN ventas v ON c.id = v.cliente_id
GROUP BY c.id, c.nombre, c.empresa
ORDER BY valor_total DESC;
```

#### Análisis de Retención
```sql
-- Clientes con múltiples compras (indicador de retención)
SELECT 
    c.nombre,
    c.empresa,
    COUNT(v.id) as num_compras,
    MIN(v.fecha_venta) as primera_compra,
    MAX(v.fecha_venta) as ultima_compra,
    DATEDIFF(MAX(v.fecha_venta), MIN(v.fecha_venta)) as dias_como_cliente
FROM clientes c
JOIN ventas v ON c.id = v.cliente_id
GROUP BY c.id, c.nombre, c.empresa
HAVING COUNT(v.id) > 1
ORDER BY num_compras DESC, dias_como_cliente DESC;
```

### 4. Análisis de Productos

#### Productos Más Vendidos
```sql
-- Ranking de productos por ventas
SELECT 
    producto,
    COUNT(*) as num_ventas,
    SUM(monto) as ingresos_totales,
    AVG(monto) as precio_promedio,
    SUM(cantidad) as unidades_vendidas
FROM ventas
WHERE YEAR(fecha_venta) = 2023
GROUP BY producto
ORDER BY ingresos_totales DESC;
```

#### Análisis de Estacionalidad
```sql
-- Ventas por producto y trimestre
SELECT 
    producto,
    CASE 
        WHEN MONTH(fecha_venta) IN (1,2,3) THEN 'Q1'
        WHEN MONTH(fecha_venta) IN (4,5,6) THEN 'Q2'
        WHEN MONTH(fecha_venta) IN (7,8,9) THEN 'Q3'
        ELSE 'Q4'
    END as trimestre,
    COUNT(*) as ventas,
    SUM(monto) as ingresos
FROM ventas
WHERE YEAR(fecha_venta) = 2023
GROUP BY producto, trimestre
ORDER BY producto, trimestre;
```

### 5. KPIs y Métricas Clave

#### Dashboard Ejecutivo
```sql
-- KPIs principales para dashboard ejecutivo
SELECT 
    'Ventas Totales 2023' as metrica,
    CONCAT('$', FORMAT(SUM(monto), 2)) as valor
FROM ventas WHERE YEAR(fecha_venta) = 2023

UNION ALL

SELECT 
    'Número de Transacciones',
    COUNT(*) as valor
FROM ventas WHERE YEAR(fecha_venta) = 2023

UNION ALL

SELECT 
    'Ticket Promedio',
    CONCAT('$', FORMAT(AVG(monto), 2))
FROM ventas WHERE YEAR(fecha_venta) = 2023

UNION ALL

SELECT 
    'Clientes Únicos',
    COUNT(DISTINCT cliente_id)
FROM ventas WHERE YEAR(fecha_venta) = 2023

UNION ALL

SELECT 
    'Crecimiento vs 2022',
    CONCAT(
        FORMAT(
            ((SUM(CASE WHEN YEAR(fecha_venta) = 2023 THEN monto END) - 
              SUM(CASE WHEN YEAR(fecha_venta) = 2022 THEN monto END)) / 
             SUM(CASE WHEN YEAR(fecha_venta) = 2022 THEN monto END)) * 100, 
            2
        ), '%'
    )
FROM ventas WHERE YEAR(fecha_venta) IN (2022, 2023);
```

#### Análisis de Conversión por Estado
```sql
-- Análisis del pipeline de ventas
SELECT 
    estado,
    COUNT(*) as num_ventas,
    SUM(monto) as valor_total,
    ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ventas)), 2) as porcentaje_total
FROM ventas
GROUP BY estado
ORDER BY 
    CASE estado
        WHEN 'Pendiente' THEN 1
        WHEN 'Procesada' THEN 2
        WHEN 'Enviada' THEN 3
        WHEN 'Entregada' THEN 4
        WHEN 'Cancelada' THEN 5
    END;
```

## 📊 Consultas Avanzadas

### Análisis de Cohortes Simplificado
```sql
-- Análisis de cohortes por mes de primera compra
WITH primera_compra AS (
    SELECT 
        cliente_id,
        MIN(DATE_FORMAT(fecha_venta, '%Y-%m')) as cohorte_mes
    FROM ventas
    GROUP BY cliente_id
),
ventas_cohorte AS (
    SELECT 
        pc.cohorte_mes,
        DATE_FORMAT(v.fecha_venta, '%Y-%m') as mes_venta,
        COUNT(DISTINCT v.cliente_id) as clientes_activos
    FROM primera_compra pc
    JOIN ventas v ON pc.cliente_id = v.cliente_id
    GROUP BY pc.cohorte_mes, DATE_FORMAT(v.fecha_venta, '%Y-%m')
)
SELECT 
    cohorte_mes,
    mes_venta,
    clientes_activos,
    ROUND(
        clientes_activos * 100.0 / 
        FIRST_VALUE(clientes_activos) OVER (
            PARTITION BY cohorte_mes 
            ORDER BY mes_venta
        ), 2
    ) as retencion_porcentaje
FROM ventas_cohorte
ORDER BY cohorte_mes, mes_venta;
```

### Predicción Simple de Ventas
```sql
-- Tendencia de ventas para proyección
SELECT 
    DATE_FORMAT(fecha_venta, '%Y-%m') as mes,
    SUM(monto) as ventas_mes,
    AVG(SUM(monto)) OVER (
        ORDER BY DATE_FORMAT(fecha_venta, '%Y-%m') 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) as media_movil_3_meses
FROM ventas
WHERE fecha_venta >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
GROUP BY DATE_FORMAT(fecha_venta, '%Y-%m')
ORDER BY mes;
```

## 🎯 Ejercicios Prácticos

### Ejercicio 1: Análisis Básico
1. Encuentra el mes con mayores ventas en 2023
2. Identifica al vendedor con mejor desempeño
3. Calcula el crecimiento mensual de ventas

### Ejercicio 2: Análisis de Clientes
1. Identifica clientes que no han comprado en los últimos 6 meses
2. Encuentra clientes con mayor frecuencia de compra
3. Calcula el valor de vida del cliente (CLV) promedio

### Ejercicio 3: Análisis Avanzado
1. Crea un ranking de productos por rentabilidad
2. Analiza la estacionalidad de las ventas
3. Identifica oportunidades de cross-selling

## 💡 Insights y Recomendaciones

### Patrones Identificados
- **Estacionalidad**: Las ventas tienden a ser mayores en Q4
- **Concentración**: 20% de clientes generan 80% de ingresos
- **Productos**: Software empresarial tiene mayor margen

### Recomendaciones de Negocio
1. **Enfoque en retención**: Implementar programa de fidelización para clientes VIP
2. **Capacitación**: Entrenar vendedores con menor rendimiento
3. **Productos**: Promocionar productos de alto margen en temporadas bajas
4. **Segmentación**: Desarrollar estrategias específicas por segmento de cliente

## 🔗 Próximos Pasos
- Implementar dashboard automatizado
- Crear alertas para KPIs críticos
- Desarrollar modelos predictivos más sofisticados
- Integrar datos de marketing para análisis completo

---

📈 **Nota**: Este análisis debe actualizarse regularmente para mantener relevancia en la toma de decisiones.

