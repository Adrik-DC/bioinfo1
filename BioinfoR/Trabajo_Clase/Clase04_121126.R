library(purrr)
library(dplyr)
library(readr)

metada_pat <- ("data_raw/datos_sesion_02_blast/metadata_secuencias.csv")
blast_pat <- ("data_raw/datos_sesion_04_integracion/blast_muestras/muestra_A.tsv")
blast_c_pat <- ("data_raw/datos_sesion_04_integracion/blast_muestras/muestra_C.tsv") 
blast_b_pat <- ("data_raw/datos_sesion_04_integracion/blast_muestras/muestra_B.tsv")

metadata <- read.csv(metada_pat)
blast_A <- read_tsv(blast_pat, col_types = cols(codigo_muestra = col_character(), 
                                                .default = col_guess()))
blast_A_con_metadata <- blast_A %>%
  left_join(metadata, by = "query_id")

blast_B <- read_tsv(blast_b_pat, col_types = cols(codigo_muestra = col_character(), 
                                                .default = col_guess()))

blast_C <- read_tsv(blast_c_pat, col_types = cols(codigo_muestra = col_character(), 
                                        .default = col_guess()))
blast_C_con_metadata <- blast_C %>%
  left_join(metadata, by = "query_id")
blast_C %>%
  anti_join(metadata, by = "query_id")

blast_C %>% full_join(metadata, by = "query_id") %>%
  select("query_id", "subject_id", "organismo") %>%
  arrange("query_id")

blast_total <- bind_rows(
  muestra_A = blast_A,
  muestra_B = blast_B,
  muestra_C = blast_C,
  .id = "muestra"
)

blast_total %>%
  count(muestra)

###

meta <- read.csv('data_raw/datos_rizosfera/metadata_rizosfera.csv')
con_tax <- read_tsv('data_raw/datos_rizosfera/conteos_taxonomia_rizosfera.tsv')

glimpse(con_tax)
glimpse(meta)

meta %>%
  count(host_name, sort = TRUE)

niveles <- c(
  "kingdom", "phylum", "class", "order",
  "family", "genus", "species"
)

conteos_limpios <- con_tax %>%
  mutate(
    across(
      all_of(niveles),
      ~ na_if(sub("^[a-z]__", "", .x), "")
    )
  )

conteos_limpios %>%
  select(taxon_id, all_of(niveles)) %>%
  head()

ids_muestras <- meta$sample_id

stopifnot(
  !anyDuplicated(ids_muestras),
  all(ids_muestras %in% names(conteos_limpios))
)

conteos_largos <- conteos_limpios %>%
  pivot_longer(
    cols = all_of(ids_muestras),
    names_to = "sample_id",
    values_to = "conteo"
  )

datos_riz <- conteos_largos %>%
  left_join(
    meta %>% select(sample_id, host_name, country, year),
    by = "sample_id",
    relationship = "many-to-one"
  )

tot_muestras <- datos_riz %>%
  group_by(sample_id) %>%
  count(conteo) %>%
  summarise(
    tot_lec <- sum(conteo),
    .groups = 'drop'
  )

write_tsv(tot_muestras, 'resultados/tot_muestras.tsv')

# Calcular y agrupar abundancias relativas por nivel taxonómico
#
# Agrega los conteos taxonómicos por muestra y hospedero, calcula la abundancia
# relativa y agrupa los taxones poco abundantes (por debajo de un umbral dado)
# en una categoría residual. Los valores faltantes o vacíos se etiquetan como
# `"Sin clasificar"`.

preparar_abundancias <- function(tabla, nivel = "genus", umbral = 0.05) {
  
  # 1. Validar input
  niveles_validos <- c(
    "kingdom", "phylum", "class", "order",
    "family", "genus", "species"
  )
  
  stopifnot(
    nivel %in% niveles_validos,
    is.numeric(umbral), length(umbral) == 1,
    !is.na(umbral), umbral >= 0, umbral <= 1
  )
  
  # 2. Definición de la etiqueta
  porcentaje <- umbral * 100
  etiqueta_otros <- if (nivel == "phylum") {
    paste0("Filos < ", porcentaje, "%")
  } else if (nivel == "genus") {
    paste0("Géneros < ", porcentaje, "%")
  } else {
    paste0("Taxones < ", porcentaje, "%")
  }
  
  # 3. Limpieza, cálculo y colapso
  tabla %>%
    # Estandarizar valores NA o vacíos en el nivel elegido
    mutate(
      taxon = .data[[nivel]],
      taxon = if_else(is.na(taxon) | taxon == "",
                      "Sin clasificar", taxon)
    ) %>%
    # Sumar conteos por muestra, hospedero y taxón
    group_by(sample_id, host_name, taxon) %>%
    summarise(conteo = sum(conteo), .groups = "drop") %>%
    # Calcular proporción respecto al total de cada muestra
    group_by(sample_id) %>%
    mutate(abundancia_relativa = conteo / sum(conteo)) %>%
    ungroup() %>%
    # Reasignar taxones debajo del umbral a la categoría residual
    mutate(
      taxon_final = if_else(
        abundancia_relativa < umbral,
        etiqueta_otros,
        taxon
      )
    ) %>%
    # Escribir la abundancia de los taxones
    group_by(sample_id, host_name, taxon_final) %>%
    summarise(
      abundancia_relativa = sum(abundancia_relativa),
      .groups = "drop"
    )
}

# --- Ejemplos de ejecución ---
generos_5  <- preparar_abundancias(datos_riz, "genus", 0.05)
filos_5    <- preparar_abundancias(datos_riz, "phylum", 0.05)
familias_1 <- preparar_abundancias(datos_riz, "family", 0.01)

filos_5 %>% head()

write_tsv(generos_5, 'resultados/generos_5.tsv')
write_tsv(generos_5, 'resultados/filos_5.csv')
