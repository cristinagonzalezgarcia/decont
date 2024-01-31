# This script should download the file specified in the first argument ($1),
# place it in the directory specified in the second argument ($2),
# and *optionally*:
# - uncompress the downloaded file with gunzip if the third
#   argument ($3) contains the word "yes"
# - filter the sequences based on a word contained in their header lines:
#   sequences containing the specified word in their header should be **excluded**
#
# Example of the desired filtering:
#
#   > this is my sequence
#   CACTATGGGAGGACATTATAC
#   > this is my second sequence
#   CACTATGGGAGGGAGAGGAGA
#   > this is another sequence
#   CCAGGATTTACAGACTTTAAA
#
#   If $4 == "another" only the **first two sequence** should be output

#Verificar que el archivo no esta vacio:

#!/bin/bash
if [ "$#" -lt 2 ]; then
	echo "Usage: $0 <url> <output_directory> [yes/no] [filter_keyboard]"
	exit 1
fi

url="$1"
output_directory="$2"
uncompress="$3"
filter_keyboard="$4"

#1. Crear directorio si no existe:
mkdir -p "$output_directory"

#2. Descargar la carpeta

curl -o "$output_directory/$(basename "$url")" "$url"

#3. Descomprimir la carpeta

if [ "$uncompress" == "yes" ]; then
	gunzip "$output_directory/$(basename "$url")" 
fi

#4. Filtrar

if [ -n "$filter_keyboard" ] ; then
	grep -v "$filter_keyboard" "$output_directory/$(basename "$url")" > "$output_directory/filtered_$(basename "$url")"
fi

