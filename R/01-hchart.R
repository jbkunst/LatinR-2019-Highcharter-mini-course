# 
# Reiniciar sesión!!! 
# 
# Opción 1: Click en "Session", luego click en "Restart R"
# Opción 2: CTRL + SHIFT + F10 (apretar control, shift y f10)
# 
# Paquetes ----------------------------------------------------------------
library(highcharter)
library(datos)

# recordar que podemos cambiar el tema
options(highcharter.theme = hc_theme_ggplot2())


# Documentación -----------------------------------------------------------
# 
# http://jkunst.com/highcharter/hchart.html
# 
# Contexto ----------------------------------------------------------------
# 
# plot is a generic (magical) funcion.
# 
# What it means "generic"? A generic function will do 
# an action depending of the "argument" (objetc class)
# 
# For example:
# 

# Densidades
x <- rnorm(1000)
x

d <- density(x)
plot(d)

# Time series
data(AirPassengers)
plot(AirPassengers)

# 
# Una función
# 

# hchart ------------------------------------------------------------------
# 
# hchart is a generic function too! :)
# 
# Densidades
hchart(d)

# time series
hchart(AirPassengers)

# Numerics
x <- rgamma(3000, 2, 4)
x
hchart(x)

# Character
millas
hchart(millas$fabricante)

# Factor (ordenados!)
diamantes
hchart(diamantes$corte, color = "red")

# Matrix & correlations
data(volcano)
hchart(volcano)

# Exercícios --------------------------------------------------------------
# 
# 1. Graficar los datos "USAccDeaths".
#    (semelhante ao exemplo de Airpassengers)
# 

# 
# 2. Obter uma matriz de correlacions con los datos "mtcars"
#    usando la función "cor", luego use hchart. Luego interpretar!
# 
