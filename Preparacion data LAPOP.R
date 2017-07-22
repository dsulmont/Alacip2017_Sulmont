# INSTRUCCIONES:
# 1) Cambiar el nombre de la BD en SPSS de Lapop a: "Lapop_04_14.sav"
# 2) Cargar el paquete "haven", si no lo tiene deberá instalarlo desde un CRAN

library(haven)

3) Ejecutar el comando que importa el archivo SPSS al R (puede tomar varios minutos)

Lapop_04_14 <- read_sav("Lapop_04_14.sav")

4) Grabar el data frame en formato R:

save(Lapop_04_14, file = "Lapop_04_14.Rdata")

## Subconjunto Lapop 2014

lapop14 <- subset(Lapop_04_14, year == 2014)

save(lapop14, file = "lapop14.Rdata")
