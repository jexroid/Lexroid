<div align='center'>
  
  
![Lexroid_logo](https://github.com/jexroid/jexroid/blob/main/img/image.png)
  <br>
![Debian](https://img.shields.io/badge/Debian-red?logo=Debian&logoColor=white&style=for-the-badge)
![Red_hat](https://img.shields.io/badge/red%20hat-black?logo=red%20hat&logoColor=red&style=for-the-badge)
![Arch](https://img.shields.io/badge/Arch-blue?logo=arch%20linux&logoColor=white&style=for-the-badge)
  
</div>

# Lexroid (Demo Version)
This Subdomain Reconnaissance Tool is an all-in-one solution for bug hunters and security researchers to automate the process of discovering and analyzing subdomains. The tool combines the power of popular tools like amass, subfinder, assetfinder, and more to provide a comprehensive and efficient workflow for subdomain enumeration and analysis.


## Requirments
- ![golang](https://img.shields.io/badge/Go-1.20.0%20%3C=-green?logo=go&logoColor=white&style=for-the-badge)
- ![python](https://img.shields.io/badge/python-3.6%20%3C=-blue?logo=python&logoColor=white&style=for-the-badge)

**NOTE :** lexroid tries installing assetfinder, subfinder and other tools using GO and apt.
### Tools
- assetfinder
- findomain
- httprobe
- subfinder
- dnsx
- httpx
- anew

## Usage

## Install
- ### Docker

1. Clone the repository using git and Change the directory to lexroid directory:
```
git clone https://github.com/jexroid/Lexroid && cd Lexroid
```
2. Run the docker command for installing the dependencies
```
docker build -t lexroid .
```
3. Give execution permision and run the tool by following command:
```
chmod +x ./lexroid.sh

./lexroid.sh
```
- ### Manual
**NOTE : only works for debian base system (Ubuntu,kali,..)**
1. Clone the repository using git and Change the directory to lexroid directory:
```
git clone https://github.com/jexroid/Lexroid && cd Lexroid
```
2. Give execution permision and run the tool by following command:
```
chmod +x ./lexroid.sh

./lexroid.sh
```
Lexroid tries installing all dependencies using **apt** in **go install**

## Supporting Operation System
**LINUX**
- Debian base
- Arch base
- Red hat base

## Features
- Automated subdomain discovery using multiple tools (amass, subfinder, assetfinder, etc.)
- Integration with **Burp Suite** for further analysis
- Live host detection using httprobe
- Efficient storage and organization of results

## Contributing
Contributions are welcome! If you have any suggestions, bug reports, or feature requests, please open an issue on the GitHub repository.
