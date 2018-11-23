#The newest ubuntu 18.10
FROM  ubuntu:cosmic 

#installing gcc8, cmake, wget
RUN    apt-get update \
    && apt-get install -y g++ cmake wget  \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir  /deductor
WORKDIR /deductor

#Get Deductor with examples
RUN    wget http://pages.uoregon.edu/soper/deductor/deductor-2.1.1.tar.gz  \
    && wget http://pages.uoregon.edu/soper/deductor/deductor-user-2.1.1.tar.gz  \
    && tar zxvf deductor-2.1.1.tar.gz  \
    && tar zxvf deductor-user-2.1.1.tar.gz  \
    && rm  *.gz \
    && find  deductor-2.1.1  -iname "\.*" -delete \
    && find  deductor-user-2.1.1  -iname "\.*" -delete

#Compile and istall to /usr
RUN mkdir -p deductor-2.1.1/build
WORKDIR /deductor/deductor-2.1.1/build
RUN cmake .. -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -DCMAKE_INSTALL_PREFIX=/usr
RUN make install

#Try to compile and run example
WORKDIR /deductor/deductor-user-2.1.1/Jets
RUN deductor --new jets mod-jets.cc analyzer-jets.h analyzer-jets.cc local/
RUN deductor --build jets
RUN deductor --run jets
