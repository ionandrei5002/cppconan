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

# RUN apt install -y \
#     qt5-default \
#     qt5-qmake \
#     libqt5sql5-mysql \
#     libqt5sql5-psql \
#     libqt5sql5-odbc \
#     libqt5sql5-sqlite \
#     libqt5core5a \
#     libqt5qml5 \
#     libqt5xml5 \
#     qtbase5-dev \
#     qtdeclarative5-dev \
#     qtbase5-dev-tools \
#     libmysqlclient-dev \
#     libpq5 \
#     libodbc1

# RUN wget https://github.com/treefrogframework/treefrog-framework/archive/v1.22.0.tar.gz && \
#     tar xvfz v1.22.0.tar.gz && \
#     rm v1.22.0.tar.gz

# RUN cd treefrog-framework-1.22.0 && \
#     ./configure && \
#     cd src && \
#     make && \
#     make install && \
#     cd ../tools && \
#     make && \
#     make install && \
#     chown -R andrei:andrei /home/andrei/treefrog-framework-1.22.0

# RUN ldconfig && \
#     rm -rf /home/andrei/treefrog-framework-1.22.0 && \
#     apt install -y sqlite3

RUN echo 'include "/usr/share/themes/Ambiant-MATE/gtk-2.0/gtkrc"' > /home/andrei/.gtkrc-2.0

USER andrei
CMD ["/bin/bash", "--login"]