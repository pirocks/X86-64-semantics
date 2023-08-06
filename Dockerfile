ARG BASE_IMAGE=ubuntu:bionic
FROM ${BASE_IMAGE}
ARG BASE_IMAGE

ARG LLVM_VERSION=8

RUN    apt-get update            \
    && apt-get install --yes     \
        clang-$LLVM_VERSION      \
        cmake                    \
        curl                     \
        debhelper                \
        flex                     \
        gcc                      \
        git                      \
        libboost-test-dev        \
        libgmp-dev               \
        libjemalloc-dev          \
        libmpfr-dev              \
        libyaml-dev              \
        libz3-dev                \
        lld-$LLVM_VERSION        \
        llvm-$LLVM_VERSION-tools \
        maven                    \
        opam                     \
        openjdk-11-jdk           \
        pkg-config               \
        python3                  \
        z3                       \
        zlib1g-dev

RUN curl -sSL https://get.haskellstack.org/ | sh
RUN apt-get install perl strace perl-doc time sudo nano vim curl -y
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN echo 'source $HOME/.cargo/env' >> $HOME/.bashrc
RUN cpan File::chdir
RUN cargo install ripgrep

ARG USER_ID=1000
ARG GROUP_ID=1000
RUN groupadd -g $GROUP_ID user && \
    useradd -m -u $USER_ID -s /bin/sh -g user user

USER $USER_ID:$GROUP_ID

WORKDIR /home/user
RUN git clone https://github.com/pirocks/k.git
WORKDIR k
RUN git submodule update --init --recursive
RUN mvn package -DskipTests -T 32
RUN mvn install -DskipTests -DskipKTest -T 32
WORKDIR ..
ADD . X86-64-semantics
WORKDIR X86-64-semantics
USER 0:0
RUN chmod -R 777 .
USER $USER_ID:$GROUP_ID
ENV PATH="${PATH}:/home/user/k/k-distribution/target/release/k/bin"
RUN cd semantics && ../scripts/kompile.pl --backend java
