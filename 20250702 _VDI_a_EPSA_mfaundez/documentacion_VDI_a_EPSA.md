# Documentación del SQL: VDI a EPSA - 20250702

## Descripción General
Este script SQL analiza la relación temporal entre Visitas Domiciliarias Integrales (VDI) y el ingreso al Examen Perinatal de Salud Ampliado (EPSA) en el contexto de salud sexual y reproductiva. Identifica pacientes que recibieron VDI y su posterior ingreso a protocolo prenatal EPSA dentro de un período de 365 días.

## Estructura del Query

### Query Principal (líneas 1-19)
La consulta utiliza una subconsulta anidada que combina datos de VDI con información de EPSA, aplicando filtros temporales y de elegibilidad.

#### Subconsulta Interna (líneas 3-17)
- **Fuente**: `biancora.cubo_salud_sexual_y_reproductiva`
- **Propósito**: Relaciona visitas domiciliarias con ingresos a EPSA

**Campos principales**:
- `pac_id`: ID del paciente
- `nif2`: Número de identificación fiscal (segunda versión)
- `fecha2 as fecha_vdi`: Fecha de la visita domiciliaria integral
- `epsa_resultado`: Resultado del examen EPSA
- `fecha2 as ingreso_epsa`: Fecha de ingreso al protocolo EPSA

#### LEFT JOIN con Subconsulta EPSA (líneas 6-10)
- **Propósito**: Obtiene el ingreso EPSA más reciente para cada paciente
- **Filtros aplicados**:
  - `protocolo_prenatal_ingreso=1`: Solo ingresos a protocolo prenatal
  - `epsa_resultado is not null`: Solo registros con resultado EPSA válido
- **Función de ventana**: `ROW_NUMBER()` particionado por `pac_id`, ordenado por fecha descendente para obtener el registro más reciente

#### Filtros de la Consulta Principal (líneas 11-17)

1. **Filtro VDI** (línea 11):
   - `vdi_visita_domiciliaria=1`: Solo pacientes con visita domiciliaria integral

2. **Filtro temporal VDI** (línea 12):
   - `fecha2>='20250101'`: VDI realizadas desde enero 2025

3. **Filtro de elegibilidad** (líneas 13-17):
   - Subconsulta que verifica pacientes con protocolo prenatal activo
   - `fecha2>='20240101'`: Registros desde enero 2024
   - `protocolo_prenatal_ingreso=1 OR protocolo_prenatal_control=1`: Pacientes en ingreso o control prenatal

### Filtro Temporal Final (línea 18)
- **Condición**: `(fecha_vdi - ingreso_epsa)<=365`
- **Propósito**: Asegura que la VDI ocurrió máximo 365 días después del ingreso EPSA
- **Lógica**: Identifica casos donde la visita domiciliaria fue posterior al ingreso EPSA dentro del año

### Ordenamiento (línea 19)
- **Criterio**: `ORDER BY 2,3` (nif2, fecha_vdi)
- **Propósito**: Organiza resultados por identificación del paciente y fecha de VDI

## Campos de Salida
- `pac_id`: ID único del paciente
- `nif2`: Número de identificación fiscal
- `fecha_vdi`: Fecha de la visita domiciliaria integral
- `epsa_resultado`: Resultado del examen perinatal
- `ingreso_epsa`: Fecha de ingreso al protocolo EPSA

## Objetivo Clínico
El script está diseñado para:
- **Evaluar continuidad de atención**: Medir la efectividad de las VDI como seguimiento post-EPSA
- **Análisis de cobertura**: Identificar pacientes que recibieron ambas intervenciones
- **Control de calidad**: Verificar la secuencia temporal adecuada de atenciones perinatales
- **Indicadores de gestión**: Generar métricas de seguimiento domiciliario en salud reproductiva

## Bases de Datos Utilizadas
- **biancora.cubo_salud_sexual_y_reproductiva**: Cubo de datos de salud sexual y reproductiva
  - Contiene registros de VDI, protocolos prenatales y resultados EPSA
  - Campos clave: pac_id, fecha2, vdi_visita_domiciliaria, protocolo_prenatal_ingreso, epsa_resultado

## Lógica Temporal
1. **Período de elegibilidad**: Pacientes con protocolo prenatal desde enero 2024
2. **Período de análisis VDI**: VDI realizadas desde enero 2025
3. **Ventana de seguimiento**: Máximo 365 días entre ingreso EPSA y VDI
4. **Secuencia esperada**: EPSA → VDI (dentro del año)

## Casos de Uso
- Reportes de seguimiento domiciliario post-prenatal
- Evaluación de programas de atención integral
- Análisis de adherencia a protocolos de salud reproductiva
- Indicadores de calidad en atención materna