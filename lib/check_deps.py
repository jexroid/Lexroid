import subprocess
import shutil

apps = ["subfinder", "assetfinder", "anew", "httprobe", "httpx", "dnsx", "findomain"]

def is_app_installed(app):
    return shutil.which(app) is not None

def main():
    for app in apps:
        if is_app_installed(app):
            print(f"{app} installed")
        else:
            print(f"{app} not installed")

if __name__ == "__main__":
    main()