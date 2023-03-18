#!/bin/bash

Help()
{
   # Display Help
   echo "Rebuild all RNG and XSD files from RNC sources"
   echo
   echo "Syntax: build.sh [folder]"
   echo
}

dir=$1

if [ -z "$dir" ]
then
   Help
   exit
fi

echo "Cleanup all files in $dir"

while IFS= read -r -d $'\0' xsdfile; do
  rm $xsdfile
done < <(find "$dir" -name "*.xsd" -print0)

while IFS= read -r -d $'\0' rngfile; do
  rm $rngfile
done < <(find "$dir" -name "*.rng" -print0)

echo "Rebuilding all files in $dir"

trang -I rnc -O xsd $dir/gexf.rnc $dir/gexf.xsd
trang -I rnc -O rng $dir/gexf.rnc $dir/gexf.rng
