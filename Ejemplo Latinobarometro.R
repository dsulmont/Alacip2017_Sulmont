# Cargar la base de datos

load("Latinobarometro_2015_Esp.rdata")

# Renombrar el data frame para que sea más práctico usarlo:

latbar15 <- Latinobarometro_2015_Esp

# Ejercicio 1: Democracia Churchil

## Etiquetar variable

table(latbar15$P13ST.A)
latbar15$p13st.a <- latbar15$P13ST.A
latbar15$p13st.a[latbar15$p13st.a == - 1] <- NA
latbar15$p13st.a <- factor(latbar15$p13st.a, labels = c("MA", "A", "ED", "MD"))

## Seleccionar Peru y Uruguay

table(latbar15$idenpa)

latbar15.pyu <- subset(latbar15, idenpa == 604 | idenpa == 858)

## Tabla democracia Churchil según país

t1 <- prop.table(table(latbar15.pyu$p13st.a, latbar15.pyu$idenpa),2)*100
t1

## Gráfico

t1.df <- as.data.frame(t1)
t1.df

t1.df$Var2 <- factor(t1.df$Var2, labels = c("Perú", "Uruguay"))

library(ggplot2)

ggplot(t1.df, aes(x=Var1, y=Freq, fill=Var2)) + 
  geom_bar(stat = "identity", position = position_dodge()) +
  xlab("Nivel de acuerdo") + ylab("% entrevistados") +
  scale_fill_brewer(name = "Pais", palette = "Greys") +
  theme_bw() + 
  ggtitle("Grado de acuerdo con la frase: La democracia puede \ntener problemas, pero es el mejor sistema de gobierno")


## Tabla por sexo del entrevistado

prop.table(xtabs(~p13st.a+idenpa+S12, data = latbar15.pyu),2)*100


# Ejercicio 2: Escala de democracia

table(latbar15$P17STGBS)

latbar15$esc.dem <- latbar15$P17STGBS

latbar15$esc.dem[latbar15$esc.dem < 0] <- NA

library(Rmisc)

t2 <- summarySE(data = latbar15, measurevar = "esc.dem", groupvars = "idenpa", na.rm = T )
t2
t2$idenpa <- factor(t2$idenpa)

ggplot(data  = t2, aes(x = reorder(idenpa, esc.dem),  y = esc.dem)) + 
  geom_point() + geom_errorbar(aes(ymin = esc.dem - ci, ymax= esc.dem+ci )) +
  coord_flip()
