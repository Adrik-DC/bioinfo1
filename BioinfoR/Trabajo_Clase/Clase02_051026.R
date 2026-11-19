
sec = 'ATCGAGTC'

longitud_dna <- function(sec){
  longitud = nchar(sec)
  print(longitud)
  }

print(longitud_dna(sec))

contiene_motivo <- function(secuencia, motivo) {
  grepl(motivo, secuencia, fixed = TRUE)
}

contiene_motivo("ATGCGTAA", "CGT")

empieza_con <- function(secuencia, prefijo){
  startsWith(secuencia, prefijo)
}

empieza_con('ATGCGT', 'CGT')

preparar_secuencia <- function(secuencia, tipo='DNA', mayusculas=TRUE){
  if (mayusculas){
    secuencia <- toupper(secuencia)
  }
  if (tipo == 'RNA'){
    secuencia <- chartr('T', 'U', secuencia)
  }
  secuencia
}

preparar_secuencia('atcgatcg', tipo = 'RNA')

resumir_dna <- function(id, secuencia){
  secuencia = toupper(secuencia)
  longitud = nchar(secuencia)
  conteo.g = 0
  conteo.t = 0
  if (grepl('U', secuencia, fixed = TRUE) == TRUE) {
  tipo = 'Es RNA'
    } else {
  tipo = 'Es DNA'
    }
  conteo.g = (length(strsplit(sec, "G")[[1]]) -1)
  conteo.t = (length(strsplit(sec, "T")[[1]]) -1)
  conteo.gc = (conteo.g + conteo.t)/longitud
  
  list(id = id, tipo = tipo, longitud = longitud, 
       Guanina = conteo.g, Timina = conteo.t, promedio = conteo.gc)
}
chain <- resumir_dna('EPAS1', 'TTGG')
chain

validad_dna <- function(secuencia){
  # 1. Validar que sea un solo elemento de texto y que no sea NA
  if (!is.character(secuencia) || 
      length(secuencia) != 1 || 
      is.na(secuencia)) {
    stop('Se requiere una secuencia valida')
  }
  
  # 2. Convertir a mayúsculas
  secuencia <- toupper(secuencia)
  
  # 3. Validar caracteres (Asegúrate de que 'secuencia' esté al final)
  if (!grepl('^[ACGT]+$', x = secuencia)) {
    stop('Se requiere una secuencia valida')
  }
  
  return(TRUE)
}

# Prueba que debe fallar (y lanzar el stop 'Se requiere una secuencia valida')
validad_dna('huhh')

# Prueba que debe funcionar
validad_dna('ACGTACGT')

revisar_secuencias <- function(secuencias) {
  # Creamos el vector de resultados lógico (FALSE) de longitud n
  resultado <- logical(length(secuencias))
  
  for (i in seq_along(secuencias)) {
    # Extraemos la secuencia i y la guardamos en secuencia temporalmente
    secuencia <- secuencias[i]
    
    if (is.na(secuencia)) {
      # si es vacía asignamos FALSE
      resultado[i] <- FALSE
    } else {
      # si no es vacía, verificamos que silo contenga A, C, G o T
      resultado[i] <- grepl("^[ACGT]+$", toupper(secuencia))
    }
  }
  
  resultado
}

secuencias <- c("ATGCGT", "ACNTGA", "ttacga", NA)

revisar_secuencias(secuencias)

clasificar_sec <- function(secuencias) {
  if (!is.character(secuencias)) {
    stop("El argumento debe ser un vector de tipo caracter")
  }
  
  es_valida <- sapply(secuencias, revisar_secuencias)
  
  validas <- secuencias[es_valida & !is.na(es_valida)]
  invalidas <- secuencias[!es_valida | is.na(es_valida)]
  
  return(list(validas = validas, invalidas = invalidas))
}


clasificar_sec(c("ATGCGT", "ACNTGA", "ttacga", NA))

  


