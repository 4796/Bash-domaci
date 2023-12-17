#!/bin/bash



# Provera postojanja fajla "lista.info"

if [ ! -e "lista.info" ]; then

  echo -e "Ime   Indeks" > "lista.info"

  #touch lista.info

fi



# -h

show_help() {

  echo "Skripta za evidentiranje poena koje su studenti ostvarili javljanjem na casu"

  echo "Opcije:"

  echo "  se    Unos novog studenta"

  echo "  -l    Ispisuje broj javljanja svakog studenta"

  echo "  -r    Brisanje sadržaja fajla lista.info"

  echo "  -h, --help    Prikazi ovu poruku"

  exit

}



# upis novog studenta

add_student() {

  echo "Ime i prezime:"

  read ime_prezime

  echo "Indeks:"

  read indeks

  echo "$ime_prezime $indeks" >> "lista.info"

  echo "Student dodat u listu."

}



# ispis broja javljanja 

list_students() {

  echo "BROJ POENA     IME     INDEKS"

  prviRed=$(head -n 1 "lista.info")

 

  if [ "$prviRed" == "Ime   Indeks" ];  then

      tail -n +2 "lista.info" | sort | uniq -c | awk '{print $1, $2, $3, $4}' | sort -k1,1nr

    else

      sort "lista.info" | uniq -c | awk '{print $1, $2, $3, $4}' | sort -k1,1nr

      

      fi

  

  

}



# brisanje sadržaja fajla "lista.info"

reset_list() {

  > "lista.info"

  echo "Sadržaj fajla lista.info je obrisan."

  exit

}







#  -h

if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then

  show_help

  exit

fi



# scenariji

case "$1" in

  -l)

    list_students

    ;;

  -r)

    reset_list

    ;;

  se)

    add_student

    ;;

  *)

  echo "Pogresan unos"

  show_help

  ;;

esac