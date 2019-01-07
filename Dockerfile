FROM ubuntu:18.04

RUN apt update && \
    apt install -y curl \
    gpg \
    coreutils \
    tree \
    nano \
    net-tools \
    locate \
    bsdmainutils

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

RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 50 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 50 && \
    update-alternatives --install /usr/bin/cpp cpp-bin /usr/bin/cpp-8 50 && \
    update-alternatives --set g++ /usr/bin/g++-8 && \
    update-alternatives --set gcc /usr/bin/gcc-8 && \
    update-alternatives --set cpp-bin /usr/bin/cpp-8

RUN apt update && \
    apt install -y wget && \
    wget https://dl.bintray.com/conan/installers/conan-ubuntu-64_1_10_0.deb && \
    dpkg -i conan-ubuntu-64_1_10_0.deb

RUN rm /microsoft.gpg && \
    rm conan-ubuntu-64_1_10_0.deb

RUN apt install -y python3.6 python3-pip pkg-config
RUN pip3 install meson 

RUN echo 'include "/usr/share/themes/Ambiant-MATE/gtk-2.0/gtkrc"' > /home/andrei/.gtkrc-2.0

RUN echo "root:root" | chpasswd

USER andrei

# RUN mkdir phpcpp && \
#     wget https://api.github.com/repos/CopernicaMarketingSoftware/PHP-CPP/tarball/v2.1.2 -O phpcpp2.1.2.tar && \
#     tar xvzf phpcpp2.1.2.tar -C phpcpp --strip-components=1

# RUN mkdir php7.3 && \
#     wget http://at2.php.net/get/php-7.3.0.tar.gz/from/this/mirror -O php7.3.tar.gz && \
#     tar xvzf php7.3.tar.gz -C php7.3 --strip-components=1

# RUN mkdir -p ~/bin/php7.3/ && \
#     cd ~/php7.3 && \
#     ./configure --prefix=$HOME/bin/php7.3 --disable-all && \
#     make -j4 && \
#     make install

# ENV PATH="/home/andrei/bin/php7.3/bin:${PATH}"

# RUN mkdir -p ~/bin/phpcpp/ && \
#     cd ~/phpcpp && \
#     make -j4

# RUN cd /home/andrei/phpcpp/ && \
#     make INSTALL_PREFIX=/home/andrei/bin/phpcpp install

# RUN cd ~/ && \
#     cp php7.3/php.ini-development ~/bin/php7.3/lib/php.ini && \
#     rm php7.3.tar.gz && \
#     rm phpcpp2.1.2.tar && \
#     rm -rf php7.3 && \
#     rm -rf phpcpp

COPY .bashrc .bashrc

CMD ["/bin/bash", "--login"]