# Sistema de Consultas Clínicas y Análisis Asistencial

## 📋 ¿Qué encontrará en este repositorio?

Este repositorio es una biblioteca de herramientas de análisis diseñada específicamente para profesionales clínicos y administradores de salud. Contiene consultas especializadas que le permitirán obtener información estratégica para la toma de decisiones clínicas y mejora de la calidad asistencial.

## 🎯 Objetivo Principal

Proporcionar herramientas de análisis que permitan a los equipos clínicos:
- **Identificar pacientes de riesgo** que requieren atención prioritaria
- **Evaluar la calidad** de los registros clínicos y procesos asistenciales  
- **Monitorear indicadores** de salud poblacional y continuidad de cuidados
- **Optimizar recursos** mediante análisis de demanda y utilización de servicios

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

- **`biancora.cubo_salud_sexual_y_reproductiva`**: Cubo de salud sexual y reproductiva
  - Registros de visitas domiciliarias integrales (VDI)
  - Protocolos prenatales y resultados EPSA
  - Seguimiento de atención materna integral

## 🏥 Áreas Clínicas Cubiertas

El repositorio está organizado por especialidades y casos de uso clínicos específicos:

### 🩺 **Enfermedades Crónicas y Comorbilidades**
- **Diabetes Mellitus**: Identificación de pacientes en etapas avanzadas de ERC
- **Enfermedad Renal Crónica**: Estratificación por estadios G3b, G4 y G5
- **ECICEP**: Pacientes elegibles para cuidados integrales continuos
- **Estratificación de Riesgo**: Comparación ACG vs evaluación clínica cualitativa

### 👶 **Salud Materno-Infantil**
- **Continuidad Prenatal**: Seguimiento VDI a EPSA
- **Métodos Anticonceptivos**: Monitoreo PBC P1 
- **Embarazadas de Riesgo**: Detección de consumo de sustancias
- **Protocolos de Atención**: Seguimiento de embarazadas en programas específicos

### 📊 **Gestión y Calidad Asistencial**
- **Completitud de Registros**: Detección de atenciones sin protocolo
- **Agenda y Asistencia**: Análisis de concordancia registro-atención
- **Interconsultas**: Monitoreo de derivaciones ginecológicas
- **Personal Médico**: Análisis de consultas por becados
- **Indicadores de Calidad**: Métricas de proceso y resultado

### 💊 **Farmacia y Tratamientos**
- **Aerocámaras e Inhaladores**: Prescripción y seguimiento
- **Medicamentos Crónicos**: Adherencia y dispensación
- **Protocolos Farmacológicos**: Seguimiento de tratamientos específicos

### 📞 **Comunicación y Seguimiento**
- **Datos de Contacto**: Actualización teléfonos y correos
- **Confirmación de Citas**: Sistemas de recordatorio
- **Direcciones**: Validación y actualización de domicilios

## 📈 **Casos de Uso Principales**

### Para Clínicos
- **Lista de Pacientes de Riesgo**: Identificación automática por patología y estadio
- **Seguimiento de Continuidad**: Análisis de adherencia a protocolos
- **Evaluación de Resultados**: Métricas de efectividad de intervenciones

### Para Administradores
- **Indicadores de Calidad**: Completitud de registros y procesos
- **Utilización de Recursos**: Análisis de demanda y capacidad
- **Planificación**: Proyecciones basadas en prevalencia y tendencias

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

### Documentación por Módulo
- **`20250726_pac_dm_etapa_3b_4_5_smartinez.md`**: Documentación ERC avanzada
- **`documentacion_VDI_a_EPSA.md`**: Documentación salud reproductiva VDI-EPSA
- **`documentacion_sql.md`**: Documentación técnica legacy
- **`CLAUDE.md`**: Guía para desarrollo asistido por IA

## 🗂️ **Organización por Años y Requerimientos**

### **2025 - Consultas Actuales** (50+ consultas especializadas)
Incluye análisis avanzados de:
- **Programas ECICEP**: Identificación y seguimiento de pacientes complejos
- **Calidad de Registros**: Detección de brechas en documentación
- **Continuidad de Cuidados**: Análisis de adherencia a protocolos
- **Estratificación de Riesgo**: Validación de algoritmos ACG

### **2020-2024 - Archivo Histórico** (200+ consultas)
Base de conocimiento con:
- **Evolución de Indicadores**: Tendencias históricas de calidad
- **Metodologías Validadas**: Consultas probadas en el tiempo
- **Casos de Referencia**: Ejemplos de implementación exitosa

## ⚕️ **Aplicación en la Práctica Clínica**

### **Para Médicos y Enfermeras**
- **Lista de Pacientes Prioritarios**: Genere automáticamente listas de pacientes que requieren atención inmediata según criterios clínicos
- **Seguimiento de Comorbilidades**: Identifique pacientes diabéticos con deterioro renal que necesitan derivación a nefrología
- **Evaluación de Adherencia**: Monitoree el cumplimiento de protocolos de atención por parte de sus pacientes

### **Para Matronas y Obstetras**
- **Continuidad Prenatal**: Verifique que todas las embarazadas tengan seguimiento completo desde VDI hasta EPSA
- **Detección de Riesgo**: Identifique embarazadas con consumo de sustancias o factores de riesgo
- **Planificación Familiar**: Monitoree el uso de métodos anticonceptivos en población objetivo

### **Para Administradores y Jefes de Servicio**
- **Indicadores de Calidad**: Mida la completitud de registros clínicos y adherencia a protocolos
- **Gestión de Recursos**: Analice demanda de consultas especializadas y optimice la programación
- **Reportes Gerenciales**: Genere informes automáticos para la toma de decisiones estratégicas

## 🔒 Consideraciones de Privacidad

⚠️ **ALERTA DE SEGURIDAD**: Este repositorio contiene referencias a datos personales identificables que requieren atención inmediata.

### Estado Actual
- **CRÍTICO**: Múltiples archivos contienen datos no anonimizados
- Se encontraron RUTs, nombres y datos de contacto reales
- Requiere limpieza completa antes de uso en producción

### Mejores Prácticas Implementadas
- Uso de identificadores únicos (`pac_id`) en scripts principales
- Documentación de técnicas de anonimización
- Guías para desarrollo seguro de consultas

📋 **Ver**: `ANONIMIZACION.md` para guía completa de mejores prácticas y corrección de problemas de privacidad.

## 🚀 **Cómo Comenzar**

### **Paso 1: Identifique su necesidad clínica**
- ¿Necesita identificar pacientes de riesgo específicos?
- ¿Requiere evaluar la calidad de sus registros clínicos?
- ¿Desea analizar indicadores de su servicio?

### **Paso 2: Busque en el repositorio**
- Navegue por los directorios organizados por año (2025 para lo más actual)
- Revise las carpetas por especialidad clínica
- Cada consulta incluye documentación detallada en formato `.md`

### **Paso 3: Adapte a su contexto**
- Las consultas están diseñadas para ser reutilizables
- Modifique fechas, centros y criterios según su necesidad
- Consulte la documentación técnica para entender cada campo

### **Ejemplo Práctico**
Para obtener pacientes diabéticos en riesgo renal:
1. Vaya a `2025/20250726 - listado pacientes con etapa erc 3b 4 y 5/`
2. Revise la documentación `.md` para entender los criterios
3. Ejecute la consulta `.sql` adaptando el centro médico
4. Obtenga su lista de pacientes prioritarios

## 📋 **Estructura de Cada Requerimiento**

Cada consulta incluye:
- **Archivo SQL**: Consulta ejecutable lista para usar
- **Documentación MD**: Explicación detallada del objetivo y criterios
- **README** (en algunos casos): Guía específica de implementación

## 🤝 **Solicitar Nuevas Consultas**

Si requiere una consulta específica que no está disponible:
1. Defina claramente el objetivo clínico
2. Especifique la población objetivo y criterios de inclusión/exclusión
3. Indique los campos de salida requeridos
4. Proporcione el contexto de uso (informes, seguimiento, etc.)

## 📞 **Soporte y Contacto**

- **Consultas técnicas**: Equipo de análisis de datos clínicos
- **Validación clínica**: Profesionales médicos del equipo
- **Nuevos requerimientos**: A través de los canales institucionales establecidos

---

📍 **Nota**: Este repositorio contiene más de 250 consultas especializadas desarrolladas entre 2020-2025, representando años de experiencia en análisis de datos clínicos y mejora de la calidad asistencial.