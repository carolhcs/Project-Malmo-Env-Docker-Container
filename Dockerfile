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


FROM ubuntu:20.04

# Instalar dependências
RUN apt-get update && apt-get install -y \
    openjdk-8-jdk \
    python3 \
    python3-pip \
    wget \
    unzip \
    xvfb \
    x11-apps \
    xfce4 \
    xfce4-goodies \
    tightvncserver

# Configurar VNC
RUN mkdir -p ~/.vnc \
    && echo "password" | vncpasswd -f > ~/.vnc/passwd \
    && chmod 600 ~/.vnc/passwd \
    && echo "startxfce4 &" > ~/.vnc/xstartup \
    && chmod +x ~/.vnc/xstartup

# Baixar e instalar Malmo
WORKDIR /opt
RUN wget https://github.com/microsoft/malmo/releases/download/0.37.0/Malmo-0.37.0-Linux-Ubuntu-18.04-64bit_withBoost_Python3.6.zip \
    && unzip Malmo-0.37.0-Linux-Ubuntu-18.04-64bit_withBoost_Python3.6.zip \
    && rm Malmo-0.37.0-Linux-Ubuntu-18.04-64bit_withBoost_Python3.6.zip

# Configurar variáveis de ambiente
ENV MALMO_XSD_PATH=/opt/MalmoPlatform/Schemas
ENV LD_LIBRARY_PATH=/opt/MalmoPlatform/lib:/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
ENV PATH=/opt/MalmoPlatform/bin:$PATH
ENV PYTHONPATH=/opt/MalmoPlatform/Python_Examples:/opt/MalmoPlatform/Minecraft/PythonClient:$PYTHONPATH

# Copiar o arquivo JAR do Malmo
COPY build/libs/MalmoMod-1.0.jar malmo.jar

# Expor as portas necessárias
EXPOSE 10000
EXPOSE 5901

# Comando para iniciar o Xvfb, VNC e o Minecraft
CMD ["sh", "-c", "Xvfb :1 -screen 0 1280x800x24 & vncserver :1 -geometry 1280x800 -depth 24 && export DISPLAY=:1 && exec java $JAVA_OPTS -jar malmo.jar"]