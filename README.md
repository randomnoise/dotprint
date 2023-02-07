# What is it?
dotprint is a tool that can be used to convert text files that include escape sequences for Epson dot matrix printers into PDF files.

Nowadays you are not likely to come across such files often but they were common in the "bad old days" of DOS. Programs would often assume an "epson-compatible" dot matrix printer and would embed the escape sequences (for e.g. condensed or expanded font) into the output.

If you want to use such files now, converting them into PDF is quite useful. You can send them to others and you can print them out on other printers than just dot matrix printers. But please note that only a few escape sequences are supported. :-(

So this might be useful to you if you are still running some DOS applications, perhaps in dosemu. With some scripting you can make the old DOS applications produce PDFs.

The input file encoding is expected to be a simple singl ebyte encoding, as would be common in the DOS days. It can be specified using a translation table. E.g. if your input file is in CP850 you can run dotprint lik this:
```
dotprint -t tables/cp850.trans --output myfile.pdf myfile.PRN
```
The translation files are delivered with dotprint in the tables folder.
TODO: Specifiy an installation directory for the translation tables and reference this folder here.

# Compiling

First you need to install the required dependencies. These are:

* glibmm-2.4
* cairomm-10.

In Debian/Ubuntu you can get them via:

    apt install libglibmm-2.4-dev libcairomm-1.0-dev

CMake is used for the build. It's possible to configure and build the program by:

    cmake . && make

Prefix can be specified by adding `-DCMAKE_INSTALL_PREFIX=prefix` to the CMake invocation. Default is `/usr/local`.

# Installing
Run the `install` make target:

    make install

You can specify your own `DESTDIR`.

# Usage

You need to specify:

* the input file (text input with potential escape sequences, in UTF-8 encoding)
* the output file (PDF)

You can specify also the preprocessor using `-P` option. It defaults to epson. The original idea was to potentially support other printer escape codes. But currently only `epson`, `simple` and `crlf` (with the latter two not processing any escapes).

A typial invocation of dotprint looks like this:

    dotprint input-file.txt -o output-file.pdf

Run `dotprint -h` for a list of all the options.

# Building Docker Container

This might be useful if you're using macOS and don't have development tools or C++ compiler, but have Docker.

To build the docker container, run:

    ./build-docker.sh

This will build `dotprint:latest` image based on `alpine:latest` with some preinstalled font (including the Courier New, which is used by default).

# Running in Docker

The easy way to run conversion is:

    ./convert.sh input.prn -o output.pdf

Docker container has `dotprint` as an entry point and any options specified on the command line are the commands are passed to the dotprint executable.

If you need to run this manually, you'd need to volume-mount the current directory to `/work` directory of the container, i.e.:

    docker run --rm -v `pwd`:/work dotprint \
        -P epson \
        tests/test4.ASCII.prn \
        -o output.pdf

# Licence

GNU GPL 3 or newer.
