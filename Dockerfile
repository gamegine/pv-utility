FROM bash:5.1.4
RUN ln -s /usr/local/bin/bash /bin/bash # #!/bin/bash
RUN apk add pv
WORKDIR /root
ENV PATH=${PATH}:/root/pv-utility/src
COPY . /root/pv-utility