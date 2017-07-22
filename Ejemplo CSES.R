# Cargar la base de datos del módulo 3 del CSES:

load("cses3.rdata")

# Identificar missing values

## Ingresos 

table(cses3$C2020)
cses3$C2020[cses3$C2020 == 7] <- NA

## Izquierda - derecha

table(cses3$C3013)
cses3$C3013[cses3$C3013 > 10] <- NA

## Preferencia por candidato A

table(cses3$C3010_A)
cses3$C3010_A[cses3$C3010_A > 10] <- NA

# Voto según ingresos en México y Perú

t1.mx <- xtabs(~ C3023_PR_1 + C2020, data = subset(cses3, cses3$C1004 == "MEX_2006"))

prop.table(t1.mx, 2)*100


t1.pe <- xtabs(~C3023_PR_1 + C2020, data = subset(cses3, cses3$C1004 == "PER_2011"))

prop.table(t1.pe, 2)*100

# Voto según izquierda - derecha en México y Perú

library(Rmisc)

summarySE(data = subset(cses3, cses3$C1004 == "MEX_2006"),
          measurevar = "C3013", groupvars = "C3023_PR_1", na.rm = T)

summarySE(data = subset(cses3, cses3$C1004 == "PER_2011"),
          measurevar = "C3013", groupvars = "C3023_PR_1", na.rm = T)


# Correlación entre la ideología del votante y la preferencia por el candidato

cor.test(cses3$C3010_A[cses3$C1004 == "PER_2011"], 
         cses3$C3013[cses3$C1004 == "PER_2011"], use = "complete.obs")

cor.test(cses3$C3010_A[cses3$C1004 == "MEX_2006"], 
         cses3$C3013[cses3$C1004 == "MEX_2006"], use = "complete.obs")
