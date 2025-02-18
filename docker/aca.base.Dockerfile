# MIT License
# Copyright(c) 2022 Futurewei Cloud
#     Permission is hereby granted,
#     free of charge, to any person obtaining a copy of this software and associated documentation files(the "Software"), to deal in the Software without restriction,
#     including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and / or sell copies of the Software, and to permit persons
#     to whom the Software is furnished to do so, subject to the following conditions:
#     The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
#     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


FROM ubuntu:18.04

# Install Go
ENV GOLANG_VERSION 1.18.3
RUN apt update && apt install -y build-essential wget
RUN wget https://golang.org/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go${GOLANG_VERSION}.linux-amd64.tar.gz
RUN rm -f go${GOLANG_VERSION}.linux-amd64.tar.gz
ENV PATH "$PATH:/usr/local/go/bin"

# ACA
WORKDIR /
RUN mkdir -p /merak-bin
COPY services/merak-agent/plugins/alcor-control-agent/build/bin/AlcorControlAgent /merak-bin/AlcorControlAgent
COPY services/merak-agent/plugins/alcor-control-agent/build/aca-machine-init.sh /aca-machine-init.sh
RUN apt install -y git make bash gcc libc-dev openvswitch-switch=2.9.8-0ubuntu0.18.04.2 libevent-dev rsyslog
RUN ./aca-machine-init.sh
