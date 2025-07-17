# 🤝 Guía de Contribuciones

¡Gracias por tu interés en contribuir al Repositorio SQL Completo! Tu participación es muy valiosa para hacer de este un recurso aún mejor para la comunidad.

## 📋 Tabla de Contenidos

- [Código de Conducta](#código-de-conducta)
- [Cómo Contribuir](#cómo-contribuir)
- [Tipos de Contribuciones](#tipos-de-contribuciones)
- [Proceso de Desarrollo](#proceso-de-desarrollo)
- [Estándares de Código](#estándares-de-código)
- [Proceso de Revisión](#proceso-de-revisión)

## 📜 Código de Conducta

Este proyecto se adhiere a un código de conducta. Al participar, se espera que mantengas este código. Por favor reporta comportamientos inaceptables.

### Nuestros Compromisos

- Usar un lenguaje acogedor e inclusivo
- Respetar diferentes puntos de vista y experiencias
- Aceptar críticas constructivas de manera elegante
- Enfocarse en lo que es mejor para la comunidad
- Mostrar empatía hacia otros miembros de la comunidad

## 🚀 Cómo Contribuir

### Reportar Bugs

Si encuentras un error:

1. **Verifica** que no haya sido reportado anteriormente
2. **Crea un issue** con información detallada:
   - Descripción clara del problema
   - Pasos para reproducir el error
   - Comportamiento esperado vs actual
   - Sistema de base de datos utilizado
   - Versión del software

### Sugerir Mejoras

Para sugerir nuevas funcionalidades:

1. **Revisa** las issues existentes para evitar duplicados
2. **Crea un issue** describiendo:
   - La funcionalidad propuesta
   - Por qué sería útil
   - Posible implementación
   - Ejemplos de uso

### Contribuir con Código

1. **Fork** el repositorio
2. **Crea** una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. **Desarrolla** tu contribución siguiendo los estándares
4. **Commit** tus cambios (`git commit -m 'Add some AmazingFeature'`)
5. **Push** a la rama (`git push origin feature/AmazingFeature`)
6. **Abre** un Pull Request

## 🎯 Tipos de Contribuciones

### 📚 Tutoriales y Documentación

- Nuevos tutoriales para diferentes niveles
- Mejoras en explicaciones existentes
- Correcciones de errores tipográficos
- Traducciones a otros idiomas
- Ejemplos adicionales y ejercicios

**Estructura requerida para tutoriales:**
```
# Título del Tutorial

## Objetivos
## Prerrequisitos  
## Contenido Principal
## Ejemplos Prácticos
## Ejercicios
## Soluciones
## Próximos Pasos
```

### 💡 Ejemplos y Casos de Uso

- Casos de uso del mundo real
- Ejemplos específicos por industria
- Proyectos completos paso a paso
- Datasets de práctica

**Estructura requerida para ejemplos:**
```
ejemplo-nombre/
├── README.md          # Descripción y contexto
├── schema.sql         # Estructura de BD
├── data.sql          # Datos de ejemplo
├── queries.sql       # Consultas principales
└── solutions.sql     # Soluciones a ejercicios
```

### 🛠️ Herramientas y Scripts

- Scripts de automatización
- Herramientas de análisis
- Utilidades de productividad
- Mejoras en scripts existentes

**Requisitos para herramientas:**
- Documentación clara de uso
- Ejemplos de ejecución
- Manejo de errores
- Compatibilidad con múltiples SGBD cuando sea posible

### 🗄️ Soporte para Nuevos SGBD

- Ejemplos específicos para nuevos sistemas
- Adaptaciones de sintaxis
- Documentación de diferencias
- Scripts de migración

## 🔧 Proceso de Desarrollo

### Configuración del Entorno

1. **Clona** tu fork:
   ```bash
   git clone https://github.com/tu-usuario/sql-repository.git
   cd sql-repository
   ```

2. **Configura** el repositorio original como upstream:
   ```bash
   git remote add upstream https://github.com/original-usuario/sql-repository.git
   ```

3. **Mantén** tu fork actualizado:
   ```bash
   git fetch upstream
   git checkout main
   git merge upstream/main
   ```

### Flujo de Trabajo

1. **Crea** una rama específica para tu contribución
2. **Desarrolla** en pequeños commits lógicos
3. **Prueba** tu código en diferentes entornos si es posible
4. **Documenta** los cambios realizados
5. **Actualiza** el README si es necesario

## 📝 Estándares de Código

### SQL

- **Indentación**: 4 espacios (no tabs)
- **Palabras clave**: MAYÚSCULAS
- **Nombres**: snake_case para tablas y columnas
- **Comentarios**: Explicar lógica compleja

```sql
-- Ejemplo de formato correcto
SELECT 
    e.nombre,
    e.apellido,
    d.nombre AS departamento
FROM empleados e
INNER JOIN departamentos d ON e.departamento_id = d.id
WHERE e.activo = TRUE
ORDER BY e.apellido, e.nombre;
```

### Python (para utilidades)

- **Estilo**: PEP 8
- **Docstrings**: Para todas las funciones públicas
- **Type hints**: Cuando sea apropiado
- **Tests**: Para funcionalidades críticas

### Markdown

- **Encabezados**: Usar jerarquía lógica
- **Código**: Especificar lenguaje en bloques de código
- **Enlaces**: Usar referencias cuando sea posible
- **Emojis**: Con moderación para mejorar legibilidad

## 🔍 Proceso de Revisión

### Criterios de Aceptación

- **Funcionalidad**: El código funciona como se espera
- **Calidad**: Sigue los estándares establecidos
- **Documentación**: Está bien documentado
- **Pruebas**: Incluye pruebas cuando es apropiado
- **Compatibilidad**: No rompe funcionalidad existente

### Tiempo de Revisión

- **Issues simples**: 1-3 días
- **Contribuciones menores**: 3-7 días
- **Contribuciones mayores**: 1-2 semanas

### Feedback

- Las revisiones se enfocan en mejorar el código
- Se proporcionan sugerencias constructivas
- Se explican los cambios solicitados
- Se reconoce el esfuerzo de los contribuidores

## 🏷️ Etiquetas y Categorización

### Labels para Issues

- `bug` - Error en el código
- `enhancement` - Nueva funcionalidad
- `documentation` - Mejoras en documentación
- `good first issue` - Ideal para nuevos contribuidores
- `help wanted` - Se necesita ayuda de la comunidad
- `question` - Pregunta sobre el proyecto

### Labels para Pull Requests

- `ready for review` - Listo para revisión
- `work in progress` - En desarrollo
- `needs changes` - Requiere modificaciones
- `approved` - Aprobado para merge

## 🎉 Reconocimiento

Los contribuidores serán reconocidos en:

- Lista de contribuidores en el README
- Sección de agradecimientos
- Release notes cuando corresponda

## 📞 Contacto

Si tienes preguntas sobre cómo contribuir:

- Abre un issue con la etiqueta `question`
- Contacta a los mantenedores del proyecto
- Únete a las discusiones en GitHub Discussions

## 📚 Recursos Adicionales

- [Guía de GitHub para contribuir a proyectos](https://guides.github.com/activities/contributing-to-open-source/)
- [Cómo escribir buenos commits](https://chris.beams.io/posts/git-commit/)
- [Markdown Guide](https://www.markdownguide.org/)

---

¡Gracias por contribuir al Repositorio SQL Completo! 🙏

