# syntax=docker/dockerfile:1
ARG UBUNTU_VERSION=24.04

FROM ubuntu:$UBUNTU_VERSION as build-requirements

    RUN apt-get update \
     && apt-get install --no-install-recommends --yes \
        cmake \
        gcc \
        g++ \
        libboost-test-dev \
        libcairomm-1.0-dev \
        libglibmm-2.4-dev \
        make \
     #  clean up
     && apt-get clean \
     && rm --recursive --force \
        /var/lib/apt/lists/*

FROM ubuntu:$UBUNTU_VERSION as execution-requirements

    ENV DEBIAN_FRONTEND=noninteractive
    RUN apt-get update \
     && apt-get install --no-install-recommends --yes \
        fontconfig \
        libcairomm-1.0-1v5 \
        libglibmm-2.4-1t64 \
        libstdc++6 \
     && echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" \
      | debconf-set-selections \
     && apt-get install --no-install-recommends --yes \
        ttf-mscorefonts-installer \
     && fc-cache -fv \
     #  clean up
     && apt-get clean \
     && rm --recursive --force \
        /var/lib/apt/lists/*

FROM build-requirements AS build

    WORKDIR /build
    COPY . /build

    RUN cmake . && make

FROM execution-requirements as execution

    COPY --from=build /build/src/dotprint /bin/dotprint

    WORKDIR /work

    ENTRYPOINT [ "/bin/dotprint" ]
    CMD [ "--help" ]
