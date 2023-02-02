#!/bin/sh

# Using Code page 857 Turkish table
# Shifting right to give more space for punch holes
docker run --rm -v "$(pwd)":/work dotprint:latest \
    --translator tables/cp857.trans \
    --margins 10,5,10,15 \
    --preprocessor epson \
    --output output.pdf \
    input.txt