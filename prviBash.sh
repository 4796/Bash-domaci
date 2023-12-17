#!/bin/bash



#provera broja argumenata


if [ "$#" -lt 1 ]; then



  echo "Greška: Potrebno je uneti najmanje jedan argument."



exit



fi





#provera opcije -h



if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then


  echo "Ova skripta se koristi za pravljenje rezervnih kopija"



  echo "Kao argumente je potrebno uneti izvor pa destinaciju za kopiranje"



  echo "Moguce je uneti -h ili --help za prikaz pomoci"



  exit



fi



izvor="$1"

destinacija="$2"


#kopije




cp -rp "$izvor" "$destinacija"




#report.txt



datum_vreme=$(date "+%Y-%m-%d %H:%M:%S")

korisnik=$(whoami)

broj_fajlova=0

spisak_fajlova=""






# prolazak 



for fajl in "$izvor"/*; do





    broj_fajlova=$((broj_fajlova + 1))



    permisije=$(stat --format="%A" "$fajl")



    ime=$(basename "$fajl")



    velicina=$(stat --format="%s" "$fajl")



    datum=$(stat --format="%y" "$fajl")



    spisak_fajlova+="Permisije: $permisije, Naziv: $ime, Veličina: $velicina, Datum: $datum"$'\n'





done



# report.txt




echo "Datum i vreme rezervne kopije: $datum_vreme" > "$destinacija/report.txt"



echo "Korisnik: $korisnik" >> "$destinacija/report.txt"



echo "Broj fajlova: $broj_fajlova" >> "$destinacija/report.txt"



echo  "Spisak fajlova:" >> "$destinacija/report.txt"



echo "$spisak_fajlova" >> "$destinacija/report.txt"

 



echo "Rezervna kopija uspešno napravljena."



