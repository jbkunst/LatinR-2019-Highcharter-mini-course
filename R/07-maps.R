# 
# Reiniciar sesión!!! 
# 
# Opción 1: Click en "Session", luego click en "Restart R"
# Opción 2: CTRL + SHIFT + F10 (apretar control, shift y f10)
# 
# Paquetes ----------------------------------------------------------------
library(tidyverse)
library(highcharter)


# Exemplo motivacional ----------------------------------------------------
# 
# - http://jkunst.com/blog/posts/2017-01-05-thematic-interactive-map/
# - http://jkunst.com/blog/posts/2016-12-15-interactive-and-styled-middle-earth-map/
# 

# Documentação ------------------------------------------------------------
# 
# http://jkunst.com/highcharter/highmaps.html
# 
# https://code.highcharts.com/mapdata/
# 

# example 1 ---------------------------------------------------------------
hcmap("countries/br/br-all")

hcmap("countries/cl/cl-all")

hcmap("countries/ar/ar-all")

hcmap("countries/pe/pe-all", showInLegend = FALSE)


# example 2 ---------------------------------------------------------------
example_data <- get_data_from_map(download_map_data("countries/cl/cl-all"))

example_data 

# se deja hc-a2 pues es la llave que une la informacion con el mapa
example_data <- example_data %>% 
  select(`hc-a2`, `woe-name`, name) %>% 
  mutate(medida = 100 * runif(n()))

example_data

hcmap("countries/cl/cl-all", data = example_data, value = "medida",
      name = "Importante valor", dataLabels = list(enabled = TRUE, format = '{point.name}'))

mapa <- hcmap(
  "countries/cl/cl-all",
  data = example_data, 
  value = "medida", # nombre de la columna numerica!! a mostrar
  name = "Importante valor"
  ) %>% 
  hc_tooltip(valueDecimals = 2, valuePrefix = "$", valueSuffix = "MM")

mapa <- mapa %>% 
  hc_colorAxis(minColor = "white", maxColor = "red")

mapa

mapa <- mapa %>%
  hc_colorAxis(
    dataClasses = color_classes(0:5*20)
    ) %>% 
  hc_legend(
    layout = "vertical", 
    align = "right",
    floating = TRUE,
    valueDecimals = 0,
    valueSuffix = "%"
    ) 

mapa



# example 3 ---------------------------------------------------------------
# http://openflights.org/data.html
airports <- read_csv("https://raw.githubusercontent.com/jpatokal/openflights/master/data/airports.dat", col_names = FALSE)
airports <- airports %>%
  filter(X4 == "Brazil") %>% 
  select(nombre = X2, lon = X8, lat = X7)

airports

hcmap("countries/br/br-all", showInLegend = FALSE) %>% 
  hc_add_series(
    data = airports, 
    type = "mappoint",
    name = "Airports",
    tooltip = list(pointFormat = "{point.nombre}")
    ) 


example_data2 <- get_data_from_map(download_map_data("countries/br/br-all"))
example_data2
example_data2 <- example_data2 %>% 
  select(`hc-a2`, `woe-name`, name) %>% 
  mutate(medida = 100 * runif(n()))

example_data2

brmap <- hcmap("countries/br/br-all", data = example_data2, value = "medida",
      name = "Importante valor", dataLabels = list(enabled = TRUE, format = '{point.name}'))

brmap

brmap2 <- brmap %>% 
  hc_add_series(
    data = airports,
    type = "mappoint",
    color = "red",
    name = "Airports",
    tooltip = list(pointFormat = "{point.nombre}")
  )

brmap2


# Zoom?
brmap2 %>% 
  hc_chart(zoomType = "xy") %>% 
  hc_mapNavigation(
    enabled = TRUE,
    enableMouseWheelZoom = TRUE
    )


# Exercícios --------------------------------------------------------------
# 
# Do messmo para America del Sur:
# 
# 1. See Ameria del Sur "demo" in https://code.highcharts.com/mapdata/ ("custom/south-america"):
#    - Agregue datos ficticios
#    - Agregue titulo, subtitulo, legenda
#    - Agregue nueva paleta de colores minColor, maxColor 
#    - Add a "hc_theme_db" theme
# 
# 2. A "mapa", el mapa de chile ya creadi, agregar los aeropuertos :D, para que? No sé, para hacerlo :D
# 