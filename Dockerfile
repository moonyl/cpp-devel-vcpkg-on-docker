FROM moony/qt-dev:5.12.7 AS qt_build

FROM ubuntu:focal

ENV TZ=Asia/Seoul

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update

RUN apt -y install build-essential gcc g++ g++-8 gdb clang cmake rsync tar python

RUN apt -y install git curl unzip tar zip pkg-config nasm subversion libx11-dev

COPY --from=qt_build /opt/Qt5.12.7 /opt/Qt5.12.7

ADD 2021.04.30.tar.gz /opt/

WORKDIR /opt/vcpkg-2021.04.30

RUN ./bootstrap-vcpkg.sh 

RUN ./vcpkg install nlohmann-json ffmpeg openssl boost-process redis-plus-plus[cxx17] skyr-url doctest argagg boost-signals2 boost-beast

RUN ./vcpkg install live555 --head

RUN ./vcpkg integrate install && ./vcpkg integrate bash && echo 'export PATH=$PATH:/opt/vcpkg' >>~/.bashrc
