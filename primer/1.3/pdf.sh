#!/bin/bash

prefix=gexf-13-primer

# Compile
./compile.sh

# PDF
pdflatex -interaction=nonstopmode $prefix.tex

#acroread $prefix.pdf &
