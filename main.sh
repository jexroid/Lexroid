#!/bin/bash

source lib/install_deps.sh
source lib/function.sh


printf "  _     _______  ______   ___ ___ ____  \n"
printf " | |   | ____\ \/ /  _ \ / _ \_ _|  _ \ \n"
printf " | |   |  _|  \  /| |_) | | | | || | | |\n"
printf " | |___| |___ /  \|  _ <  |_| | || |_| |\n"
printf " |_____|_____/_/\_\_| \_|\___/___|____/ \n"
printf "                                        \n"
printf "                         version : 1.0.0\n\n"

Green='\033[0;32m'
RED='\033[0;31m'
YEL='\033[0;33m'
NC='\033[0m'
platform=$2
urlsfile=$1




complete -F _path_completion path


if pth=$(python3 data/path_handler.py); then
    if [ -e $pth ]; then
        printf "${YEL}storing data in -> ${NC}${pth}\n"
    else
        mkdir $pth
    fi
elif [ $? -eq 1 ]; then
    printf "${RED}Please define a path for storing your recon result : ${NC}";
    read -e path;
    pth=$(python3 data/path_handler.py $path);
    if [ $? -eq 2 ]; then
      while true; do
        pth=$(python3 data/path_handler.py $path)
        if [ $? -eq 0 ]; then
            break
        else
            printf "${RED}Invalid path. Please enter a valid path:${NC}";
            read -e path
        fi
    done
    fi
    if [ -e $pth ]; then
        printf "${YEL}storing data in -> ${NC}${pth}\n"
    else
        mkdir $pth
    fi
fi

printf "${Green}GATHERING SUBDOMAINS ${NC}\n"

if [ -z "$urlsfile" ];
        then printf "${RED}Please enter a domain name :\nUsage : subfind.sh <domain>\n"
        exit
fi

if [ -z "$platform" ];
        then
            printf "${RED}Please enter the platform name to download the whole subdomains from chaos${NC}\n"
        else
            wget "https://chaos-data.projectdiscovery.io/$platform.zip" -P /home/retrolex/recon/$urlsfile/$platform
fi

printf "${Green}USING (subfinder, dnsx, httpx)${NC}\n"
echo "$(subfinder -d $urlsfile -silent -all | dnsx -silent | httpx -silent -fr -http-proxy http://127.0.0.1:8080/ )"

printf "${RED} PUTTING SUB DOMAINS TO A FILE ${NC}\n"
subfinder -silent -d $urlsfile -nW -oI -o i.txt
sleep 1
cat i.txt | grep -E -o '([0-9]{1,3}[\.]){3}[0-9]{1,3}' i.txt > $wind/PROJECTS/$urlsfile/ip.$urlsfile.txt

assetfinder --subs-only $1 | httpx -silent -fr -http-proxy http://127.0.0.1:8080/ | anew $HOME/recon/$urlsfile/$urlsfile.txt
findomain -t $1 -o

cat $urlsfile.txt | anew $HOME/recon/$urlsfile/$urlsfile.txt

rm -rf $urlsfile.txt

subfinder -d $urlsfile -silent -all -o $urlsfile.txt

cat $urlsfile.txt | anew $HOME/recon/$urlsfile/$urlsfile.txt

rm -rf $urlsfile.txt

amass enum -d $urlsfile -active -cidr 1.2.3.4/24,4.3.2.1/24 -asn 12345 -o $urlsfile.txt

cat $urlsfile.txt | anew $HOME/recon/$urlsfile/$urlsfile.txt

rm -rf $urlsfile.txt

printf "${RED} FINDING LIVE HOSTS... ${NC}"
echo ''
cat $HOME/recon/$urlsfile/$urlsfile.txt | httprobe > $HOME/recon/$urlsfile/live.$urlsfile.txt
printf "${RED} saved live hosts to live_subs ${NC}"
echo ''
printf "${RED} CHECKING FOR SUBDOMAIN TAKEOVER... ${NC}"

printf "${RED} SENDING DOMAINS TO BURPSUITE ${NC}"
printf '\n'
cat $HOME/recon/$urlsfile/$urlsfile.txt | httpx -silent -fr -http-proxy 'http://127.0.0.1:8080/'
cp $HOME/recon/$urlsfile/live.$urlsfile.txt $wind/PROJECTS/$urlsfile/live.$urlsfile.txt
cp $HOME/recon/$urlsfile/$urlsfile.txt $wind/PROJECTS/$urlsfile/$urlsfile.txt