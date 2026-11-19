#
#
#

cat('hola mundo')



R.version.string
Sys.info()[['sysname']]

'ggplot2' %in% rownames(installed.packages())
'CRAN' %in% rownames(installed.packages())
install.packages('CRAN')

packageVersion('ggplot2')
packageVersion('dplyr')

id <- 'gen_101'
class(id)

cm <- 10L
class(cm)

typeof(cm)
str(cm)
str(id)

as.numeric('2')

genes = c('Ga', 'Gb', 'Gc')
genes[2]

lon <- c(10, 150, 102)

lon  / 3

sum(lon>=100)

#Ejercicio

ids <- c('g1','g2','g3','g4','g5')
tam <- c(90, 450, 310, 120, 600)

ids[3]
ids[tam>=300]
sum(tam>=300)

conteos <- matrix(
c(12,8,4,6,10,2),
nrow = 3,
dimnames = list(c('g1', 'g2', 'g3'), c('M1', 'M2'))
)

array1 <- array(1:8, dim = c(2,2,2))

ant <- data.frame(gen = c('g1', 'g2', 'g3'), 
                  lng = c(450, 120, 800), 
                  prod = c('transp', 'hip', 'enzimas'))

muestra<- list(
  id = 'M01',
  sec = c('ATCG', 'CCCC'),
  anotaciones = 'anotaciones'
)

condicion <- factor(c("control", "tratamiento", "control"),
                    levels = c("control", "tratamiento"))
levels(condicion)

sig_letras <- factor(c('A', 'M', 'A', 'B', 'M', 'M', 'B', 'A', 'B', 'B'), 
                     levels = c('Alto', 'Medio', 'Bajo'))
levels(sig_letras)

sec <- 'ATCGATCG'
longitud <- nchar(sec)

if (longitud >= 10) {
  print('La secuencia es menor a 10 de longitud')
}

conteo = NA

if (is.na(conteo)) {
  print('Es NA')
} else if (conteo < 0) {
  print('El conteo es menor a 0')
} else if (conteo == 0) {
  print('El conteo es exactamente 0')
} else {
  print('El conteo es mayor a 0')
}

conteos <- c(0, 12, 4, 0, 25)

estado <- ifelse(conteos > 0, "Detectado", "No detectado")
estado

any(conteos == 0)
which(conteos == 0)

for (i in 1:5){
  print(i)
}

secuencias = c('AAAATTTTCG', 'CCGGAT', 'CATCATGGCATGGCAT')
longi = numeric(length(secuencias))
longi

for (i in seq_along(secuencias)){
  longi[i] <- nchar(secuencias[i])
}

secuencias <- c("ATG", "ATGCGT", "AATTCCGG", "CG")
for (i in seq_along(secuencias)){
  longi[i] <- nchar(secuencias[i])
  l <- ifelse(longi[i] < 5, "Cadena corta", "Cadena Larga")
  print(l)
}

n = 0

while (n<10) {
  print(n)
  n = n+1
}

secuencia <- c('')
i = 1
  
  while (i<=8) {
    secuencia <- paste0(strrep("A", 1), secuencia)
    print(secuencia)
    i = i+1
  }


