#!/bin/bash

prefix=gexf-12draft-primer

# Compile
latex -interaction=nonstopmode $prefix.tex
makeindex $prefix.idx
latex -interaction=nonstopmode $prefix.tex

