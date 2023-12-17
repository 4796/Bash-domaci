#!/bin/bash



#da li ima

if [ "$#" -eq 0 ]; then

  echo "Greška: Morate uneti argument."

  exit

fi



#help

if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then

  echo "Skripta klasifikuje fajlove po velicini u folderu koji je prosledjen kao argument"

  echo "Potrebno je uneti adresu kao argument"

  exit

fi



#validna putanja

if [ ! -e "$1" ]; then

  echo "Greška: Prosleđeni argument nije validna putanja."

  exit

fi



putanja="$1"



mali_fajlovi=()

srednji_fajlovi=()

veliki_fajlovi=()



# kroz fajlove 

for fajl in "$putanja"/*; do

  if [ -f "$fajl" ]; then

    velicina=$(du -b "$fajl" | cut -f1)

    if [ "$velicina" -le 1000 ]; then

      mali_fajlovi+=("$fajl")

    elif [ "$velicina" -le 1000000 ]; then

      srednji_fajlovi+=("$fajl")

    else

      veliki_fajlovi+=("$fajl")

    fi

  fi

done



# Ispis 

echo "Small files:"

for fajl in "${mali_fajlovi[@]}"; do

  echo "$fajl"

done



echo -e "\nMedium files:"

for fajl in "${srednji_fajlovi[@]}"; do

  echo "$fajl"

done



echo -e "\nLarge files:"

for fajl in "${veliki_fajlovi[@]}"; do

  echo "$fajl"

done