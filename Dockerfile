#FROM openjdk:8-jdk-alpine
# FROM: Especifica a imagem base que será usada. Neste caso, estamos usando uma imagem mínima do Alpine Linux com o JDK 8 do OpenJDK.
# openjdk:8-jdk-alpine: É uma imagem leve baseada no Alpine Linux que já tem o JDK 8 instalado.
#VOLUME /tmp
# VOLUME: Cria um ponto de montagem para um volume. Aqui, está criando um volume para o diretório /tmp.
#ARG JAVA_OPTS
#ENV JAVA_OPTS=$JAVA_OPTS
# ARG: Define uma variável de ambiente que pode ser passada como argumento para o comando docker build, durante a construção da imagem. JAVA_OPTS é um argumento opcional que pode ser usado para passar opções adicionais para a JVM. 
# ENV: Define uma variável de ambiente. Aqui, está definindo JAVA_OPTS como uma variável de ambiente usando o valor do argumento JAVA_OPTS.
#COPY build/libs/MalmoMod-versionProp[&#x27;malmomod.version&#x27;].jar malmo.jar
# COPY: Copia arquivos ou diretórios do sistema de arquivos do host para o sistema de arquivos do container. Aqui, está copiando um arquivo JAR (Java ARchive) para dentro do container e renomeando-o para malmo.jar.
# build/libs/MalmoMod-versionProp['malmomod.version'].jar: Parece estar usando uma notação não padrão que pode ser um erro. Deveria ser algo como build/libs/MalmoMod-1.0.jar.
#EXPOSE 10000
#EXPOSE 5901
# EXPOSE: Informa ao Docker que o container escuta nas portas especificadas em tempo de execução. Aqui, está expondo as portas 10000 e 5901.
#ENTRYPOINT exec java $JAVA_OPTS -jar malmo.jar
# ENTRYPOINT: Define o comando que será executado quando o container iniciar. Aqui, está executando o comando java com as opções passadas na variável JAVA_OPTS e o arquivo JAR malmo.jar.
# For Spring-Boot project, use the entrypoint below to reduce Tomcat startup time.
#ENTRYPOINT exec java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar malmo.jar


# =========================================================================================

#FROM ubuntu:20.04

## Instalar dependências
#RUN apt-get update && apt-get install -y \
#    openjdk-8-jdk \
#    python3 \
#    python3-pip \
#    wget \
#    unzip \
#    xvfb \
#    x11-apps \
#    xfce4 \
#    xfce4-goodies \
#    tightvncserver

## Configurar VNC
#RUN mkdir -p ~/.vnc \
#    && echo "password" | vncpasswd -f > ~/.vnc/passwd \
#    && chmod 600 ~/.vnc/passwd \
#    && echo "startxfce4 &" > ~/.vnc/xstartup \
#    && chmod +x ~/.vnc/xstartup

## Baixar e instalar Malmo
#WORKDIR /opt
#RUN wget https://github.com/microsoft/malmo/releases/download/0.37.0/Malmo-0.37.0-Linux-Ubuntu-18.04-64bit_withBoost_Python3.6.zip \
#    && unzip Malmo-0.37.0-Linux-Ubuntu-18.04-64bit_withBoost_Python3.6.zip \
#    && rm Malmo-0.37.0-Linux-Ubuntu-18.04-64bit_withBoost_Python3.6.zip

## Configurar variáveis de ambiente
#ENV MALMO_XSD_PATH=/opt/MalmoPlatform/Schemas
#ENV LD_LIBRARY_PATH=/opt/MalmoPlatform/lib:/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
#ENV PATH=/opt/MalmoPlatform/bin:$PATH
#ENV PYTHONPATH=/opt/MalmoPlatform/Python_Examples:/opt/MalmoPlatform/Minecraft/PythonClient:$PYTHONPATH

## Copiar o arquivo JAR do Malmo
#COPY build/libs/MalmoMod-1.0.jar malmo.jar

## Expor as portas necessárias
#EXPOSE 10000
#EXPOSE 5901

## Comando para iniciar o Xvfb, VNC e o Minecraft
#CMD ["sh", "-c", "Xvfb :1 -screen 0 1280x800x24 & vncserver :1 -geometry 1280x800 -depth 24 && export DISPLAY=:1 && exec java $JAVA_OPTS -jar malmo.jar"]


# ============================================ 3 =========================================
# Copyright (c) 2017 Microsoft Corporation.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
# documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
#  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
# and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of
# the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO
# THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
#  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# ===================================================================================================================

FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# 16.04 image doesn't contain sudo - install that first:
RUN apt-get update && apt-get install -y sudo

# Create a user called "malmo", give it sudo access and remove the requirement for a password:
RUN useradd --create-home --shell /bin/bash --no-log-init --groups sudo malmo
RUN sudo bash -c 'echo "malmo ALL=(ALL:ALL) NOPASSWD: ALL" | (EDITOR="tee -a" visudo)'

# While we are still root, install the necessary dependencies for Malmo:
RUN sudo apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    libpython3.6-dev \
    openjdk-8-jdk \
    swig \
    doxygen \
    xsltproc \
    ffmpeg \
    python3-tk \
    python3-pil.imagetk \
    wget \
    libbz2-dev \
    python3-pip \
    software-properties-common \
    xpra \
    libgl1-mesa-dri \
    zlib1g-dev

RUN sudo update-ca-certificates -f

# Note the trailing slash - essential!
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/" >> /home/malmo/.bashrc

# Switch to the malmo user:
USER malmo
WORKDIR /home/malmo

# BOOST:
RUN mkdir /home/malmo/boost
WORKDIR /home/malmo/boost
RUN wget http://sourceforge.net/projects/boost/files/boost/1.66.0/boost_1_66_0.tar.gz
RUN tar xvf boost_1_66_0.tar.gz
WORKDIR /home/malmo/boost/boost_1_66_0
RUN echo "using python : 3.6 : /usr/bin/python3 : /usr/include/python3.6 : /usr/lib ;" > /home/malmo/user-config.jam
RUN ./bootstrap.sh --prefix=.
RUN ./b2 link=static cxxflags=-fPIC install

# CMAKE:
RUN mkdir /home/malmo/cmake
WORKDIR /home/malmo/cmake
RUN wget https://cmake.org/files/v3.11/cmake-3.11.0.tar.gz
RUN tar xvf cmake-3.11.0.tar.gz
WORKDIR /home/malmo/cmake/cmake-3.11.0
RUN ./bootstrap
RUN make -j4
RUN sudo make install

# Python3 is currently is missing distutils
RUN sudo apt install -y python3-distutils 
RUN sudo pip3 install setuptools
RUN sudo pip3 install future pillow matplotlib

RUN sudo apt-get update && sudo apt-get install -y dos2unix
COPY ./build.sh /home/malmo/build.sh
RUN sudo dos2unix /home/malmo/build.sh

ENV MALMO_XSD_PATH=/home/malmo/MalmoPlatform/Schemas

# ENTRYPOINT ["/home/malmo/build.sh", "-boost", "1_66_0", "-python", "3.6"]

#Execute: docker build . -t image-malmo-docker
    