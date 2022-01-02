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

echo "Rebuilding all files in $dir"

while IFS= read -r -d $'\0' rncfile; do
  echo "Building file $(basename "${rncfile}")"
  trang -I rnc -O xsd $rncfile $dir/$(basename "${rncfile}" .rnc).xsd
  trang -I rnc -O rng $rncfile $dir/$(basename "${rncfile}" .rnc).rng
done < <(find "$dir" -name "*.rnc" -print0)
