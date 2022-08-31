#!/bin/bash

prefix=gexf-131-primer

# Compile
./compile.sh

# PDF
pdflatex -interaction=nonstopmode $prefix.tex

#acroread $prefix.pdf &
