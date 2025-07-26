# Repositorio de Consultas SQL - Datos Clínicos

## 📋 Descripción

Este repositorio contiene consultas SQL especializadas para el análisis de datos clínicos, enfocándose en la gestión y seguimiento de pacientes con enfermedades crónicas, particularmente diabetes mellitus y enfermedad renal crónica (ERC).

## 🎯 Objetivo

Facilitar la identificación y seguimiento de pacientes diabéticos en etapas avanzadas de enfermedad renal crónica mediante consultas SQL optimizadas y documentadas.

## 📊 Fuentes de Datos

### Esquemas de Base de Datos

- **`biancora.cubo_cronicos`**: Almacén de datos clínicos históricos
  - Contiene registros de enfermedades crónicas por paciente
  - Incluye información de etapas ERC y diagnósticos de diabetes

- **`omicolors_staging.stk_personas`**: Información demográfica
  - Datos de identificación de pacientes
  - Información de centros médicos

- **`rem_p.remp04_pbc_listado()`**: Función de listados específicos
  - Retorna listas de pacientes filtradas por fecha

## 📁 Estructura del Repositorio

```
├── pacientes etapa 3b 4 y 5 smartinez.sql    # Consulta principal ERC avanzada
├── documentacion_sql.md                        # Documentación técnica detallada
├── CLAUDE.md                                   # Guía para desarrollo con IA
└── README.md                                   # Este archivo
```

## 🔍 Consultas Principales

### Pacientes ERC Etapas Avanzadas
**Archivo**: `pacientes etapa 3b 4 y 5 smartinez.sql`

Identifica pacientes diabéticos en etapas críticas de enfermedad renal crónica:
- **Etapa G3b** (VFG 30-44): Disminución moderada a severa
- **Etapa G4** (VFG 15-29): Disminución severa  
- **Etapa G5** (VFG <15): Falla renal

**Campos de salida**:
- Información demográfica del paciente
- Etapa ERC actual y fecha
- Centro médico asignado

## 🏥 Clasificación Clínica ERC

| Etapa | VFG (ml/min/1.73m²) | Descripción |
|-------|---------------------|-------------|
| G1/G2 | ≥60 | Etapas tempranas |
| G3a | 45-59 | Disminución moderada |
| G3b | 30-44 | Disminución moderada a severa |
| G4 | 15-29 | Disminución severa |
| G5 | <15 | Falla renal |

## 🛠️ Patrones Técnicos

### Common Table Expressions (CTEs)
Las consultas utilizan un patrón estructurado de CTEs:

1. **Extracción de datos**: Obtención de registros más recientes
2. **Filtrado**: Aplicación de criterios clínicos
3. **Categorización**: Agrupación por etapas clínicas
4. **Unión final**: Combinación con datos demográficos

### Funciones de Ventana
- `ROW_NUMBER()` para obtener registros más recientes por paciente
- Particionado por `pac_id` y ordenado por fecha descendente

## 📖 Documentación

- **`documentacion_sql.md`**: Documentación técnica completa de la consulta principal
- **`CLAUDE.md`**: Guía para desarrollo asistido por IA

## ⚕️ Uso Clínico

Este repositorio está diseñado para:
- **Seguimiento de pacientes** en riesgo de terapia de reemplazo renal
- **Identificación temprana** de deterioro de función renal
- **Planificación de recursos** médicos especializados
- **Reportes epidemiológicos** de ERC en población diabética

## 🔒 Consideraciones de Privacidad

- Los datos de pacientes están anonimizados mediante identificadores únicos (`pac_id`)
- No se incluyen datos sensibles en el repositorio
- Las consultas siguen estándares de privacidad médica

## 📝 Contribuciones

Para contribuir al repositorio:
1. Documentar nuevas consultas siguiendo el patrón CTE establecido
2. Incluir documentación técnica detallada
3. Validar resultados clínicos con personal médico especializado
4. Mantener consistencia en nomenclatura de campos

## 📞 Contacto

Para consultas técnicas o clínicas sobre las consultas SQL, contactar al equipo de análisis de datos clínicos.