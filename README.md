# Reemplazo de valores nulos mediante modelo de regresión exponencial
Este proyecto de análisis de datos en R se centra en modelar la evolución de los salarios en el sector no registrado a lo largo del tiempo. El objetivo principal fue abordar un problema común en la ciencia de datos: la imputación de datos faltantes (NA), utilizando un enfoque de regresión robusto.

Descripción del Proyecto: Análisis y Modelado de Salarios en el Sector no Registrado 📊
Este proyecto de análisis de datos en R se centra en modelar la evolución de los salarios en el sector no registrado a lo largo del tiempo. El objetivo principal fue abordar un problema común en la ciencia de datos: la imputación de datos faltantes (NA), utilizando un enfoque de regresión robusto.

Metodología 📈
La variable de salario presentaba valores faltantes en los primeros 12 trimestres. Para imputar estos datos de manera precisa, se siguió una metodología de tres pasos:

Transformación Logarítmica: Se identificó una relación de crecimiento exponencial entre el tiempo y los salarios. Para modelarla con una regresión lineal, se aplicó una transformación logarítmica a la variable de salario, linealizando la relación.

Modelo de Regresión: Se ajustó un modelo de regresión lineal simple (lm()) a los datos disponibles. Este modelo demostró ser un predictor muy fuerte, con un R-cuadrado de 0.9277 y coeficientes altamente significativos, lo que confirma la validez del enfoque.

Imputación y Des-linearización: Se utilizó la ecuación del modelo linealizado para predecir los valores faltantes. Luego, se aplicó la transformación inversa (función exponencial, e^x
 ) para convertir las predicciones de nuevo a la escala original de salarios.
