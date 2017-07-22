# Usar Datos LAPOP 2014

load("lapop14.Rdata")

# Etiquetar países

table(lapop14$pais)

paises14 <- c("Mexico", "Guatemala","El Salvador","Honduras", "Nicaragua", "Costa Rica",
            "Panama", "Colombia", "Peru", "Paraguay", 
            "Uruguay", "Brazil","Dominican Republic","Haití",
            "Jamaica", "Guyana", "Trinidad and Tobago", "Belize", "Suriname", "Bahamas",
            "Barbados")

lapop14$country <- factor(lapop14$pais, labels = paises14)


# Tabla de victimización por país

prop.table(table(lapop14$country, lapop14$vic1ext),1)*100

# Tabla de confianza en los tribunales del país

library(Rmisc)

summarySE(data = lapop14, measurevar = "b1", groupvars = "country", na.rm = T)

# Tabla anterior según zona urbana / rural

summarySE(data = lapop14, measurevar = "b1", groupvars = c("country","ur"), na.rm = T)

# Tabla recodificada de B1 y B3 para Perú y Uruguay

## Recodificar variables

table(lapop14$b1)
table(lapop14$b3)

library(car)

lapop14$b1.r <- recode(lapop14$b1, "1:3 = 1; 4=2; 5:7=3")
lapop14$b3.r <- recode(lapop14$b3, "1:3 = 1; 4=2; 5:7=3")

lapop14$b1.r <- factor(lapop14$b1.r, labels = c("Bajo", "Medio", "Alto"))
lapop14$b3.r <- factor(lapop14$b3.r, labels = c("Bajo", "Medio", "Alto"))

## Seleccionar casos para Perú

lapop14.pe <- subset(lapop14, country == "Peru")

## Tabla de b1 y b3 para Perú

tab1 <- table(lapop14.pe$b1.r, lapop14.pe$b3.r)

prop.table(tab1, 2)*100

## Medidas de asociación

library(vcd)
library(vcdExtra)

chisq.test(tab1)

assocstats(tab1)

GKgamma(tab1)


