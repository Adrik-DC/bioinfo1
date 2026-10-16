# Versiones

clustalo --version	--> 	1.2.4
mafft --version		--> 	v7.526 (2024/Apr/26)
muscle -version		--> 	MUSCLE v3.8.1551 by Robert C. Edgar
trimal --version 	-->	trimAl 1.2rev59

# Diferencias

Huvo distintas diferencias, principalmente debido a la diferencia de contenido, por ejemplo, rspo
tenia 17 secuencias mientras que lgr 50, por lo que en lgr habia factores mas largos como la 
longitud del alineamiento y la cantidad de residuos y la identidad promedio donde rspo era de 
37~38% y en lgr de 28~29%. En la comparacion entre metodos en lgr los valores de [ALL] de manera
drastica, salvo en SP que solo disminuye un poco en el caso de lgr, en los demas si hay una 
disminucion drastica, columa = de 64.5% a 27.2%, y en, tc = de 44.4% a 12.1%, debido a que la 
probabilidad de que las columnas se muevan con 50 lecuras es menor que con 17. Otro cambio 
importante es que en el acuerdo de regiones podemos ver como lgr vuelve a caer en coincidencias, 
en rspo teniamos alrededor de 37 pares que concordaban por lectura con un aproximado de 35 ~ 40%
de concordancia y como o menciono antes en lgr se desploma a ~5 pares concordantes con un 9 ~ 14%.
Tambien al revisar la tabla de columnas de Clustal Omega > 0.5 observamos que en rspo el acuerdo 
entre FU1+FU2 y enlace son los mas altos en un intervalo de 0.96 a 0.99 mientras que en lgr los 
mayoresson entre 0.96 y 0.61 que coriresponden a LRR y 7TM.
 
# Usar .dnd?

No es algo recomendado, debido a que el .dnd es solo un arbol guia, no tiene la robustez 
estadistica necesaria, lo mejor seria usar el arbol filogeneticoreal
