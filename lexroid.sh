#!/bin/bash

source lib/install_deps.sh
source lib/function.sh


banner

Green='\033[0;32m'
RED='\033[0;31m'
YEL='\033[0;33m'
NC='\033[0m'
urlsfile=$1

install_dependencies



complete -F _path_completion path

# if data/path_handler.py printed the path then print storing location:
if pth=$(python3 data/path_handler.py); then
    if [ -e $pth ]; then
        printf "${YEL}storing data in -> ${NC}${pth}\n"
    else
        mkdir $pth
    fi
# if data/path_handler.py exited with error code 1 (sys.exit(1))
elif [ $? -eq 1 ]; then
    printf "${RED}Please define a path for storing your recon result : ${NC}";
    read -e path;
    pth=$(python3 data/path_handler.py $path);
    # if error code 2 returned from python send user to loop till he/she entered a valid path
    if [ $? -eq 2 ]; then
      while true; do
        pth=$(python3 data/path_handler.py $path)
        if [ $? -eq 0 ]; then
            # if path was valid, break the loop and store data in json file
            break
        else
            # if path is invalid :
            printf "${RED}Invalid path. Please enter a valid path:${NC} ";
            read -e path
        fi
    done
    fi
    # all conditions are true so lets move on
    if [ -e $pth ]; then
        printf "${YEL}storing data in -> ${NC}${pth}\n"
    else
        mkdir $pth
    fi
fi

printf "${Green}GATHERING SUBDOMAINS ${NC}\n"

if [ -z "$1" ];
        then printf "${RED}Please enter a domain name :\nUsage : subfind.sh <domain>\n"
        exit
fi


printf "${RED} GATHERING IP'S TO A FILE ${NC}\n"
subfinder -silent -d $1 -nW -oI -o i.txt
sleep 1
cat i.txt | grep -E -o '([0-9]{1,3}[\.]){3}[0-9]{1,3}' i.txt > $pth/ip.$1.txt
rm i.txt


assetfinder --subs-only $1 | httpx -silent -fr -http-proxy http://127.0.0.1:8080/ | anew $pth/sub.$1.txt
findomain -t $1 -u temp.txt
cat temp.txt | anew $pth/sub.$1.txt
rm -rf temp.txt


subfinder -d $1 -silent -all -o $1.txt
cat $1.txt | anew $pth/sub.$1.txt
rm -rf $1.txt

amass enum -d $1 -active -cidr 1.2.3.4/24,4.3.2.1/24 -asn 12345 -o $1.txt
cat $1.txt | anew $pth/sub.$1.txt
rm -rf $1.txt


printf "${Green}USING (subfinder, dnsx, httpx)${NC}\n"
echo "$(subfinder -d $1 -silent -all | dnsx -silent | httpx -silent -fr -http-proxy http://127.0.0.1:8080/ )"


printf "${RED} FINDING LIVE HOSTS... ${NC}"
echo ''
cat $pth/sub.$1.txt | httprobe > $pth/live_sub.$1.txt


printf "${RED} saved live hosts to live_subs live_sub.$1.txt ${NC}"
echo ''

printf "${RED} SENDING ALL DOMAINS TO BURPSUITE ${NC}"
printf '\n'
cat $pth/sub.$1.txt | httpx -silent -fr -http-proxy 'http://127.0.0.1:8080/'