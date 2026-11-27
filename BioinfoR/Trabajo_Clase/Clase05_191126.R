# Plot

library(ggplot2)
library(readr)
library(purrr)
library(dplyr)
library(readr)
    
metadata_riz <- read_csv(
  "data_raw/datos_rizosfera/metadata_rizosfera.csv"
)
generos_5 <- read_tsv("resultados/generos_5.tsv")
filos_5 <- read_tsv("resultados/filos_5.csv")
totales_muestra <- read_tsv("resultados/tot_muestras.tsv")

profundidad <- totales_muestra %>%
  left_join(
    metadata_riz %>%
      select(sample_id, host_name, country, crop_system),
    by = "sample_id",
    relationship = "one-to-one"
  )

stopifnot(!anyNA(profundidad$host_name))

glimpse(profundidad)

p_profundidad <- ggplot(profundidad, aes(x = sample_id, y = `tot_lec <- sum(conteo)`)) +
  geom_col(fill = "#367A90") +
  labs(title = "Conteos totales por muestra", x = "Muestra",
       y = "Lecturas contabilizadas") +
  theme_minimal(base_size = 12) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 6))
p_profundidad

#

ggplot(
  profundidad,
  aes(
    x = reorder(host_name, `tot_lec <- sum(conteo)`, FUN = median),
    y = `tot_lec <- sum(conteo)`
  )
) +
  geom_boxplot(fill = "#83B7C9") +
  scale_y_log10(labels = scales::label_comma()) +
  coord_flip() +
  labs(
    title = "Profundidad de lectura según la planta hospedera",
    x = "Planta hospedera",
    y = "Lecturas contabilizadas (escala logarítmica)"
  ) +
  theme_minimal(base_size = 12)

#
orden_filos <- c(
  sort(setdiff(unique(filos_5$taxon_final), "Filos < 5%")),
  "Filos < 5%"
)

orden_generos <- c(
  sort(setdiff(unique(generos_5$taxon_final), "Géneros < 5%")),
  "Géneros < 5%"
)

colores <- as.character(
  paletteer::paletteer_c("grDevices::ag_GrnYl", 30)
)

p_filos <- ggplot(filos_5,
                  aes(x = sample_id, y = abundancia_relativa, fill = taxon_final)) +
  geom_col(width = 0.9) +
  scale_fill_manual(values = colores,
                    breaks = orden_filos) +
  scale_y_continuous(labels = function(x) paste0(round(100 * x), "%")) +
  labs(title = "Composición taxonómica por filo",
       x = "Muestra", y = "Abundancia relativa", fill = "Filo") +
  theme_minimal(base_size = 12) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 6))
p_filos


###
hospederos_elegidos <- profundidad %>%
  count(host_name, name = "n_muestras", sort = TRUE) %>%
  arrange(desc(n_muestras), host_name) %>%
  slice_head(n = 3) %>%
  pull(host_name)

filos_seleccionados <- filos_5 %>%
  filter(host_name %in% hospederos_elegidos)

profundidad_seleccionada <- profundidad %>%
  filter(host_name %in% hospederos_elegidos)

hospederos_elegidos

p_filos_seleccionados <- ggplot(
  filos_seleccionados,
  aes(x = sample_id, y = abundancia_relativa, fill = taxon_final)
) +
  geom_col() +
  scale_fill_manual(values = colores,
                    breaks = orden_filos) +
  scale_y_continuous(labels = function(x) paste0(round(100 * x), "%")) +
  labs(title = "Composición por filo: hospederos seleccionados",
       x = "Muestra", y = "Abundancia relativa", fill = "Filo") +
  theme_minimal(base_size = 12) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 7))
p_filos_seleccionados

p_facet_wrap <- ggplot(filos_seleccionados,
                       aes(x = sample_id, y = abundancia_relativa, fill = taxon_final)) +
  geom_col() +
  scale_fill_manual(values = colores,
                    breaks = orden_filos) +
  facet_wrap(~ host_name, scales = "free_x") +
  scale_y_continuous(labels = function(x) paste0(round(100 * x), "%")) +
  labs(title = "Composición por filo según planta hospedera",
       x = "Muestra", y = "Abundancia relativa", fill = "Filo") +
  theme_minimal(base_size = 12) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 7))
p_facet_wrap
  
ggsave('figures/comp_fil_host.png', p_facet_wrap,
       width = 12,
       height = 7,
       units = 'in',
       dpi = 300)

###
hospederos <- metadata_riz %>%
  count(host_name) %>%
  filter(n >= 5) %>%
  pull(host_name)
hospederos

mas_5 <- generos_5 %>%
  filter(host_name %in% hospederos)
mas_5


p_5 <- ggplot(mas_5,
              aes(x = host_name, y = abundancia_relativa, 
                  fill = taxon_final)
) +
  geom_col() +
  scale_fill_manual(values = colores,
                    breaks = orden_filos) +
  scale_y_continuous(labels = function(x) paste0(round(100 * x), "%")) +
  labs(title = "Composición por Genero: hospederos seleccionados",
       x = "Muestra", y = "Abundancia relativa", fill = "Genero") +
  theme_minimal(base_size = 12) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 7))

p_5

