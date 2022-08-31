#!/bin/bash

prefix=gexf-131-primer

# Compile
latex -interaction=nonstopmode $prefix.tex
makeindex $prefix.idx
latex -interaction=nonstopmode $prefix.tex

