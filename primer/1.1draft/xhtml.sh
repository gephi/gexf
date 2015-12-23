#!/bin/bash

#if !( [[ -f $1 ]] ) then
#    echo "usage: latex2xhtml source.tex"
#    exit 1
#fi

#tex=$1
#prefix=${tex%.tex}
prefix=gexf-11draft-primer

# convert latex to html4
latex2html -no_reuse -strict -split 0 -show_section_numbers -html_version 4.0,latin1,unicode -no_footnode -numbered_footnotes -address 0 -info 0 -no_navigation -iso_lang "EN.US" -no_auto_link -link 0 -style W3C-REC.css -image_type png $1 # -no_subdir

# transform html4 to xhtml 1.0
tidy --clean y --doctype "transitional" --output-xhtml y --indent "auto" --wrap "90" --char-encoding "utf8" $prefix.html > $prefix.xhtml

# clean tmp file
rm $prefix.html
mv $prefix.xhtml $prefix.html

# open browser
firefox $prefix.html &
