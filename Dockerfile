FROM shoothzj/base

RUN groupadd sh -g 1024 && \
    useradd -r -g sh sh -u 1024 -m -d /home/sh

WORKDIR /opt

ARG TARGETARCH

ARG amd_download=8.4.3-linux-x86_64

ARG arm_download=8.4.3-linux-aarch64

RUN if [ "$TARGETARCH" = "amd64" ]; \
    then download=$amd_download; \
    else download=$arm_download; \
    fi && \
    wget -q https://artifacts.elastic.co/downloads/kibana/kibana-$download.tar.gz && \
    mkdir /opt/kibana && \
    tar -xf kibana-$download.tar.gz -C /opt/kibana --strip-components 1 && \
    rm -rf kibana-$download.tar.gz && \
    chown -R sh:sh /opt/kibana

ENV KIBANA_HOME /opt/kibana

WORKDIR /opt/kibana
