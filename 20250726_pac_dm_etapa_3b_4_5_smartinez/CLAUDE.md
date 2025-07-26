# CLAUDE.md

Este archivo proporciona orientación a Claude Code (claude.ai/code) al trabajar con código en este repositorio.

## Descripción General del Repositorio

Este es un repositorio de análisis de datos médicos/sanitarios enfocado en consultas SQL para el manejo de pacientes con enfermedad renal crónica (ERC) en pacientes diabéticos. El repositorio contiene scripts SQL y documentación para identificar pacientes en etapas avanzadas de enfermedad renal crónica.

## Arquitectura y Fuentes de Datos

### Esquema de Base de Datos
- **biancora.cubo_cronicos**: Almacén principal de datos clínicos que contiene registros de enfermedades crónicas de pacientes
  - Campos: pac_id, fecha, etapa_erc, dm (indicador de diabetes mellitus)
- **omicolors_staging.stk_personas**: Información demográfica de pacientes
  - Campos: pac_id, nombre_completo, documento (RUN), centro
- **rem_p.remp04_pbc_listado()**: Función que retorna listas específicas de pacientes por fecha

### Patrones SQL Principales
El repositorio utiliza el patrón de Common Table Expressions (CTEs) para consultas complejas:
1. **etapa_erc CTE**: Obtiene la etapa ERC más reciente por paciente usando la función de ventana ROW_NUMBER()
2. **pacientes_dm CTE**: Filtra pacientes diabéticos (dm=1)
3. **pac_con_etapa CTE**: Categoriza las etapas ERC en grupos clínicos
4. **Consulta principal**: Une con datos demográficos y aplica filtros de negocio

### Clasificación de Etapas ERC
- G1/G2 (>60 VFG): Etapas tempranas
- G3a (45-59 VFG): Disminución moderada
- G3b (30-44 VFG): Disminución moderada a severa
- G4 (15-29 VFG): Disminución severa
- G5 (<15 VFG): Falla renal

## Estructura de Archivos

- `pacientes etapa 3b 4 y 5 smartinez.sql`: Consulta SQL principal para identificar pacientes diabéticos en etapas avanzadas de ERC (3b, 4, 5)
- `documentacion_sql.md`: Documentación integral de la estructura y lógica de la consulta SQL

## Guías de Desarrollo

### Desarrollo de Consultas SQL
- Usar CTEs para consultas complejas de múltiples pasos
- Seguir el patrón establecido: extracción de datos → filtrado → categorización → unión final
- Incluir filtrado específico por fecha usando funciones como `remp04_pbc_listado('YYYYMMDD')`
- Usar funciones de ventana (ROW_NUMBER) para obtener los registros más recientes por paciente

### Enfoque de Análisis de Datos
- Dirigirse a etapas avanzadas de ERC (3b, 4, 5) en pacientes diabéticos
- Mantener precisión clínica en la categorización de VFG (Velocidad de Filtración Glomerular)
- Asegurar identificación adecuada de pacientes a través de uniones pac_id entre esquemas