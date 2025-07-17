-- =====================================================
-- Base de Datos de Ejemplo: Sistema de Empresa
-- =====================================================
-- Este script crea una base de datos completa para practicar SQL
-- Incluye empleados, departamentos, proyectos y ventas

-- Crear base de datos (comentar si ya existe)
-- CREATE DATABASE empresa_ejemplo;
-- USE empresa_ejemplo;

-- =====================================================
-- CREAR TABLAS
-- =====================================================

-- Tabla de Departamentos
CREATE TABLE departamentos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    presupuesto DECIMAL(12,2),
    ubicacion VARCHAR(100),
    fecha_creacion DATE
);

-- Tabla de Empleados
CREATE TABLE empleados (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefono VARCHAR(20),
    fecha_nacimiento DATE,
    fecha_contratacion DATE NOT NULL,
    salario DECIMAL(10,2) NOT NULL,
    departamento_id INT,
    jefe_id INT,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (departamento_id) REFERENCES departamentos(id),
    FOREIGN KEY (jefe_id) REFERENCES empleados(id)
);

-- Tabla de Proyectos
CREATE TABLE proyectos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    presupuesto DECIMAL(12,2),
    estado ENUM('Planificado', 'En Progreso', 'Completado', 'Cancelado') DEFAULT 'Planificado',
    departamento_id INT,
    FOREIGN KEY (departamento_id) REFERENCES departamentos(id)
);

-- Tabla de Asignaciones (Empleados a Proyectos)
CREATE TABLE asignaciones (
    id INT PRIMARY KEY AUTO_INCREMENT,
    empleado_id INT NOT NULL,
    proyecto_id INT NOT NULL,
    fecha_asignacion DATE NOT NULL,
    horas_asignadas INT DEFAULT 40,
    rol VARCHAR(50),
    FOREIGN KEY (empleado_id) REFERENCES empleados(id),
    FOREIGN KEY (proyecto_id) REFERENCES proyectos(id),
    UNIQUE KEY unique_asignacion (empleado_id, proyecto_id)
);

-- Tabla de Clientes
CREATE TABLE clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    empresa VARCHAR(100),
    email VARCHAR(100),
    telefono VARCHAR(20),
    direccion TEXT,
    ciudad VARCHAR(50),
    pais VARCHAR(50),
    fecha_registro DATE NOT NULL
);

-- Tabla de Ventas
CREATE TABLE ventas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    empleado_id INT NOT NULL,
    fecha_venta DATE NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    producto VARCHAR(100),
    cantidad INT DEFAULT 1,
    descuento DECIMAL(5,2) DEFAULT 0.00,
    estado ENUM('Pendiente', 'Procesada', 'Enviada', 'Entregada', 'Cancelada') DEFAULT 'Pendiente',
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (empleado_id) REFERENCES empleados(id)
);

-- =====================================================
-- INSERTAR DATOS DE EJEMPLO
-- =====================================================

-- Insertar Departamentos
INSERT INTO departamentos (nombre, presupuesto, ubicacion, fecha_creacion) VALUES
('Recursos Humanos', 150000.00, 'Piso 1, Oficina A', '2020-01-15'),
('Tecnología', 500000.00, 'Piso 3, Oficina B', '2020-01-15'),
('Ventas', 300000.00, 'Piso 2, Oficina C', '2020-01-15'),
('Marketing', 250000.00, 'Piso 2, Oficina D', '2020-02-01'),
('Finanzas', 200000.00, 'Piso 1, Oficina E', '2020-01-15'),
('Operaciones', 180000.00, 'Piso 4, Oficina F', '2020-03-01');

-- Insertar Empleados
INSERT INTO empleados (nombre, apellido, email, telefono, fecha_nacimiento, fecha_contratacion, salario, departamento_id, jefe_id) VALUES
-- Directores (sin jefe)
('Ana', 'Rodríguez', 'ana.rodriguez@empresa.com', '555-0001', '1980-05-15', '2020-01-20', 85000.00, 1, NULL),
('Carlos', 'Mendoza', 'carlos.mendoza@empresa.com', '555-0002', '1978-08-22', '2020-01-20', 95000.00, 2, NULL),
('Laura', 'Fernández', 'laura.fernandez@empresa.com', '555-0003', '1982-03-10', '2020-01-25', 80000.00, 3, NULL),

-- Empleados de RRHH
('Miguel', 'Santos', 'miguel.santos@empresa.com', '555-0004', '1985-11-30', '2020-02-15', 55000.00, 1, 1),
('Sofia', 'Morales', 'sofia.morales@empresa.com', '555-0005', '1990-07-18', '2020-03-01', 48000.00, 1, 1),

-- Empleados de Tecnología
('David', 'García', 'david.garcia@empresa.com', '555-0006', '1988-12-05', '2020-02-01', 75000.00, 2, 2),
('Elena', 'López', 'elena.lopez@empresa.com', '555-0007', '1992-04-25', '2020-04-15', 68000.00, 2, 2),
('Roberto', 'Jiménez', 'roberto.jimenez@empresa.com', '555-0008', '1987-09-12', '2020-03-10', 72000.00, 2, 2),
('Carmen', 'Ruiz', 'carmen.ruiz@empresa.com', '555-0009', '1991-01-08', '2020-06-01', 65000.00, 2, 2),

-- Empleados de Ventas
('Pedro', 'Martín', 'pedro.martin@empresa.com', '555-0010', '1986-06-20', '2020-02-10', 52000.00, 3, 3),
('Isabel', 'Herrera', 'isabel.herrera@empresa.com', '555-0011', '1989-10-14', '2020-03-15', 49000.00, 3, 3),
('Javier', 'Castillo', 'javier.castillo@empresa.com', '555-0012', '1984-02-28', '2020-01-30', 58000.00, 3, 3),

-- Empleados de Marketing
('Lucía', 'Vargas', 'lucia.vargas@empresa.com', '555-0013', '1993-08-07', '2020-05-01', 46000.00, 4, NULL),
('Andrés', 'Ortega', 'andres.ortega@empresa.com', '555-0014', '1987-12-19', '2020-04-20', 51000.00, 4, NULL),

-- Empleados de Finanzas
('Beatriz', 'Ramos', 'beatriz.ramos@empresa.com', '555-0015', '1983-03-16', '2020-02-25', 62000.00, 5, NULL),
('Fernando', 'Guerrero', 'fernando.guerrero@empresa.com', '555-0016', '1981-11-03', '2020-01-28', 67000.00, 5, NULL);

-- Insertar Proyectos
INSERT INTO proyectos (nombre, descripcion, fecha_inicio, fecha_fin, presupuesto, estado, departamento_id) VALUES
('Sistema CRM', 'Desarrollo de sistema de gestión de clientes', '2023-01-15', '2023-06-30', 150000.00, 'Completado', 2),
('Campaña Digital 2023', 'Campaña de marketing digital para Q1', '2023-01-01', '2023-03-31', 75000.00, 'Completado', 4),
('Migración a la Nube', 'Migración de infraestructura a AWS', '2023-04-01', '2023-09-30', 200000.00, 'En Progreso', 2),
('Expansión Ventas', 'Apertura de nuevos mercados', '2023-02-01', '2023-12-31', 120000.00, 'En Progreso', 3),
('Automatización RRHH', 'Sistema de gestión de recursos humanos', '2023-07-01', '2024-02-28', 100000.00, 'Planificado', 1),
('Optimización Procesos', 'Mejora de procesos operativos', '2023-05-15', '2023-11-30', 80000.00, 'En Progreso', 6);

-- Insertar Asignaciones
INSERT INTO asignaciones (empleado_id, proyecto_id, fecha_asignacion, horas_asignadas, rol) VALUES
-- Sistema CRM
(6, 1, '2023-01-15', 40, 'Desarrollador Senior'),
(7, 1, '2023-01-20', 40, 'Desarrollador'),
(8, 1, '2023-01-15', 30, 'Arquitecto de Software'),

-- Campaña Digital
(13, 2, '2023-01-01', 35, 'Gerente de Campaña'),
(14, 2, '2023-01-05', 40, 'Especialista Digital'),

-- Migración a la Nube
(6, 3, '2023-04-01', 25, 'DevOps Lead'),
(8, 3, '2023-04-01', 40, 'Arquitecto Cloud'),
(9, 3, '2023-04-15', 30, 'Desarrollador'),

-- Expansión Ventas
(10, 4, '2023-02-01', 30, 'Coordinador Regional'),
(11, 4, '2023-02-01', 35, 'Analista de Mercado'),
(12, 4, '2023-02-15', 40, 'Gerente de Ventas');

-- Insertar Clientes
INSERT INTO clientes (nombre, empresa, email, telefono, direccion, ciudad, pais, fecha_registro) VALUES
('Juan Pérez', 'TechCorp SA', 'juan.perez@techcorp.com', '555-1001', 'Av. Principal 123', 'Madrid', 'España', '2022-03-15'),
('María González', 'InnovaSoft', 'maria.gonzalez@innovasoft.com', '555-1002', 'Calle Comercio 456', 'Barcelona', 'España', '2022-05-20'),
('Carlos Ruiz', 'DataSolutions', 'carlos.ruiz@datasolutions.com', '555-1003', 'Plaza Central 789', 'Valencia', 'España', '2022-07-10'),
('Ana Martínez', 'CloudTech', 'ana.martinez@cloudtech.com', '555-1004', 'Av. Tecnología 321', 'Sevilla', 'España', '2022-09-05'),
('Luis Fernández', 'StartupXYZ', 'luis.fernandez@startupxyz.com', '555-1005', 'Calle Innovación 654', 'Bilbao', 'España', '2022-11-12'),
('Carmen López', 'MegaCorp', 'carmen.lopez@megacorp.com', '555-1006', 'Av. Empresarial 987', 'Málaga', 'España', '2023-01-08'),
('Roberto Silva', 'TechStart', 'roberto.silva@techstart.com', '555-1007', 'Calle Desarrollo 147', 'Zaragoza', 'España', '2023-02-14'),
('Elena Vargas', 'DigitalPro', 'elena.vargas@digitalpro.com', '555-1008', 'Plaza Negocios 258', 'Murcia', 'España', '2023-03-22');

-- Insertar Ventas
INSERT INTO ventas (cliente_id, empleado_id, fecha_venta, monto, producto, cantidad, descuento, estado) VALUES
-- Ventas de 2022
(1, 10, '2022-04-15', 25000.00, 'Licencia Software Empresarial', 1, 5.00, 'Entregada'),
(2, 11, '2022-06-20', 15000.00, 'Consultoría IT', 1, 0.00, 'Entregada'),
(3, 12, '2022-08-10', 35000.00, 'Sistema Personalizado', 1, 10.00, 'Entregada'),

-- Ventas de 2023
(1, 10, '2023-01-15', 45000.00, 'Upgrade Sistema', 1, 8.00, 'Entregada'),
(4, 11, '2023-02-05', 28000.00, 'Migración Cloud', 1, 5.00, 'Entregada'),
(2, 12, '2023-02-20', 18000.00, 'Soporte Técnico Anual', 1, 0.00, 'Entregada'),
(5, 10, '2023-03-10', 32000.00, 'Desarrollo Web', 1, 7.00, 'Entregada'),
(3, 11, '2023-04-15', 22000.00, 'Consultoría Seguridad', 1, 3.00, 'Entregada'),
(6, 12, '2023-05-08', 55000.00, 'ERP Empresarial', 1, 12.00, 'Procesada'),
(7, 10, '2023-06-12', 19000.00, 'App Móvil', 1, 0.00, 'Enviada'),
(8, 11, '2023-07-20', 41000.00, 'Plataforma E-commerce', 1, 9.00, 'En Progreso'),
(1, 12, '2023-08-05', 26000.00, 'Mantenimiento Anual', 1, 4.00, 'Procesada'),
(4, 10, '2023-09-15', 33000.00, 'Integración APIs', 1, 6.00, 'Pendiente'),
(2, 11, '2023-10-10', 29000.00, 'Análisis de Datos', 1, 5.00, 'Pendiente'),
(5, 12, '2023-11-01', 38000.00, 'Sistema IoT', 1, 8.00, 'Pendiente');

-- =====================================================
-- CREAR ÍNDICES PARA MEJOR RENDIMIENTO
-- =====================================================

CREATE INDEX idx_empleados_departamento ON empleados(departamento_id);
CREATE INDEX idx_empleados_jefe ON empleados(jefe_id);
CREATE INDEX idx_ventas_cliente ON ventas(cliente_id);
CREATE INDEX idx_ventas_empleado ON ventas(empleado_id);
CREATE INDEX idx_ventas_fecha ON ventas(fecha_venta);
CREATE INDEX idx_asignaciones_empleado ON asignaciones(empleado_id);
CREATE INDEX idx_asignaciones_proyecto ON asignaciones(proyecto_id);

-- =====================================================
-- VISTAS ÚTILES PARA CONSULTAS COMUNES
-- =====================================================

-- Vista de empleados con información del departamento
CREATE VIEW vista_empleados_completa AS
SELECT 
    e.id,
    e.nombre,
    e.apellido,
    e.email,
    e.salario,
    d.nombre as departamento,
    d.ubicacion,
    CONCAT(j.nombre, ' ', j.apellido) as jefe
FROM empleados e
LEFT JOIN departamentos d ON e.departamento_id = d.id
LEFT JOIN empleados j ON e.jefe_id = j.id
WHERE e.activo = TRUE;

-- Vista de ventas con detalles
CREATE VIEW vista_ventas_detalle AS
SELECT 
    v.id,
    v.fecha_venta,
    v.monto,
    v.producto,
    v.estado,
    c.nombre as cliente,
    c.empresa,
    CONCAT(e.nombre, ' ', e.apellido) as vendedor,
    d.nombre as departamento_vendedor
FROM ventas v
JOIN clientes c ON v.cliente_id = c.id
JOIN empleados e ON v.empleado_id = e.id
JOIN departamentos d ON e.departamento_id = d.id;

-- =====================================================
-- CONSULTAS DE EJEMPLO PARA VERIFICAR LOS DATOS
-- =====================================================

-- Verificar que todo se creó correctamente
SELECT 'Departamentos' as tabla, COUNT(*) as registros FROM departamentos
UNION ALL
SELECT 'Empleados', COUNT(*) FROM empleados
UNION ALL
SELECT 'Proyectos', COUNT(*) FROM proyectos
UNION ALL
SELECT 'Clientes', COUNT(*) FROM clientes
UNION ALL
SELECT 'Ventas', COUNT(*) FROM ventas
UNION ALL
SELECT 'Asignaciones', COUNT(*) FROM asignaciones;

-- Mostrar estructura organizacional
SELECT 
    d.nombre as departamento,
    COUNT(e.id) as num_empleados,
    AVG(e.salario) as salario_promedio,
    SUM(e.salario) as costo_total_salarios
FROM departamentos d
LEFT JOIN empleados e ON d.id = e.departamento_id AND e.activo = TRUE
GROUP BY d.id, d.nombre
ORDER BY num_empleados DESC;

