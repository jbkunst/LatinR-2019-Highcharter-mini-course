# 
# Reiniciar sesión!!! 
# 
# Opción 1: Click en "Session", luego click en "Restart R"
# Opción 2: CTRL + SHIFT + F10 (apretar control, shift y f10)
# 
# Paquetes ----------------------------------------------------------------
library(highcharter)
library(tidyverse)
 
# Documentação ------------------------------------------------------------
# 
# https://api.highcharts.com/highcharts/
# 
# https://dantonnoriega.github.io/ultinomics.org/post/2017-04-05-highcharter-explainer.html
# 

data(citytemp)

citytemp_long <- citytemp %>% 
  gather(city, temp, -month) %>% 
  mutate(month = factor(month, month.abb))

citytemp_long

hc <- hchart(citytemp_long, "line", hcaes(month, temp, group = city))

hc


# titulo, subtitulo, créditos ---------------------------------------------
hc_title(hc, text = "Hello!")

hc_subtitle(hc, text = "Bye bye")

hc %>% 
  hc_title(text = "Hello!") %>% 
  hc_subtitle(text = "Bye bye") %>% 
  hc_credits(enabled = TRUE, text = "a important text link")

hc <- hc %>% 
  hc_title(text = "Hello!") %>% 
  hc_subtitle(text = "Bye bye") %>% 
  hc_credits(enabled = TRUE, text = "a important text link")

hc

hc %>% 
  hc_title(text = "Nuevo titulo")


# Axis --------------------------------------------------------------------
hc %>% 
  hc_xAxis(
    title = list(text = "Month in x Axis"),
    opposite = TRUE,
    plotLines = list(
      list(
        label = list(text = "This is a plotLine"),
        color = "#FF0000",
        width = 2,
        value = 5.5
        )
      )
    ) %>% 
  hc_yAxis(
    title = list(text = "Temperature in y Axis"),
    opposite = TRUE,
    minorTickInterval = "auto",
    minorGridLineDashStyle = "LongDashDotDot",
    plotBands = list(
      list(
        from = 25, to = 80, 
        color = "rgba(100, 0, 0, 0.1)",
        label = list(text = "This is a plotBand")
        )
      )
    )


# legend & exporting ------------------------------------------------------
hc %>% 
  hc_legend(
    align = "left", 
    verticalAlign = "top",
    layout = "vertical"
    ) %>%
  hc_exporting(enabled = TRUE) # "exporting option" :) muito bom recurso


# annotations -------------------------------------------------------------
df <- ggplot2movies::movies %>% 
  mutate(year = round(year/10)*10) %>% 
  count(year)

df

hchart(df, "area", hcaes(year, n)) %>% 
  hc_annotations(
    list(
      labels = list(
        list(point = list(x = 1940, y = 5157, xAxis = 0, yAxis = 0), text = "Arbois"),
        list(point = list(x = 1960, y = 5605, xAxis = 0, yAxis = 0), text = "Other Arbois?")
      )
    )
  )


# Importante: muuuuuuitas opções ------------------------------------------
# 
# https://api.highcharts.com/highcharts/
# 


# ALguien dijo ayuda? -----------------------------------------------------
?hc_legend

# - Siempre ? tendrá un ejemplo (espero!)
# - Siempre se ayudará de la docuemntación de la api en highcharts http://api.highcharts.com/highcharts#legend.
#   pues "basicamente" highcharter envia parámetros desde R al mundo javascript
# 



