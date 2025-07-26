# Documentación del SQL: Pacientes Etapa 3b, 4 y 5

## Descripción General
Este script SQL identifica pacientes con diabetes mellitus (DM) que se encuentran en etapas avanzadas de enfermedad renal crónica (ERC), específicamente etapas G3b, G4 y G5.

## Estructura del Query

### CTEs (Common Table Expressions)

#### 1. etapa_erc (líneas 3-7)
- **Propósito**: Obtiene la etapa ERC más reciente para cada paciente
- **Fuente**: `biancora.cubo_cronicos`
- **Campos**:
  - `pac_id`: ID del paciente
  - `fecha`: Fecha del registro convertida a Date
  - `etapa_erc`: Etapa de enfermedad renal crónica
  - `rownum`: Número de fila para obtener el registro más reciente
- **Lógica**: Usa `ROW_NUMBER()` particionado por paciente, ordenado por fecha descendente

#### 2. pacientes_dm (líneas 8-10)
- **Propósito**: Identifica pacientes con diabetes mellitus
- **Fuente**: `biancora.cubo_cronicos`
- **Filtro**: `dm=1` (pacientes diabéticos)

#### 3. pac_con_etapa (líneas 11-22)
- **Propósito**: Combina pacientes diabéticos con su etapa ERC más reciente
- **Lógica de categorización**:
  - Etapas G1/G2 (>60): Agrupa etapas con VFG >= 60
  - Etapa G3a (45-59): VFG entre 45-59
  - Etapa G3b (30-44): VFG entre 30-44
  - Etapa G4 (15-29): VFG entre 15-29
  - Etapa G5 (<15): VFG < 15

### Query Principal (líneas 23-32)
- **Joins**:
  - `pac_con_etapa`: Datos de pacientes con etapas ERC
  - `omicolors_staging.stk_personas`: Información demográfica (nombre, RUN, centro)

- **Filtros aplicados**:
  1. **Etapas objetivo** (líneas 26-30):
     - Etapa G3b (30-44)
     - Etapa G4 (15-29)
     - Etapa G5 (<15)
     - Etapa 3 VFG 30-59 (categoría adicional)
  
  2. **Lista específica** (línea 31):
     - Pacientes incluidos en `rem_p.remp04_pbc_listado('20250725')`
     - Fecha específica: 25 de julio de 2025

## Campos de Salida
- `nombre_completo`: Nombre del paciente
- `run`: RUN/documento del paciente
- `centro`: Centro médico
- `pac_id`: ID del paciente
- `fecha`: Fecha del último registro de etapa ERC
- `etapa_erc`: Etapa categorizada
- `etapa_erc2`: Etapa original sin categorizar

## Objetivo Clínico
El query está diseñado para identificar pacientes diabéticos en etapas avanzadas de ERC (3b, 4 y 5) que requieren seguimiento especial y posible preparación para terapias de reemplazo renal.

## Bases de Datos Utilizadas
- `biancora.cubo_cronicos`: Datos clínicos históricos
- `omicolors_staging.stk_personas`: Información demográfica
- `rem_p.remp04_pbc_listado()`: Función que retorna lista específica de pacientes

## Notas Técnicas
- El script incluye una línea comentada (línea 1) para verificar pacientes diabéticos
- Utiliza la función `remp04_pbc_listado` con fecha específica como filtro final
- La categorización de etapas sigue estándares clínicos de VFG (Velocidad de Filtración Glomerular)