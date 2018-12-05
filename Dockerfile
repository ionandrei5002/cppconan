FROM ubuntu:18.04

RUN apt update && \
    apt install -y curl gpg

RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
    install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ && \
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list

RUN apt update && \
    apt install -y apt-transport-https code

RUN useradd -m andrei
ENV USER andrei
WORKDIR /home/andrei/

RUN apt update \
    && apt install -y libnotify4 \
    libnss3 \
    libxkbfile1 \
    libgconf-2-4 \
    libsecret-1-0 \
    libgtk2.0-0 \
    libxss1 \
    libasound2 \
    libcanberra-gtk-module \
    gtk2-engines-murrine \
    gtk2-engines-pixbuf \
    ubuntu-mate-icon-themes \
    ubuntu-mate-themes

RUN apt update && \
    apt install -y gcc-8 \
    g++-8 \
    valgrind \
    cmake \
    git \
    ninja-build \
    build-essential

RUN apt update && \
    apt install -y wget && \
    wget https://dl.bintray.com/conan/installers/conan-ubuntu-64_1_10_0.deb && \
    dpkg -i conan-ubuntu-64_1_10_0.deb

RUN rm /microsoft.gpg && \
    rm conan-ubuntu-64_1_10_0.deb
    
RUN echo 'include "/usr/share/themes/Ambiant-MATE/gtk-2.0/gtkrc"' > /home/andrei/.gtkrc-2.0

USER andrei
CMD ["/bin/bash", "--login"]