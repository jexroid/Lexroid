FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y \
    amass \
    git \
    python3 \
    wget \
    curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN go install github.com/tomnomnom/anew@latest

RUN go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

RUN go install github.com/projectdiscovery/dnsx/cmd/dnsx@latest

RUN go install github.com/projectdiscovery/httpx/cmd/httpx@latest

RUN go install github.com/tomnomnom/assetfinder@latest 

RUN go install github.com/tomnomnom/httprobe@latest

RUN wget https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-linux && \
    chmod +x findomain-linux && \
    sudo mv findomain-linux /usr/local/bin/findomain && \
    rm -rf findomain-linux

WORKDIR /app

COPY . .

CMD ["bash", "lexroid.sh"]