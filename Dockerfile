FROM bash:5.1.4

ARG testtool=false

RUN ln -s /usr/local/bin/bash /bin/bash # #!/bin/bash
RUN apk add pv
RUN if $testtool; then apk add bats ; fi
WORKDIR /root
ENV PATH=${PATH}:/root/pv-utility/src
COPY . /root/pv-utility