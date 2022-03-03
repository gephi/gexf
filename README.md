# GEXF Format

GEXF file format specifications. Details and examples at  [gexf.net](http://gexf.net).

The repository contains both the [specifications](specs) and the [primer](primer) sources.

The latest **stable** version in **1.2**.

# Changelog

Note that we used to use "draft" in certain version (e.g "1.2draft") up until 1.3 when we decided to simply use full versions numbers.

## 1.3 (work in progress)

Compatible with Gephi 0.9.3 and above. Note that part of the specifications were already implemented since 0.9 but full support is only guaranteed in 0.9.3.

- Add `kind` attribute on `edge` to support multi-graph (i.e. parallel edges)
- The edge `weight` is now a `double` instead of a `float`
- The edge `id` is now optional
- Add `xsd:long`as possible `idtype` on `<graph>`
- Add new attribute types `bigdecimal`, `biginteger`, `char`, `short` and `byte`
- Add new list attributes like `listboolean` or `listinteger` for each atomic type

### Dynamics

- Add a `timezone` attribute on `<graph>` to use as a timezone in case it's omitted in the element timestamps
- Open intervals attributes `startopen` and `endopen` are removed. Use regular inclusive `start` and `end` instead
- Remove `mode`, `start` and `end` attributes on `<attributes>` as it was redundant with `<graph>` attributes

#### Timestamp support

Add the ability to represent time with single timestamps instead of intervals. We want feature parity between the two time representations but note they can't be mixed.

- Add a `timerepresentation` enum in `<graph>` with either `interval` (default) or `timestamp` to configure the way the time is represented
- Add `timestamp` attribute to `<node>`, `<edge>`, `<spell>` and `<attvalue>` to support this new time representation

#### Alternative to spell elements

- Add a `timestamps` attribute to `<node>` and `<edge>` to represent a list of timestamps without having to use spells
- Similarly, add a `intervals` attribute to `<node>` and `<edge>`

#### New slice mode

The optional `mode` attribute on `<graph>` now has an additional `slice` value, in addition of `static` and `dynamic`. With slice, the expectation is that the `<graph>` also has either a `timestamp` or `start` / `end` intervals.

- Add a `timestamp` attribute on `<graph>` to characterise the slice this graph represent
- Change the meaning of the `start` and `end` attributes on `<graph>` to either characterise the slide instead of the time bounds, which should rather be inferred

### Viz

- Add `hex` attribute on `<color>` so it can support values like `#FF00FF`
- The `z` position is no longer required
- Dynamic attributes like `start`, `end` or child elements `<spells>` are no longer supported for viz attributes. To represent viz attributes over time, an alternative is to create multiple graphs each representing a slice

## 1.2

Compatible with Gephi 0.8 and above.

- The node and edge `label` attribute are now optional
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
