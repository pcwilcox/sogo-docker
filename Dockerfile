FROM    ubuntu:focal AS builder

LABEL   maintainer="Pete Wilcox pete@pcwilcox.com"

# Install dependencies
RUN     export DEBIAN_FRONTEND=noninteractive                                           \
            && apt-get update -qq                                                       \
            && yes | apt-get dist-upgrade -y --force-yes                                \
            && yes | apt install -y                                                     \
                build-essential                                                         \
                wget                                                                    \
                unzip                                                                   \
                gnustep-devel                                                           \
                pkg-config                                                              \
                libxml2-dev                                                             \
                libcurl4-openssl-dev                                                    \
                libpq-dev                                                               \
                libmemcached-dev                                                        \
                libssh-dev                                                              \
                libldap2-dev                                                            \
                libmysqlclient-dev                                                      \
                libgnutls28-dev                                                         \
                libsodium-dev                                                           \
                zlib1g-dev                                                              \
                libzip-dev


# Download SOGo and SOPE sources
RUN     wget https://github.com/inverse-inc/sope/archive/master.zip -O sope.zip         \
            && wget https://github.com/inverse-inc/sogo/archive/master.zip -O sogo.zip

# Unpack the sources
RUN     unzip sope.zip -d /tmp                                                          \
            && unzip sogo.zip -d /tmp

# Compile and build SOPE
RUN     cd /tmp/sope-master                                                             \
            && ./configure --with-gnustep --enable-debug --disable-strip                \
            && make                                                                     \
            && make install

# Compile and build SOGo
RUN     cd /tmp/sogo*                                                                   \
            && ./configure --enable-debug --disable-strip                               \
            && make                                                                     \
            && make install
