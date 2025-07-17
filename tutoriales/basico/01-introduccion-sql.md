# 📖 Introducción a SQL

## ¿Qué es SQL?

**SQL (Structured Query Language)** es un lenguaje de programación diseñado para gestionar y manipular bases de datos relacionales. Es el estándar de la industria para trabajar con datos estructurados.

## ¿Por qué Aprender SQL?

- **Universal**: Funciona con la mayoría de sistemas de bases de datos
- **Potente**: Permite consultas complejas con sintaxis relativamente simple
- **Demandado**: Habilidad esencial en análisis de datos, desarrollo web y ciencia de datos
- **Eficiente**: Optimizado para trabajar con grandes volúmenes de datos

## Conceptos Fundamentales

### Base de Datos Relacional
Una base de datos relacional organiza los datos en **tablas** que se relacionan entre sí mediante **claves**.

### Tabla
Una tabla es una colección de datos organizados en filas y columnas:
- **Filas (Registros)**: Cada fila representa una entidad única
- **Columnas (Campos)**: Cada columna representa un atributo de la entidad

### Ejemplo de Tabla: `empleados`
| id | nombre    | apellido | edad | departamento | salario |
|----|-----------|----------|------|--------------|---------|
| 1  | Juan      | Pérez    | 30   | Ventas       | 45000   |
| 2  | María     | García   | 25   | Marketing    | 42000   |
| 3  | Carlos    | López    | 35   | IT           | 55000   |

## Tipos de Comandos SQL

### 1. DDL (Data Definition Language)
Comandos para definir la estructura de la base de datos:
- `CREATE` - Crear tablas, bases de datos, índices
- `ALTER` - Modificar estructura existente
- `DROP` - Eliminar objetos de la base de datos

### 2. DML (Data Manipulation Language)
Comandos para manipular datos:
- `SELECT` - Consultar datos
- `INSERT` - Insertar nuevos registros
- `UPDATE` - Actualizar registros existentes
- `DELETE` - Eliminar registros

### 3. DCL (Data Control Language)
Comandos para controlar acceso:
- `GRANT` - Otorgar permisos
- `REVOKE` - Revocar permisos

## Tu Primera Consulta SQL

```sql
-- Seleccionar todos los empleados
SELECT * FROM empleados;
```

**Explicación**:
- `SELECT` - Especifica qué columnas queremos ver
- `*` - Asterisco significa "todas las columnas"
- `FROM empleados` - Especifica de qué tabla obtener los datos
- `;` - Termina la consulta (requerido en la mayoría de sistemas)

## Consultas Básicas

### Seleccionar Columnas Específicas
```sql
-- Seleccionar solo nombre y salario
SELECT nombre, salario FROM empleados;
```

### Filtrar Resultados con WHERE
```sql
-- Empleados del departamento de IT
SELECT nombre, apellido, salario 
FROM empleados 
WHERE departamento = 'IT';
```

### Ordenar Resultados
```sql
-- Empleados ordenados por salario (mayor a menor)
SELECT nombre, apellido, salario 
FROM empleados 
ORDER BY salario DESC;
```

## Operadores Comunes

### Operadores de Comparación
- `=` - Igual a
- `!=` o `<>` - Diferente de
- `>` - Mayor que
- `<` - Menor que
- `>=` - Mayor o igual que
- `<=` - Menor o igual que

### Operadores Lógicos
- `AND` - Ambas condiciones deben ser verdaderas
- `OR` - Al menos una condición debe ser verdadera
- `NOT` - Niega una condición

### Ejemplos con Operadores
```sql
-- Empleados de IT con salario mayor a 50000
SELECT nombre, apellido, salario 
FROM empleados 
WHERE departamento = 'IT' AND salario > 50000;

-- Empleados de Ventas o Marketing
SELECT nombre, apellido, departamento 
FROM empleados 
WHERE departamento = 'Ventas' OR departamento = 'Marketing';
```

## Funciones Básicas

### Funciones de Texto
```sql
-- Convertir nombres a mayúsculas
SELECT UPPER(nombre) as nombre_mayuscula, apellido 
FROM empleados;

-- Concatenar nombre y apellido
SELECT CONCAT(nombre, ' ', apellido) as nombre_completo 
FROM empleados;
```

### Funciones Numéricas
```sql
-- Calcular salario anual
SELECT nombre, salario, (salario * 12) as salario_anual 
FROM empleados;
```

## Ejercicios Prácticos

### Ejercicio 1: Consultas Básicas
Usando la tabla `empleados`, escribe consultas para:

1. Mostrar todos los empleados
2. Mostrar solo nombres y departamentos
3. Mostrar empleados mayores de 30 años
4. Mostrar empleados ordenados por nombre alfabéticamente

### Ejercicio 2: Filtros y Condiciones
1. Empleados con salario entre 40000 y 50000
2. Empleados que NO son del departamento de Ventas
3. Empleados cuyo nombre empiece con 'M'
4. Empleados de IT ordenados por salario descendente

## Soluciones

<details>
<summary>Haz clic para ver las soluciones</summary>

### Ejercicio 1:
```sql
-- 1. Todos los empleados
SELECT * FROM empleados;

-- 2. Solo nombres y departamentos
SELECT nombre, departamento FROM empleados;

-- 3. Empleados mayores de 30
SELECT * FROM empleados WHERE edad > 30;

-- 4. Ordenados por nombre
SELECT * FROM empleados ORDER BY nombre;
```

### Ejercicio 2:
```sql
-- 1. Salario entre 40000 y 50000
SELECT * FROM empleados WHERE salario BETWEEN 40000 AND 50000;

-- 2. NO del departamento de Ventas
SELECT * FROM empleados WHERE departamento != 'Ventas';

-- 3. Nombre empiece con 'M'
SELECT * FROM empleados WHERE nombre LIKE 'M%';

-- 4. IT ordenados por salario descendente
SELECT * FROM empleados 
WHERE departamento = 'IT' 
ORDER BY salario DESC;
```
</details>

## Próximos Pasos

En el siguiente tutorial aprenderás sobre:
- Crear y modificar tablas
- Insertar, actualizar y eliminar datos
- Trabajar con diferentes tipos de datos
- Restricciones y claves primarias

---

💡 **Consejo**: Practica cada ejemplo en tu sistema de base de datos preferido. La práctica es clave para dominar SQL.

