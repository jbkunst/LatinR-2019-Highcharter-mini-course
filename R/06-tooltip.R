# 
# Reiniciar sesión!!! 
# 
# Opción 1: Click en "Session", luego click en "Restart R"
# Opción 2: CTRL + SHIFT + F10 (apretar control, shift y f10)
# 
# Paquetes ----------------------------------------------------------------
library(highcharter)
library(tidyverse)
library(datos)


# MIRA!!! -----------------------------------------------------------------
options(highcharter.theme = hc_theme_ggplot2())


# Documentação ------------------------------------------------------------
# 
# https://api.highcharts.com/highcharts/tooltip
# 

# Ejemplo motivacional ----------------------------------------------------
# 
# - http://jkunst.com/blog/posts/2017-03-03-giving-a-thematic-touch-to-your-interactive-chart/
# - http://jkunst.com/blog/posts/2016-03-08-pokemon-vizem-all/

# Datos -------------------------------------------------------------------
data(citytemp)

citytemp_long <- citytemp %>% 
  gather(city, temp, -month) %>% 
  mutate(month = factor(month, month.abb))

hc <- hchart(citytemp_long, "line", hcaes(month, temp, group = city)) %>% 
  hc_title(text = "Titulo") %>% 
  hc_subtitle(text = "interesante subtitulo")

hc


# Comenzando --------------------------------------------------------------
hc %>% 
  hc_tooltip(
    crosshairs = TRUE,
    backgroundColor = "lightgray",
    shared = TRUE,
    borderWidth = 5,
    valueSuffix = "º celcius",
    valuePrefix = "$"
    )

# https://api.highcharts.com/highcharts/tooltip.crosshairs
# https://api.highcharts.com/highcharts/tooltip.backgroundColor
# https://api.highcharts.com/highcharts/tooltip.shared
# https://api.highcharts.com/highcharts/tooltip.borderWidth
# https://api.highcharts.com/highcharts/tooltip.valuePrefix
# https://api.highcharts.com/highcharts/tooltip.valueSuffix

hc %>% 
  hc_tooltip(
    split = TRUE,
    style = list(fontSize = "1.3em")
  )

# https://api.highcharts.com/highcharts/tooltip.split

hc %>% 
  hc_tooltip(
    table = TRUE,
    sort = TRUE
    )



# Medium ------------------------------------------------------------------
paises2 <- paises %>% 
  filter(max(anio) == anio)

hcpaises <- hchart(
  paises2,
  "point",
  hcaes(pib_per_capita, esperanza_de_vida, z = poblacion, group = continente)
)

hcpaises

# Some tweaks
hcpaises <- hcpaises %>% 
  hc_xAxis(type = "logarithmic") %>% 
  hc_plotOptions(series = list(minSize = 3, maxSize = 50))

hcpaises


hcpaises # ???!!!!???!!!!

# Now see ?tooltip_table 
# Access the data with: "{point.variable}", exemplo: "{point.country}"

?tooltip_table

glimpse(paises)


x <- c("pais", "pib_per_capita", "esperanza_de_vida", "poblacion")
y <- str_c("{point.", x, "}")
x <- str_replace_all(x, "_", " ")

tt <- tooltip_table(x, y)

hcpaises <- hcpaises %>% 
  hc_tooltip(pointFormat = tt, useHTML = TRUE,
             headerFormat = "",  crosshairs = TRUE)

hcpaises

# Advanced ----------------------------------------------------------------
# 
# Exemplo motivacional
# 
# - http://jkunst.com/blog/posts/2019-02-04-using-tooltips-in-unexpected-ways/
# 
paises3 <- paises %>% 
  select(pais, x = anio, y = esperanza_de_vida) %>% 
  nest(-pais) %>% 
  rename(ttdata = data) %>% 
  mutate(ttdata = map(ttdata, list_parse))

paises2 <- left_join(paises2, paises3, by = "pais")

ttchart <- tooltip_chart("ttdata", width = 350, height = 250)

hcpaises3 <- hchart(
  paises2, "point",
  hcaes(pib_per_capita, esperanza_de_vida,  z = poblacion, group = continente, name = pais)
) %>% 
  hc_tooltip(
    headerFormat = "<b>{point.key}</b>",
    pointFormatter = ttchart, useHTML = TRUE
  ) %>% 
  hc_plotOptions(series = list(maxSize = 30)) %>% 
  hc_xAxis(type = "logarithmic")

hcpaises3

# https://jsfiddle.net/gh/get/library/pure/highcharts/highcharts/tree/master/samples/highcharts/yaxis/labels-format/

hcpaises3 %>%
  hc_tooltip(
    useHTML = TRUE,
    pointFormatter = tooltip_chart(accesor = "ttdata")
    ) %>% 
  hc_plotOptions(series = list(minSize = 3, maxSize = 50)) %>% 
  hc_yAxis(labels = list(format = "${value}"))


