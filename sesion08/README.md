Blastp version: blastp: 2.16.0+ Package: blast 2.16.0, build Nov 27 2024 09:40:57
seqkit version: 2.10.1

# Candidatos

dlaeveM00000132191
dlaeveM00000134217
dlaeveM00000308285
dlaeveM00000351276
dlaeveM00000441839
dlaeveM00000727719

# Ejercicio 8 

awk -F'\t' '$2=="dlaeveM00000909458"' hits.tsv | cut -f1,3,11,13 | column -t
LGR5|human|NP_003658.1                            26.593  8.39e-14  43
LGR5|human|NP_003658.1                            30.734  2.60e-12  43
LGR5|mollusc|Pomacea_canaliculata|XP_025085505.1  25.895  6.65e-10  31
LGR5|mollusc|Bradybaena_similaris|BFZ05148.1      26.620  1.04e-15  31
LGR5|mollusc|Bradybaena_similaris|BFZ05148.1      25.397  5.74e-10  31
LGR6|human|NP_001017403.1                         26.796  3.50e-14  40
LGR6|human|NP_001017403.1                         30.093  2.45e-09  40
LGR6|mollusc|Pomacea_canaliculata|XP_025085505.1  25.895  6.65e-10  31
LGR6|mollusc|Bradybaena_similaris|BFZ05148.1      26.620  1.04e-15  31
LGR6|mollusc|Bradybaena_similaris|BFZ05148.1      25.397  5.74e-10  31
RXFP1|mollusc|Magallana_gigas|XP_011430344.3      29.048  2.99e-08  18
 
# Explicacion

La babosa tiene 2 receptores LGR4 en los cromosomas 6 y 10 y en cuanto al gen dlaeveM00000909458
 auqnue tenga un un E-value que a simple vista parece funcionar, realmente es solo un estadistico
que nos dice que la coincidencia no es totalmente al azar, pero viendo vendo otros parametros los
alineamientos tuvieron identidades bajas (25 ~ 30%) y coberturas parciales (31 ~ 43%). Con los 
datos anteriores tal vez sugieran una probabilidad de que sea un receptor LGR, pero no tenemos
la evidencia para definirlo de manera inequivoca como un ortologo de LGR5.

# Datos

Los datos fueron copiados de: /mnt/data/bioinfo1/jmiranda/sesion08/datos/*
curl -s "https://rest.uniprot.org/uniprotkb/P23945.fasta"        # FSHR humano
curl -s "https://rest.uniprot.org/uniprotkb/search?query=gene:LGR5+AND+reviewed:true&format=fasta"
