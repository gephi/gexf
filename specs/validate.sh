#!/bin/bash

Help()
{
   # Display Help
   echo "Validate a GEXF file against a specification (gexf.rnc file)"
   echo
   echo "Syntax: validate.sh [spec folder] [GEXF file]"
   echo
}

dir=$1
file=$2

if [ -z "$dir" ] || [ -z "$file" ]
then
   Help
   exit
fi

echo "Validating against specifications in $dir"

jing -cf $dir/gexf.rnc $file

status=$?
[ $status -eq 0 ] && echo "No errors found"