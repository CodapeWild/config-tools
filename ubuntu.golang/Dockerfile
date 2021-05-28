FROM ubuntu:18.04

RUN apt update
RUN apt upgrade -y

ENV DEBIAN_FRONTEND=noninteractive

RUN apt install wget gcc -y

RUN wget -c https://golang.google.cn/dl/go1.16.2.linux-amd64.tar.gz -O - | tar -xz -C /usr/local
ENV PATH=$PATH:/usr/local/go/bin
ENV GOPATH=/root/go
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
RUN echo "export PATH=$PATH:/usr/local/go/bin" >>~/.bashrc
RUN echo "export GOPATH=/root/go" >>~/.bashrc

RUN apt install lm-sensors smartmontools -y