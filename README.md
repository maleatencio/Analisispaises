# Análisis de Economía, Energía y Medio Ambiente

Este proyecto consiste en un **análisis exploratorio y visual de un dataset global** que combina variables económicas, energéticas y ambientales de diferentes países. El objetivo es identificar patrones entre ingresos, plantas de energía y emisiones de CO₂.

---

## 📂 Contenido del repositorio

- `script_analisis.R` : Script en R que realiza la limpieza de datos, análisis estadístico y visualizaciones.  
- `README.md` : Este archivo con la descripción del proyecto.  
- [Opcional] `dataset.csv` : Dataset utilizado (si no es muy grande; de lo contrario, incluir instrucciones para descargarlo).

---

## 🛠 Herramientas y librerías

- **Lenguaje:** R  
- **Librerías principales:**  
  - `tidyverse` (manipulación y visualización de datos)  
  - `dplyr` (manipulación de datos)  
  - `ggplot2` (gráficos)  
  - `mosaic` (estadísticas descriptivas)  
  - `corrplot` (matrices de correlación)  
  - `psych` (estadísticas y densidad)

---

## 🔍 Análisis realizado

1. **Limpieza de datos:**  
   - Imputación de datos faltantes: media, mediana y moda según tipo de variable.  
   - Identificación y tratamiento de outliers usando el rango intercuartílico (IQR).

2. **Exploración de variables categóricas:**  
   - Frecuencia de continentes.  
   - Distribución de niveles de ingresos por continente.  
   - Gráficos de barras apiladas y agrupadas.

3. **Análisis de variables cuantitativas:**  
   - Número de plantas de energía por continente.  
   - Porcentaje de energía renovable y boxplots por grupos (Bajo, Medio, Alto).  
   - Ingreso per cápita: histogramas, densidad, asimetría y curtosis.  
   - Relación entre ingreso per cápita y emisiones de CO₂ (scatter plot y matriz de correlación).

---

## 📊 Resultados e insights

- Se identificaron patrones entre **ingresos, energía renovable y número de plantas de energía** por continente.  
- Existe una **relación positiva/negativa** (según los resultados de correlación) entre **GDP per cápita y emisiones de CO₂**.  
- Las visualizaciones permiten observar claramente diferencias entre continentes y niveles de ingreso.  

---

## ⚡ Uso del proyecto

1. Clonar el repositorio:  
   ```bash
   git clone https://github.com/tuusuario/proyecto_analisis_datos.git
