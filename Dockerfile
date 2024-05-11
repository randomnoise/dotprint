FROM alpine:3.19 as stage

RUN apk --no-cache add glibmm-dev cairomm-dev gcc g++ cmake make

COPY . /build

WORKDIR /build

RUN cmake . && make

FROM alpine:3.19
LABEL MAINTAINER="github/@rusq"

RUN apk --no-cache add libstdc++ cairomm glibmm \
msttcorefonts-installer ttf-droid ttf-liberation

RUN update-ms-fonts && fc-cache -f

COPY --from=stage /build/src/dotprint /bin/dotprint

WORKDIR /work

ENTRYPOINT [ "/bin/dotprint" ]
CMD [ "--help" ]
