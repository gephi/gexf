#!/bin/bash

prefix=gexf-12draft-primer

# Compile
./compile.sh

# PDF
pdflatex -interaction=nonstopmode $prefix.tex

#acroread $prefix.pdf &
