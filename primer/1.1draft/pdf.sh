#!/bin/bash

prefix=gexf-11draft-primer

# Compile
./compile.sh

# PDF
pdflatex -interaction=nonstopmode $prefix.tex

#acroread $prefix.pdf &
