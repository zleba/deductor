FROM  ubuntu:cosmic
RUN apt-get update &&  apt-get install -y wget cmake g++
RUN mkdir /deductor
WORKDIR /deductor
RUN wget http://pages.uoregon.edu/soper/deductor/deductor-2.1.1.tar.gz && \
    wget http://pages.uoregon.edu/soper/deductor/deductor-user-2.1.1.tar.gz && \
    tar zxvf deductor-2.1.1.tar.gz && \
    tar zxvf deductor-user-2.1.1.tar.gz && \
    rm  *.gz

RUN mkdir -p deductor-2.1.1/build
WORKDIR /deductor/deductor-2.1.1/build
RUN cmake .. -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -DCMAKE_INSTALL_PREFIX=/usr
RUN make install
WORKDIR /deductor/deductor-user-2.1.1/Jets
RUN deductor --new jets mod-jets.cc analyzer-jets.h analyzer-jets.cc local/
RUN deductor --build jets
