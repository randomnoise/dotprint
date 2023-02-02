#!/bin/sh

# Monospaced fonts are successful
# e.g. Courier New (this is the default one), Consolas,
# Droid Sans Mono, Liberation Mono
# change with: --font-face "Consolas"

# Using Code page 857 Turkish table
# Shifting right to give more space for punch holes
docker run --rm -v $(pwd):/work local-dotprint \
    --translator tables/cp857.trans \
    --margins 10,5,10,15 \
    --preprocessor epson \
    --output output.pdf \
    input.txt
