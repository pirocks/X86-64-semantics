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
RUN git clone https://github.com/pirocks/k.git --recursive
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
#WORKDIR ../k/JSONDumper
#RUN mvn compile
#RUN java -Dfile.encoding=UTF-8 -classpath /home/user/k/JSONDumper/target/classes:/home/user/k/kernel/target/classes:/home/user/k/kore/target/classes:$(MAVEN_HOME)/org/pcollections/pcollections/2.1.2/pcollections-2.1.2.jar:$(MAVEN_HOME)/org/bouncycastle/bcprov-jdk15on/1.57/bcprov-jdk15on-1.57.jar:$(MAVEN_HOME)/com/google/guava/guava/18.0/guava-18.0.jar:$(MAVEN_HOME)/com/google/inject/guice/4.0-beta5/guice-4.0-beta5-no_aop.jar:$(MAVEN_HOME)/javax/inject/javax.inject/1/javax.inject-1.jar:$(MAVEN_HOME)/aopalliance/aopalliance/1.0/aopalliance-1.0.jar:$(MAVEN_HOME)/com/google/inject/extensions/guice-multibindings/4.0-beta5/guice-multibindings-4.0-beta5.jar:$(MAVEN_HOME)/com/google/inject/extensions/guice-grapher/4.0-beta5/guice-grapher-4.0-beta5.jar:$(MAVEN_HOME)/com/google/inject/extensions/guice-assistedinject/4.0-beta5/guice-assistedinject-4.0-beta5.jar:$(MAVEN_HOME)/com/google/inject/extensions/guice-throwingproviders/4.0-beta5/guice-throwingproviders-4.0-beta5.jar:$(MAVEN_HOME)/com/google/code/findbugs/jsr305/3.0.0/jsr305-3.0.0.jar:$(MAVEN_HOME)/org/glassfish/javax.json/1.0.4/javax.json-1.0.4.jar:$(MAVEN_HOME)/net/sf/jung/jung-api/2.0.1/jung-api-2.0.1.jar:$(MAVEN_HOME)/net/sourceforge/collections/collections-generic/4.01/collections-generic-4.01.jar:$(MAVEN_HOME)/org/apache/commons/commons-lang3/3.3.2/commons-lang3-3.3.2.jar:$(MAVEN_HOME)/org/apache/commons/commons-collections4/4.0/commons-collections4-4.0.jar:$(MAVEN_HOME)/commons-codec/commons-codec/1.10/commons-codec-1.10.jar:$(MAVEN_HOME)/org/kframework/dependencies/jcommander/1.35-custom/jcommander-1.35-custom.jar:$(MAVEN_HOME)/net/sf/jung/jung-graph-impl/2.0.1/jung-graph-impl-2.0.1.jar:$(MAVEN_HOME)/dk/brics/automaton/automaton/1.11-8/automaton-1.11-8.jar:$(MAVEN_HOME)/org/kframework/mpfr_java/mpfr_java/1.0.1/mpfr_java-1.0.1.jar:$(MAVEN_HOME)/org/fusesource/hawtjni/hawtjni-runtime/1.10/hawtjni-runtime-1.10.jar:$(MAVEN_HOME)/org/kframework/mpfr_java/mpfr_java/1.0.1/mpfr_java-1.0.1-linux64.jar:$(MAVEN_HOME)/org/kframework/mpfr_java/mpfr_java/1.0.1/mpfr_java-1.0.1-linux32.jar:$(MAVEN_HOME)/org/kframework/mpfr_java/mpfr_java/1.0.1/mpfr_java-1.0.1-osx.jar:$(MAVEN_HOME)/org/kframework/mpfr_java/mpfr_java/1.0.1/mpfr_java-1.0.1-windows64.jar:$(MAVEN_HOME)/org/kframework/mpfr_java/mpfr_java/1.0.1/mpfr_java-1.0.1-windows32.jar:$(MAVEN_HOME)/commons-io/commons-io/2.4/commons-io-2.4.jar:$(MAVEN_HOME)/org/fusesource/jansi/jansi/1.11/jansi-1.11.jar:$(MAVEN_HOME)/jline/jline/2.13/jline-2.13.jar:$(MAVEN_HOME)/org/kframework/dependencies/nailgun-server/0.9.2-SNAPSHOT/nailgun-server-0.9.2-20180116.225235-7.jar:$(MAVEN_HOME)/net/java/dev/jna/jna/4.1.0/jna-4.1.0.jar:$(MAVEN_HOME)/org/scala-lang/scala-library/2.12.4/scala-library-2.12.4.jar:$(MAVEN_HOME)/org/scala-lang/scala-reflect/2.12.4/scala-reflect-2.12.4.jar com.runtimeverification.k.Main /home/user/X86-64-semantics/x86-semantics-kompiled/compiled.bin
RUN cd semantics && /usr/bin/time -v kompile  x86-semantics.k --parse-only --emit-json  --syntax-module X86-SYNTAX  --main-module  X86-SEMANTICS --backend java -I . -I common/x86-config/ && false
