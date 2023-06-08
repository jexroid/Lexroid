#!/bin/bash


# TODO make this fuck to python 


Green='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

install_dependencies() {

  # Install findomain
  if ! command -v findomain >/dev/null 2>&1
  then
    echo "Installing findomain..."
    wget https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-linux || { printf "${RED} ERROR : could net download the fincomain form github\n please check you interner or install findomain manully at\n https://github.com/Edu4rdSHL/findomain/${NC}\n"; exit 1;  }
    chmod +x findomain-linux || { printf "${RED} ERROR (execution permition):\n install findomain manully at\n https://github.com/Edu4rdSHL/findomain/${NC}\n"; exit 1;}
    sudo mv findomain-linux /usr/local/bin/findomain
  fi

  # Install subfinder
  if ! command -v subfinder >/dev/null 2>&1
  then
    echo "Installing subfinder..."
    go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest || { printf "${RED} ERROR : subfinder could NOT be installed automatically\n please install subfinder manually\n${NC}"; exit 1; }
  fi

  # Install httpx
  if ! command -v httpx >/dev/null 2>&1
  then
    echo "Installing httpx..."
    go install github.com/projectdiscovery/httpx/cmd/httpx@latest || { printf "${RED} ERROR : httpx could NOT be installed automatically\n please install httpx manually\n${NC}"; exit 1; }
  fi

  # Install dnsx
  if ! command -v dnsx >/dev/null 2>&1
  then
    echo "Installing dnsx..."
    go install github.com/projectdiscovery/dnsx/cmd/dnsx@latest || { printf "${RED} ERROR : dnsx could NOT be installed automatically\n please install dnsx manually\n${NC}"; exit 1; }
  fi

  # Install assetfinder
  if ! command -v assetfinder >/dev/null 2>&1
  then
    echo "Installing assetfinder..."
    go install github.com/tomnomnom/assetfinder@latest || { printf "${RED} ERROR : assetfinder could NOT be installed automatically\n please install assetfinder manually\n${NC}"; exit 1; }
  fi

  # Install amass
  if ! command -v amass >/dev/null 2>&1
  then
    echo "Installing amass..."
    sudo apt-get install amass || { printf "${RED} ERROR : could NOT install amass using sudo\n please install amass manually${NC}\n"; exit 1;}
  fi

  # Install httprobe
  if ! command -v httprobe >/dev/null 2>&1
  then
    echo "Installing httprobe..."
    go install github.com/tomnomnom/httprobe@latest || { printf "${RED} ERROR : could NOT install httprobe automatically\n please install httprobe at\n https://github.com/tomnomnom/httprobe ${NC}\n"; exit 1; }
  fi

  # Install anew
  if ! command -v anew >/dev/null 2>&1
  then
    echo "Installing anew..."
    go install github.com/tomnomnom/anew@latest || { printf "${RED} ERROR : could NOT install anew automatically\n please install anew manually at\n https://github.com/tomnomnom/anew${NC}\n"; exit 1; }
  fi
}