# Build

We use the compact syntax of [Relax NG](https://relaxng.org/) to define the format specifications.

Follow these instructions to convert the source files (.rnc files) into destination files (.xsd and .rng).

## Requirements

Install the [trang](https://relaxng.org/jclark/trang.html) utility, also available on [Homebrew](https://formulae.brew.sh/formula/jing-trang) for Mac OS.

## Convert a single file

Run this command to for example convert `gexf.rnc` into `gexf.xsd`.

```trang -I rnc -O xsd 1.3/gexf.rnc 1.3/gexf.xsd```

## Rebuild all

Execute the provided `build.sh` script with the folder name, e.g

```build.sh 1.2draft```

---

# Changelog

Note that we used to use "draft" in certain version (e.g "1.2draft") up until 1.3 when we decided to simply use full versions numbers.

## 1.3

Compatible with Gephi 0.9.3 and above.

## 1.2

Compatible with Gephi 0.8 and above.

### Graph structure

- The node `label` attribute is now optional
- `<meta>` should be placed before `<graph>`

### Dynamics

- Rename the `timetype` attribute to `timeformat`. This attribute is set on `<graph>` to specify how time information is encoded, either like a date or like a double.
- The `timeformat` is currently either `float` or `date` and default value is `date`. The `float` type is replaced by `double`, and is now the default value.
- Added `timeformat` types `integer` and `dateTime`. DateTime is equivalent to timestamps.
- Add open intervals (non-inclusive): `startopen` and `endopen` attributes.
- `<slices>` and `<slice>` are renamed `<spells>` and `<spell>` respectively because slices are a different concept as remarked.

### Viz

- Add viz attributes support for dynamics.
- Add the alpha channel to RGB. Colors are now encoded in RGBA. It is a float from 0.0 (invisible) to 1.0 (fully visible). If omitted, the default alpha-value is 1.0 (no transparency).

## 1.1

Compatible with Gephi 0.7 and above.

-  Modules are stabilized and new ones appear: hierarchy and phylogeny.

## 1.0

Compatible with Gephi 0.6 and above.

- First specification. Basic topology, associated data and dynamics attempt constitute the core, plus a visualization extension.
