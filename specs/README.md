# Build

We use the compact syntax of [Relax NG](https://relaxng.org/) to define the format specifications.

Follow these instructions to convert the source files (.rnc files) into destination files (.xsd and .rng).

## Requirements

Install the [trang](https://relaxng.org/jclark/trang.html) utility, also available on [Homebrew](https://formulae.brew.sh/formula/jing-trang) for Mac OS.

## Convert a single file

Run this command to for example convert `gexf.rnc` into `gexf.xsd`:

```trang -I rnc -O xsd 1.3/gexf.rnc 1.3/gexf.xsd```

## Rebuild all

Execute the provided `build.sh` script with the folder name, e.g.

```build.sh 1.3```

---

## Validate

To validate a GEXF file against the specification executre the provided `validate.sh` script with the specs folder name, e.g.

```validate.sh 1.3 test.gexf```