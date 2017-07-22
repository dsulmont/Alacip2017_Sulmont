# Cargar la base de datos de la WVS:

load("WV6_Data_R_v_2016_01_01.rdata")

# Etiquetar variable

WV6_Data_R$V10[WV6_Data_R$V10 < 0] <- NA
WV6_Data_R$v10r <- factor(WV6_Data_R$V10, 
                          labels = c("Muy feliz", "Algo feliz", 
                                     "No muy feliz", "Nada feliz"))

# Seleccionar Perú y Uruguay

wvs_pyu <- subset(WV6_Data_R, V2 == 604 | V2 == 858)

# Tabla y gráfico de pregunta V10

wvs.t1 <- prop.table(table(wvs_pyu$v10r, wvs_pyu$V2),2)*100

wvs.t1

wvs.t1.df <- as.data.frame(wvs.t1)

wvs.t1.df$Var2 <- factor(wvs.t1.df$Var2, labels = c("Perú", "Uruguay"))

library(ggplot2)

ggplot(data = wvs.t1.df, aes(x = Var1, y=Freq, fill=Var2)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  xlab("Grado de felicidad")+ ylab("% entrevistados") +
  scale_fill_brewer(name = "Pais", palette = "Greys") +
  theme_bw() + 
  ggtitle("Grado de felicidad de los entrevistados, según país")

# Pregunta sobre crianza de los niños: Valor independencia (V12)

# Tabla por país y gráfico

WV6_Data_R$V12[WV6_Data_R$V12 < 0] <- NA

wvs.t2 <- prop.table(table(WV6_Data_R$V2, WV6_Data_R$V12),1)*100
wvs.t2

wvs.t2.df <- as.data.frame(wvs.t2)

wvs.t2.df

wvs.t2.df$pais <- factor(wvs.t2.df$Var1)

wvs.t2.df.a <- subset(wvs.t2.df, Var2 == 1)


ggplot(data = wvs.t2.df.a, aes(x = reorder(pais, Freq), y=Freq)) +
  geom_bar(stat = "identity") + coord_flip() + 
  theme(axis.text.y  = element_text(size=8))

# Cruzar V12 con posmaterialismo, para Perú

table(WV6_Data_R$Y002)

WV6_Data_R$postmat <- WV6_Data_R$Y002
WV6_Data_R$postmat[WV6_Data_R$postmat < 0] <- NA

WV6_Data_R$postmat <- factor(WV6_Data_R$postmat, 
                             labels = c("Materialista", "Mixto", "Posmaterialista"))

wvs.peru <- subset(WV6_Data_R, WV6_Data_R$V2 == 604)

prop.table(table(wvs.peru$V12, wvs.peru$postmat),2)*100

# Cruce: imaginación según posmaterialismo

prop.table(table(wvs.peru$V15, wvs.peru$postmat),2)*100

library(vcd)

assocstats(table(wvs.peru$V15, wvs.peru$postmat))
