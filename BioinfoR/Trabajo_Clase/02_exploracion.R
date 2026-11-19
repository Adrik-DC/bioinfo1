library(readr)

file.exists("data_raw/datos_sesion_02_blast/resultados_blast.tsv")
file.exists("data_raw/datos_sesion_02_blast/metadata_secuencias.csv")
file.exists("data_raw/datos_sesion_02_blast/secuencias.fasta")

rst_blast <- read_tsv("data_raw/datos_sesion_02_blast/resultados_blast.tsv")
sec_metadata <- read.csv("data_raw/datos_sesion_02_blast/metadata_secuencias.csv")
FASTA <- readLines("data_raw/datos_sesion_02_blast/secuencias.fasta")


cat('\n\nLas dimesiones del archivo resultados_blast.tsv son:',
    '\nFilas:', nrow(rst_blast), '\nColumnas:', ncol(rst_blast))
cat('\nCon columnas con nombres:') 
spec(rst_blast)
cat('\nCon query id:')
sort(table(rst_blast$query_id), decreasing = TRUE)
cat('\nFilas significativas (>= 90):')
rst_blast[rst_blast$pident >= 90,]
cat('\nLo que significa que hay una alineacion significativa y que es poco
    probable que las alineaciones hayan ocurrido por azar')


cat('\n\nLas dimesiones del archivo metadata_secuencias.csv son:',
    '\nFilas:', nrow(sec_metadata), '\nColumnas:', ncol(sec_metadata))
cat('\nCon columnas con nombres:') 
spec_csv("data_raw/datos_sesion_02_blast/metadata_secuencias.csv")
cat('\nCon query id:')
sort(table(sec_metadata$query_id), decreasing = TRUE)
cat('\nCon origenes:')
unique(sec_metadata$origen)

cat('\n\nEl archivo FASTA con longitud:', nrow(FASTA) )
cat('\nCon un total de encabezados:', length(grep('^>', FASTA, value = TRUE)),
    '\nEncabezados del archivo FASTA:') 
grep('^>', FASTA, value = TRUE)
                                   
cat('Ninguno de los archivos presenta NAs:', anyNA(FASTA), 
    anyNA(rst_blast),
    anyNA(sec_metadata))
