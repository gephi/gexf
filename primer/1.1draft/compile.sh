#!/bin/bash

prefix=gexf-11draft-primer

# Compile
latex -interaction=nonstopmode $prefix.tex
makeindex $prefix.idx
latex -interaction=nonstopmode $prefix.tex

