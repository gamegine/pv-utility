FROM bash:5.1.4
RUN apk add pv
ENV PATH=${PATH}:/root/pv-utility/src
RUN ln -s /usr/local/bin/bash /bin/bash # #!/bin/bash
WORKDIR /root
COPY . /root/pv-utility