library(readr)
library(dplyr)
library(tidyr)
library(tibble)

ruta_blast <- ("data_raw/datos_sesion_02_blast/resultados_blast.tsv")
ruta_conteos <- ("datos_sesion_03_dplyr/conteos_genes.csv")
stopifnot(file.exists(ruta_blast), file.exists(ruta_conteos))

blast <- read_tsv(ruta_blast)
conteos <- read.csv(ruta_conteos)

#Seleccionar
blast %>% 
  select(-evalue)

#Filtrar | o &
blast %>%
  filter(
    query_id %in% c('seq01', 'seq02', 'seq03'))

#Arrange
blast %>%
  arrange(query_id, desc(length))

#Rename
blast %>%
  rename(
    "Porcentaje identidad" = pident,
    "longitud Al." = length
  )

#Distict
blast %>%
  distinct(query_id, subject_id)

#Mutate
blast %>%
  mutate(proporcion_identidad = pident/100)

blast %>%
  mutate(
    supera_90 = pident>=90,
    etiqueta = if_else(pident>=90, "90 o mas", "Menos de 90"))

#case_when
blast %>%
  mutate(
    grupo_did = case_when(pident>=95 ~ "Grupo A",
                          pident>=80 ~ "Grupo B",
                          TRUE ~ "Grupo C"
  )
  ) %>%
  count(grupo_did)

blast %>%
  count(query_id, sort = TRUE)

#group_by y summarise
resumen <- blast %>%
  group_by(query_id) %>%
  summarise(
    numero_alineamiento = n(),
    references_dist = n_distinct(subject_id),
    bitscore_max = max(bitscore),
    identidad_promedio = mean(pident),
    .groups = "drop"
  )
resumen

blast %>%
  group_by(query_id) %>%
  mutate(
    al_x_consulta = n(),
  )  %>%
  ungroup() %>%
  select(query_id, subject_id, al_x_consulta)

conteso_largos <- conteos %>%
  pivot_longer(cols = starts_with("muestra_"), names_to = "muestra",
                                  values_to = "conteos")
conteos_rec <- conteso_largos %>%
  pivot_wider(names_from = muestra, values_from = conteos)

if(!dir.exists("resultados")) dir.create("resultados")
write.csv(resumen, "resultados/03_resumen_blast.csv")

# EJERCICIOS

datos <- read.csv(
  "data_raw/expresion_genica_estres.csv",
)

glimpse(datos)

## 01

media_1 <- datos %>%
  group_by(gene_id, condicion) %>%
  summarise(media = mean(conteo, na.rm = TRUE), .groups = "drop") 
media_1  

# Checa esto --> 
razon_genes <- datos %>%
  group_by(gene_id, condicion) %>%
  summarise(media = mean(conteo, na.rm = TRUE), .groups = "drop") %>%
  mutate(media = media) %>%
  pivot_wider(names_from = condicion, values_from = media) %>%
  mutate(razon_estres_control = Estres / Control) %>%
  select(gene_id, razon_estres_control)
razon_genes


top5_genes <- datos %>%
  group_by(gene_id, funcion, condicion) %>%
  summarise(media = mean(conteo), .groups = "drop") %>%
  pivot_wider(names_from = condicion, values_from = media) %>%
  mutate(razon_estres_control = Estres / Control) %>%
  arrange(desc(razon_estres_control)) %>%
  slice_head(n = 5)
top5_genes

# 02

glimpse(datos)

media_2 <- datos %>%
  group_by(gene_id) %>%
  summarise(media = mean(conteo),
            .groups = "drop") %>%
  mutate(tot_media = media) %>%
  select(gene_id, tot_media) %>%
  arrange(desc(tot_media)) %>%
  slice_head(n = 15)
media_2

cat_fun <- datos %>%
    filter(gene_id %in% media_2$gene_id) %>%
    group_by(funcion) %>%
    summarise(
    n_distinct(funcion))
cat_fun
