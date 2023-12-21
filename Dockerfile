FROM arm64v8/ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai
# 维护者信息
LABEL maintainer="zhuo.kaikuo@byd.com"
# 镜像操作指令
# COPY ros.gpg /etc/apt/trusted.gpg.d/ros.gpg
RUN sed -i "s/ports.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/" /etc/apt/sources.list &&\
    sed -i "/security/d" /etc/apt/sources.list 
RUN apt update && apt install -y ca-certificates gnupg &&\
    apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 &&\
    echo "deb https://mirrors.tuna.tsinghua.edu.cn/ros/ubuntu/ focal main" >> /etc/apt/sources.list.d/ros1-latest.list 
RUN apt update && apt install -y ros-noetic-desktop-full \
    ros-noetic-libg2o libceres-dev libgoogle-glog-dev \
    libsuitesparse-dev libpcap-dev ros-noetic-serial libgeographic-dev ros-noetic-catkin ros-noetic-gtsam \
    python3-pip \
    ros-noetic-jsk-rviz-plugins && sudo rm -rf /var/lib/apt/lists/*
RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple && pip install catkin-tools
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
