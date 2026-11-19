archivo_blast <- ("C:/Users/Adrik/OneDrive/Documentos/Mate/Estadistica/BioinfoEst/data_raw/datos_sesion_02_blast/blast_comentarios.tsv")
readLines(archivo_blast, n = 5)

blast <- read.delim('data_raw/datos_sesion_02_blast/resultados_blast.tsv')
metadata <- read.csv('data_raw/datos_sesion_02_blast/metadata_secuencias.csv', 
                     colClasses = c(codigo_muestra = "character"))
head(metadata)

library(readr)

blast <- readr::read_tsv('data_raw/datos_sesion_02_blast/resultados_blast.tsv')

readLines('data_raw/datos_sesion_02_blast/blast_comentarios.tsv')
blast_comentarios <- readr::read_tsv('data_raw/datos_sesion_02_blast/blast_comentarios.tsv', 
                                     comment = '#', show_col_types = FALSE)
blast_comentarios

blast_NA <- readr::read_tsv('data_raw/datos_sesion_02_blast/blast_valores_faltantes.tsv',
                    na = c('','NA'),
                    show_col_types = FALSE)
anyNA(blast_NA)

str(blast)
str(blast_NA)

readr::spec(blast)
readr::problems(blast)

blast_error <- read_tsv(
  I('Secuencia\tidentidad
    seq1\t98.2
    seq2\t90
    seq3\terror'
    ),
  col_types = cols(
    secuencia = col_character(),
    identidad = col_double()
  )
)
blast_error
problems(blast_error)

nrow(blast)
ncol(blast)
names(blast)

grepl('seq01', blast$query_id)
blast[blast$query_id == 'seq01',]
blast[blast$pident >= 90,]

unique(blast$query_id)
sort(blast$query_id, decreasing = TRUE)
sort(table(blast$query_id), decreasing = TRUE)

colSums(is.na(blast))


# 

blast_resultados <- readr::read_tsv('data_raw/datos_sesion_02_blast/resultados_blast.tsv',
                            show_col_types = FALSE)
readr::spec(blast_resultados)
nrow(blast_resultados)
nrow(blast_resultados) * 4

unique(blast_resultados$query_id)
sort(table(blast_resultados$query_id), decreasing = TRUE)

blast_resultados[blast_resultados$pident >= 95,]

anyNA(blast_resultados)

#Usar un separador incorrecto
ruta <- 'data_raw/datos_sesion_02_blast/blast_separador_incorrecto.csv'
mal <- readr::read_csv(ruta)
head(mal)
bien <- readr::read_tsv(ruta, show_col_types = FALSE)
head(bien)

#Ver en que columnas hay NA's
blast_na <- readr::read_tsv('data_raw/datos_sesion_02_blast/blast_valores_faltantes.tsv')
colSums(is.na(blast_na))

#Elementos duplicados
anyDuplicated(blast_na)
anyDuplicated(blast_na$query_id)

# FASTA
lineas <- readLines("data_raw/datos_sesion_02_blast/secuencias.fasta")
grep('^>', lineas, value = TRUE)
length(grep('^>', lineas, value = TRUE))
