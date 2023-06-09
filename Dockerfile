# Build amass from source
FROM golang:1.17 as amass-builder
RUN git clone https://github.com/OWASP/Amass.git /amass
WORKDIR /ass
RUN go build -o /go/bin/amass ./cmd/amass

# Build subfinder from source
FROM golang:1.17 as subfinder-builder
RUN git clone https://github.com/projectdiscovery/subfinder.git /subfinder
WORKDIR /subfinder/v2/cmd/subfinder
RUN go build -o /go/bin/subfinder

# Build dnsx from source
FROM golang:1.17 as dnsx
RUN git clone https://github.com/projectdiscovery/dnsx.git /dnsx
WORKDIR /dnsx/cmd/dnsx
RUN go build -o /go/bin/dnsx

# Final image
FROM ubuntu:latest

# Update package lists and install required dependencies
RUN apt update && \
    apt install -y git python3 wget curl && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Copy built binaries from previous stages
COPY --from=amass-builder /go/bin/amass /usr/local/bin/
COPY --from=subfinder-builder /go/bin/subfinder /usr/local/bin/
COPY --from=dnsx-builder /go/bin/dnsx /usr/local/bin/

# Install assetfinder, anew, and httprobe
RUN apt update && \
    apt install -y golang && \
    go get -u github.com/tomnomnom/assetfinder && \
    go get -u github.com/tomnomnom/anew && \
    go get -u github.com/tomnomnom/httprobe && \
    apt remove -y golang && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Set the PATH environment variable to include the Go bin directory
ENV PATH="/root/go/bin:${PATH}"

CMD ["/bin/bash"]