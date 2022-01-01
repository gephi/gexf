#!/bin/sh

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

echo "Rebuilding all XSD files in $dir"

trang -I rnc -O xsd $dir/data.rnc $dir/data.xsd
trang -I rnc -O xsd $dir/dynamics.rnc $dir/dynamics.xsd
trang -I rnc -O xsd $dir/hierarchy.rnc $dir/hierarchy.xsd
trang -I rnc -O xsd $dir/phylogenics.rnc $dir/phylogenics.xsd
trang -I rnc -O xsd $dir/viz.rnc $dir/viz.xsd
trang -I rnc -O xsd $dir/gexf.rnc $dir/gexf.xsd

echo "Rebuilding all RNG files in $dir"

trang -I rnc -O rng $dir/data.rnc $dir/data.rng
trang -I rnc -O rng $dir/dynamics.rnc $dir/dynamics.rng
trang -I rnc -O rng $dir/hierarchy.rnc $dir/hierarchy.rng
trang -I rnc -O rng $dir/phylogenics.rnc $dir/phylogenics.rng
trang -I rnc -O rng $dir/viz.rnc $dir/viz.rng
trang -I rnc -O rng $dir/gexf.rnc $dir/gexf.rng