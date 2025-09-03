library(lubridate)
library(dplyr)
#MODIFICAR EL FORMATO DE LA FECHA------------------
indice_salarios <- indice_salarios %>%  #salarios en base al 100% en 2016
  mutate(
    periodo = dmy(periodo),
    año = year(periodo),
    mes = month(periodo),
    trimestre = case_when( #armar los trimestres
      mes %in% c(1, 2, 3)  ~ 1,
      mes %in% c(4, 5, 6)  ~ 2,
      mes %in% c(7, 8, 9)  ~ 3,
      mes %in% c(10, 11, 12) ~ 4
    ),
    tiempo = año + (trimestre -1)/4)

indice_salarios <- indice_salarios[,-c(1,7,8,9,11)] #eliminar las columnas irrelevantes

#VISUALIZAR DATOS (NA)--------------
plot(indice_salarios$tiempo,indice_salarios$IS_total_registrado,type="l")
head(indice_salarios$IS_sector_no_registrado) #faltan datos

#REGRESION PARA MODELAR SALARIOS (NA)----------------------
#si x = ln(y) entonces e^x= y
plot(indice_salarios$tiempo,log(indice_salarios$IS_sector_no_registrado),type="l")
df <- indice_salarios[-c(1:12),]
modelo <- lm(log(df$IS_sector_no_registrado) ~ df$tiempo) #modelo linealizado
summary(modelo) #alto R^2(92%) y bajo p-valor

#REVISAR SUPUESTOS de REGRESION-----------------
library(lmtest)
dwtest(modelo) # Test de Durbin-Watson (posible autocorrelación)
bptest(modelo) #no hay heterocedasticidad
shapiro.test(resid(modelo)) #p-v >0.05 no se puede rechazar la hipotesis de normalidad de residuos

#REEMPLAZAR VALORES NA------------------
salario <-function(x){exp(-835.59+0.4164*x)} #Deslinearizo la funcion
años <-indice_salarios$tiempo[1:12]
prediccion <- as.numeric(años)
for (i in 1:12){                            #utilizo el modelo para aproximar valores de NA
  pred <- salario(años[i])
  prediccion[i] <-pred
}
head(prediccion)
#---------
indice_salarios$IS_sector_no_registrado[1:12] <- prediccion #reemplazo el sector
indice_salarios$IS_indice_total[1:12] <- (indice_salarios$IS_total_registrado[1:12]+indice_salarios$IS_sector_no_registrado[1:12])/2

#VISUALIZAR DATOS COMPLETOS---------------------------
plot(indice_salarios$tiempo,
     indice_salarios$IS_indice_total,
     xlab = "tiempo",
     ylab= "indice salarios total",
     main= "evolución salarios en el tiempo",
     col= "darkblue",
     type="l")
grid()
curve(salario,add=TRUE,
      col="darkred",lwd=1.5)
