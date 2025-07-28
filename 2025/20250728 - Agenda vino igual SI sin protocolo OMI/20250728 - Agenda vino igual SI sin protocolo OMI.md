# Consulta: Agenda vino igual SI sin protocolo OMI

## Descripción
Esta consulta cuenta los contactos médicos que fueron registrados como "vino=true" (paciente asistió) pero que no tienen un protocolo registrado (prp_id is null), identificando brechas en la documentación clínica de atenciones confirmadas.

## Objetivo
Cuantificar las atenciones médicas donde existe discrepancia entre la asistencia registrada y la documentación de protocolos:
- Contactos confirmados como realizados (vino=true)
- Ausencia de protocolo asociado (prp_id is null)
- Detección de brechas en documentación asistencial
- Evaluación de completitud del registro clínico

## Población objetivo:
- **Condición base**: Contactos con asistencia confirmada (`vino=true`)
- **Criterio exclusión**: Sin protocolo registrado (`prp_id is null`)
- **Periodo**: 1 enero 2025 al 26 julio 2025
- **Tipo de contacto**: Atenciones de profesionales clínicos específicos

## Fuente de datos:
- **Principal**: `omicolors_staging.ugi_hcc_contactos`
- **Complementaria**: `omicolors_staging.stk_personas`
- **Periodo análisis**: 1 enero 2025 - 26 julio 2025
- **Filtro temporal**: `fecha_contacto2 between '20250101' and '20250726'`

## Componentes del análisis:

### 1. Clasificación de estado de agendamiento
```sql
case 
    when a.cit_id is not null and a.pac_id is null     then 'Con agenda sin agendamiento'
    when a.cit_id is not null and a.pac_id is not null then 'Con agenda agendado'
    when a.cit_id is NULL                              then 'Sin agenda'
end as agendado
```

### 2. Clasificación de asistencia
```sql
case 
    when a.cit_id is not null and a.vino               then 'Asiste'
    when a.cit_id is not null and a.vino is false      then 'No asiste'
    when a.vino is null                                 then 'Sin control de asistencia'
end as asistencia
```

### 3. Clasificación de protocolo
```sql
case 
    when prp_id is not null then 'Con Protocolo'
    when prp_id is null     then 'Sin Protocolo'
end PROTOCOLO
```

### 4. Identificación de profesionales
```sql
where (medico or enfermera or nutricionista or kinesiologo or terapeuta_ocupacional 
       or matrona or odontologo or psicologa or trabajador_social)
```

## Criterios de inclusión:
1. **Fecha contacto**: Entre 1 enero 2025 y 26 julio 2025
2. **Profesional clínico**: Debe ser uno de los tipos específicos definidos
3. **Asistencia confirmada**: `vino = true`
4. **Sin protocolo**: `prp_id is null`

## Criterios de exclusión:
- Contactos fuera del rango de fechas especificado
- Contactos sin profesional clínico asignado
- Contactos donde el paciente no asistió (`vino = false` o `vino is null`)
- Contactos que ya tienen protocolo registrado (`prp_id is not null`)

## Resultado de la consulta:
La consulta retorna un **conteo único** (`count(*)`) de los contactos que cumplen los criterios especificados.

## Campos intermedios utilizados:
- **ESTADO**: Concatenación de AGENDADO + ASISTENCIA + PROTOCOLO
- **AGENDADO**: Estado del agendamiento de la cita
- **ASISTENCIA**: Estado de asistencia del paciente
- **PROTOCOLO**: Presencia o ausencia de protocolo registrado
- **centro**: Centro de atención (derivado de stk_personas)
- **profesional_clinico**: Nombre del profesional que atendió
- **cit_id**: Identificador de la cita
- **pac_id**: Identificador del paciente
- **con_per_id**: Identificador del profesional contactado
- **vino**: Indicador booleano de asistencia
- **prp_id**: Identificador del protocolo (null en casos analizados)

## Filtros aplicados:
```sql
WHERE a.fecha_contacto2 between '20250101' and '20250726' 
  AND (a.medico or enfermera or nutricionista or kinesiologo 
       or terapeuta_ocupacional or matrona or odontologo 
       or psicologa or trabajador_social)
  AND vino 
  AND prp_id is null
```

## Análisis de impacto:

### Implicaciones clínicas
- **Continuidad**: Pérdida de información para seguimiento
- **Calidad**: Indicador de completitud de registro
- **Legal**: Falta de respaldo documental de atención
- **Facturación**: Posibles inconsistencias en cobros

### Indicadores de calidad
- **Tasa de documentación**: % citas con protocolo completo
- **Brecha registro**: Diferencia agenda vs protocolos
- **Variabilidad**: Diferencias por centro/profesional
- **Tendencia temporal**: Evolución de la completitud

## Acciones correctivas sugeridas:
1. **Notificación**: Alertar a profesionales sobre registros pendientes
2. **Capacitación**: Reforzar importancia de documentación completa
3. **Validación**: Implementar controles automáticos de completitud
4. **Seguimiento**: Monitoreo regular de indicadores de calidad
5. **Mejora de procesos**: Optimizar flujos de registro clínico

## Aplicación administrativa
Esta consulta es útil para:
- Auditoría de calidad de registro clínico
- Identificación de brechas en documentación
- Evaluación de adherencia a protocolos institucionales
- Indicadores de gestión de calidad asistencial
- Mejora continua de procesos administrativos
- Capacitación del personal en registro completo
- Monitoreo de cumplimiento normativo

## Profesionales incluidos en el análisis:
La consulta incluye contactos con los siguientes tipos de profesionales:
- **Médico**: `medico = true`
- **Enfermera**: `enfermera = true`
- **Nutricionista**: `nutricionista = true`
- **Kinesiólogo**: `kinesiologo = true`
- **Terapeuta ocupacional**: `terapeuta_ocupacional = true`
- **Matrona**: `matrona = true`
- **Odontólogo**: `odontologo = true`
- **Psicóloga**: `psicologa = true`
- **Trabajador social**: `trabajador_social = true`

## Estructura de la consulta:
1. **Subconsulta interna**: Genera clasificaciones de estado
2. **Subconsulta intermedia**: Aplica filtros y une con datos de personas
3. **Consulta externa**: Realiza el conteo final
4. **Ordenamiento**: Por campo ESTADO (concatenado)

## Estado del desarrollo:
- **Fecha creación**: 28 julio 2025
- **Estado consulta**: Implementada y funcional
- **Archivo SQL**: Completo con lógica de conteo
- **Validación**: Lista para ejecución
- **Periodo analizado**: 1 enero - 26 julio 2025

## Archivos relacionados:
- `20250728 - Agenda vino igual SI sin protocolo OMI.sql`: Consulta SQL principal implementada

## Notas técnicas:
- La consulta utiliza joins con `stk_personas` para obtener información del centro y profesional
- Se maneja la precedencia de centro: si `a02.centro` es null, usa `a01.centro`
- El campo `fecha_contacto2` es el utilizado para el filtro temporal
- Se aplica `distinct` para evitar duplicados en la subconsulta interna
- El resultado final es un conteo numérico de registros que cumplen los criterios