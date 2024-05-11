FROM ubuntu:24.04 as build-reqs

    RUN apt-get update \
     && apt-get install --no-install-recommends --yes \
        # newer: libglibmm-2.68-dev
        libglibmm-2.4-dev \
        # newer: libcairomm-1.16-dev
        libcairomm-1.0-dev \
        gcc \
        g++ \
        cmake \
        make \
     # clean up
     && apt-get clean \
     && rm --recursive --force \
        /var/lib/apt/lists/*

FROM ubuntu:24.04 as execution-minimal-reqs

    ENV DEBIAN_FRONTEND=noninteractive
    RUN apt-get update \
     && apt-get install --no-install-recommends --yes \
        libstdc++6 \
        libcairomm-1.0-1v5 \
        libglibmm-2.4-1t64 \
        fontconfig \
     && echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" \
      | debconf-set-selections \
     && apt-get install --no-install-recommends --yes \
        ttf-mscorefonts-installer \
     && fc-cache -fv \
     # clean up
     && apt-get clean \
     && rm --recursive --force \
        /var/lib/apt/lists/*

FROM build-reqs AS build

    WORKDIR /build
    COPY . /build

    RUN cmake . && make

FROM execution-minimal-reqs as execute

    COPY --from=build /build/src/dotprint /bin/dotprint

    WORKDIR /work

    ENTRYPOINT [ "/bin/dotprint" ]
    CMD [ "--help" ]
