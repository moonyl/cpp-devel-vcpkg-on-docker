FROM moony/remote-dev-cpp:v0.4

ENV TZ=Asia/Seoul

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update && apt -y install git curl unzip tar zip pkg-config nasm

RUN git clone https://github.com/Microsoft/vcpkg.git /opt/vcpkg

WORKDIR /opt/vcpkg

RUN ./bootstrap-vcpkg.sh 

RUN ./vcpkg install nlohmann-json ffmpeg openssl boost-process

RUN ./vcpkg install live555 --head

RUN ./vcpkg integrate install && ./vcpkg integrate bash && echo 'export PATH=$PATH:/opt/vcpkg' >>~/.bashrc
