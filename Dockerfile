FROM bash:5.1.4
RUN apk add pv
ENV PATH=${PATH}:/root/utility-bash-pv/src
WORKDIR /root
COPY . /root/utility-bash-pv