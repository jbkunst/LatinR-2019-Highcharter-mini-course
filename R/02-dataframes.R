# 
# Reiniciar sesión!!! 
# 
# Opción 1: Click en "Session", luego click en "Restart R"
# Opción 2: CTRL + SHIFT + F10 (apretar control, shift y f10)
# 
# Paquetes ----------------------------------------------------------------
library(highcharter)
library(dplyr)
library(ggplot2)
library(datos)

# recordar que podemos cambiar el tema
options(highcharter.theme = hc_theme_smpl())

# Documentação ------------------------------------------------------------
# 
# https://cran.r-project.org/web/packages/highcharter/vignettes/charting-data-frames.html
# 

# Contexto ----------------------------------------------------------------
# 
# ggplot2
# 
# ggplot uses geom and aesthetics
# 
data(economics_long, package = "ggplot2")

glimpse(economics_long)

ggplot(economics_long) +
  geom_line(aes(x = date, y = value01, color = variable))

# GEOM / capa
ggplot(economics_long) +
  geom_point(aes(x = date, y = value01, color = variable))


# highcharter -------------------------------------------------------------
# 
# Version I
# 
hchart(economics_long, "line", hcaes(x = date, y = value01, group = variable))

# 
# Version II
# 
highchart() %>% 
  hc_add_series(economics_long, "line", hcaes(x = date, y = value01, group = variable)) %>% 
  hc_xAxis(type = "datetime")

# ?!?! %>%?!! não importa, então vamos falar sobre isso 

# Adicionar mais de um conjunto de dados ----------------------------------
# 
glimpse(mtcars)

mtcars <- arrange(mtcars, mpg, disp)

dados_cyl_4 <- filter(mtcars, cyl == 4)
dados_cyl_6 <- filter(mtcars, cyl == 6)
  
highchart() %>% 
  hc_add_series(dados_cyl_4, "scatter", hcaes(mpg, disp), color = "red", name = "cyl2")

highchart() %>% 
  hc_add_series(dados_cyl_6, "scatter", hcaes(mpg, disp), color = "red", name = "cyl2") %>% 
  hc_add_series(dados_cyl_4, "line", hcaes(mpg, disp), color = "blue", name = "cyl4")

# 
# Mas mejor usando hchart :)
# 
hchart(mtcars, type = "scatter", mapping = hcaes(mpg, disp, group = cyl)) 


# exemplo mais divertido --------------------------------------------------
# 
if(!require(broom)) install.packages("broom")
library(broom)

modlss <- loess(disp ~ mpg, data = mtcars)
fit <- arrange(augment(modlss), mpg)

fit

fit <- fit %>% 
  mutate(
    low_fit = .fitted - 1.96*.se.fit,
    high_fit = .fitted + 1.96*.se.fit
  )

fit

highchart() %>% 
  hc_add_series(mtcars, "scatter", hcaes(mpg, disp, group = cyl)) 

highchart() %>% 
  hc_add_series(mtcars, "scatter", hcaes(mpg, disp, group = cyl)) %>% 
  hc_add_series(fit, "spline", hcaes(x = mpg, y = .fitted), name = "Fit")

highchart() %>% 
  hc_add_series(mtcars, "scatter", hcaes(mpg, disp, group = cyl)) %>% 
  hc_add_series(fit, "spline", hcaes(x = mpg, y = .fitted), name = "Fit") %>% 
  hc_add_series(fit, "arearange", hcaes(x = mpg, low = low_fit, high = high_fit),
                color = hex_to_rgba("gray", 0.01), name = "confidence")

hchart(fit, "arearange", hcaes(x = mpg, low = low_fit, high = high_fit),
       color = hex_to_rgba("gray", 0.01), name = "confidence")



# otros tipos de gráficos -------------------------------------------------
millasc <- millas %>% 
  count(clase)


# 
# forma explìcita:
# 
hchart(
  object = millasc,
  type = "line",
  hcaes(x = clase, y = n)
  )

hchart(millasc, "line", hcaes(x = clase, y = n), name = "Clases")

hchart(millasc, "column", hcaes(x = clase, y = n), color = "darkblue")

hchart(millasc, "bar", hcaes(x = clase, y = n), pointWidth = 1)



# Exercícios --------------------------------------------------------------
# 
# 1. Con los siguientes datos, para los datos `flores` o  `iris`
# realice un diagrama de puntos usando el largo y ancho de pétalo
flores
iris

# 
# 2. Realiza el mismo gráfico anterior pero que los puntos se coloreen por la especie
# 

# 
# 3. Usando los ejemplo de "millasc" use el tipo "pie"
# 


# 
# 4. Usando los ejemplo de "millasc" use el tipo "treemap". La diferencia es que en lugar
#    de "y" se deb usar "value"
# 


#
# 5. Con los datos "paises":
#   - Selecciones los registros del último año disponible
#   - Con la tabla anterior genere un grafico de puntos donde muestre la relacion
#     entre pib per capita y la esperanza de vida. Ademàs considere el tamaño del punto
#     como la poblaciòn del pais, y agrupe por contiente
#   - Comenta que observas
#   - ¿Qué podemos mejorar del gráfico?

