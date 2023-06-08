FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y \
    git \
    python3 \
    python3-pip \
    wget \
    curl \
    amass \
    findomain \
    assetfinder \
    httpx \
    subfinder && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN go install -v github.com/tomnomnom/anew@latest

WORKDIR /app

COPY . .

CMD ["bash", "lexroid.sh"]