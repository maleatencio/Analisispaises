# Cargar bibliotecas necesarias
library(tidyverse)
library(dplyr)
library(mosaic)

# Cargar los datos
library(readr)
datos <- read_csv("C:/Users/renee/Downloads/environment_economy_dataset (1).csv")
View(environment_economy_dataset_1_)
 datos
 
totalIsna <- sum(is.na(datos))
mean(is.na(datos))
colSums(is.na(datos))

#imputacion de datos faltantes
#cuanti: media o mediana
#cuali: moda

datos$gdp_per_capita[is.na(datos$gdp_per_capita)] <- median(datos$gdp_per_capita, na.rm = TRUE)

datos$income_level[is.na(datos$income_level)] <- as.character(names(sort(table(datos$income_level), decreasing = TRUE))[1])           


#punto 2
table(datos$continent)

### GRAFICO DE BARRAS
# Frecuencia absoluta
library(ggplot2)
ggplot(data = datos, aes(x = continent)) + 
  geom_bar(fill = "lightblue", color = "white") + 
  ggtitle("Mayor representacion de continente") + 
  xlab("Continentes") + 
  ylab("Numero de paises x continente") +   
  theme(axis.text.x = element_text(angle = 90))

###### TABLAS DE CONTINGENCIA
# Tabulando la frecuencia absoluta entre las variables 'continente' y 'ingresos'
table(datos$continent, datos$income_level)

### Gráfico barras apiladas
ggplot(data = datos, mapping = aes(x = continent, fill = income_level)) +
  stat_count(position = "fill") +
  theme_bw() + ggtitle("Ingresos por continente") + 
  xlab("Continente") + 
  ylab("Proporcion ingresos") +   
  theme(axis.text.x = element_text(angle = 90))

## Barras agrupadas
ggplot(data = datos, mapping = aes(x = continent, fill = income_level)) +
  geom_bar(position = "dodge") +
  ggtitle("Ingresos por continente") + 
  xlab("Genre") + 
  ylab("Number of Films") +   
  theme(axis.text.x = element_text(angle = 90))

#continente, platas de energia
# Aplicar favstats para cada continente
favstats(number_of_power_plants ~ continent, data = datos)

avg_plants_per_continent <- datos %>%
  group_by(continent) %>%
  summarise(avg_plants = mean(number_of_power_plants, na.rm = TRUE))%>%
  arrange(desc(avg_plants))


datos %>%
  group_by(continent) %>%
  summarise(avg_plants = mean(number_of_power_plants, na.rm = TRUE)) %>%
  ggplot(aes(x = reorder(continent, -avg_plants), y = avg_plants)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Promedio de Plantas de Energía por Continente", x = "Continente", y = "Promedio")


# Gráfico de barras de plantas de energía (no obligatorio)
ggplot(datos, aes(x = number_of_power_plants)) + 
  geom_bar(fill = "lightblue", color = "white") + 
  ggtitle("Número de plantas de energía") + 
  xlab("Plantas de energía") + 
  ylab("Cantidad de países") +   
  theme(axis.text.x = element_text(angle = 90))


# f) Comparación de plantas de energía por energía renovable
datos$renewable_group <- cut(datos$renewable_energy_pct,
                            breaks = c(-Inf, 20, 50, Inf), 
                            labels = c("Bajo", "Medio", "Alto"))

summary(datos$renewable_group) # cantidad de países en cada grupo de energ renov


# Gráfico de plantas de energía por grupo de energía renovable
ggplot(datos, aes(x = renewable_group, y = number_of_power_plants)) +
  geom_boxplot() +
  labs(title = "Plantas de Energía por Porcentaje de Energía Renovable", x = "Energía Renovable", y = "Número de Plantas")
## Excluyendo los NA
ggplot(datos %>% filter(!is.na(renewable_group)), aes(x = renewable_group, y = number_of_power_plants)) +
  geom_boxplot() +
  labs(title = "Plantas de Energía por Porcentaje de Energía Renovable", x = "Energía Renovable", y = "Número de Plantas")


#ingresos x capita


summary(datos$gdp_per_capita)

library(mosaic)
favstats(~gdp_per_capita, data = datos) # Observar media y mediana

####### Histograma
ggplot(data=datos, aes(x=gdp_per_capita)) + 
  geom_histogram(fill="lightblue", color="white") + 
  ggtitle("Distribution of Audience Scores") +
  xlab("Audience Score") + 
  ylab("Frequency")


# O bien:
library(psych)
ggplot(datos, aes(x = gdp_per_capita)) +
  geom_histogram(aes(y = ..density..), bins = 30, fill = "skyblue", color = "black") +
  geom_density(color = "red", size = 1.2) +
  stat_function(fun = dnorm, args = list(mean = mean(datos$gdp_per_capita, na.rm = TRUE),
                                         sd = sd(datos$gdp_per_capita, na.rm = TRUE)),
                color = "blue", linetype = "dashed", linewidth = 0.8)+
  ggtitle("Distribucion del Ingreso per Cápita",
          subtitle = paste("Asimetría:", round(skew(datos$gdp_per_capita, na.rm = TRUE),2),
                           "|Curtosis:", round(kurtosi(datos$gdp_per_capita, na.rm = TRUE),2)))+
  xlab("Ingreso per cápita (USD)")+
  ylab("Densidad")

# Verificar visualmente valores extremos
ggplot(datos, aes(y = gdp_per_capita)) +
  geom_boxplot(fill = "lightgreen") +
  labs(title = "Boxplot del Ingreso per Cápita", y = "Ingreso per cápita (USD)")

# Calcular límites usando el rango intercuartílico
Q1 <- quantile(datos$gdp_per_capita, 0.25, na.rm = TRUE)
Q3 <- quantile(datos$gdp_per_capita, 0.75, na.rm = TRUE)
IQR_value <- Q3 - Q1

# Definir límites
lower_bound <- Q1 - 1.5 * IQR_value
upper_bound <- Q3 + 1.5 * IQR_value

# Filtrar datos sin outliers
data_no_outliers <- datos %>%
  filter(gdp_per_capita >= lower_bound, gdp_per_capita <= upper_bound)
nrow(data_no_outliers)

# Resumen sin outliers
favstats(~gdp_per_capita, data = data_no_outliers)

ggplot(data_no_outliers, aes(x = gdp_per_capita)) +
  geom_histogram(aes(y = ..density..), bins = 30, fill = "skyblue", color = "black") +
  geom_density(color = "red", size = 1.2) +
  stat_function(fun = dnorm, args = list(mean = mean(data_no_outliers$gdp_per_capita, na.rm = TRUE),
                                         sd = sd(data_no_outliers$gdp_per_capita, na.rm = TRUE)),
                color = "blue", linetype = "dashed", linewidth = 0.8)+
  ggtitle("Distribucion del Ingreso per Cápita sin NA",
          subtitle = paste("Asimetría:", round(skew(data_no_outliers$gdp_per_capita, na.rm = TRUE),2),
                           "|Curtosis:", round(kurtosi(data_no_outliers$gdp_per_capita, na.rm = TRUE),2)))+
  xlab("Ingreso per cápita (USD)")+
  ylab("Densidad")

# h) Relación entre ingreso per cápita y emisiones de co2
correlation <- cor(datos$gdp_per_capita, datos$co2_emissions, use = "complete.obs")
print(correlation)
# O bien:
# Seleccionar filas con datos solo para gdp_per_capita y co2_emissions
data_subset <- datos %>%
  select(gdp_per_capita, co2_emissions) 

cor_matrix <- cor(data_subset, use = "complete.obs")
print(cor_matrix)

# Gráfico de dispersión 
ggplot(datos, aes(x = gdp_per_capita, y = co2_emissions)) +
  geom_point() +
  labs(title = "Relación entre ingreso per cápita y Emisiones de CO2", x = "Ingreso per cápita", y = "Emisiones de CO2")

# Grafico de correlación
library(corrplot)
corrplot(cor_matrix, method = "color", type = "upper", 
         tl.cex = 0.8, tl.col = "black", addCoef.col = "black")
# O bien directamente:
corrplot(cor_matrix)


ggplot(datos, aes(x = gdp_per_capita, y = co2_emissions)) +
  geom_point(alpha = 0.6, color = "steelblue") +
  geom_smooth(method = "lm", se = FALSE, color = "red", linewidth = 1) +
  labs(
    title = "Relación entre Ingreso per Cápita y Emisiones de CO₂",
    x = "Ingreso per cápita (USD)",
    y = "Emisiones de CO₂ (toneladas per cápita)"
  ) +
  theme_minimal()

