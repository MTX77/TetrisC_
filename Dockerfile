FROM ubuntu:latest AS builder

RUN apt-get update && apt-get install -y git
RUN git clone https://github.com/lucadellalib/TetrisC.git

WORKDIR ./TetrisC

RUN apt-get install -y pkg-config
RUN apt-get install -y cmake
RUN apt-get install -y cmake-data
RUN apt-get install -y libncurses5-dev
RUN apt-get install -y check
run cmake . && make

FROM builder AS tester
COPY --from=builder /TetrisC /TetrisC

CMD ./bin/check_block
