# GEXF 1.3.1

## Legend

As discussed in [1.3 PR](https://github.com/gephi/gexf/pull/13#issuecomment-1010269442) we propose to extend GEXF to include the required information to embed the data which traces which data attribute were used to generate the viz variables.

Such an extension would allow to draw a legend when rendering the graph.

### The problem

For now the nodes/edges viz attributes are stored as static data. This means that we don't why the viz:color has been set to this particular value. It's as if the color has been chosen by hand without any data logic. But very often those viz attributes are actually computed from data attributes using for instance the Partition/Ranking features in Gephi.
In such cases we cant to be able to inform the user when visualizing the graph that the color "red" represent the partition "x" by drawing a legend.

### Proposition 1: viz attributes as data attribute function

Ideally we would like to know the exact way which was used to render such viz attributes.
Viz attributes can be computed from attributes (globally set) or set manually (locally set).

We propose to keep the existing way (1.3) to set viz attributes at the node/edge level to cover the manually set (locally set) use case.

To cover the cases where the viz atts were computed we need to add the specifications which indicates the computation specs. We propose to set this at the data attributes definition level (globally).

#### viz attributes set locally

we propose to keep the viz attributes as they exist. First to ensure retro-compatibility and second because it's a good way to cover cases where viz attributes are set arbitrary by hand. As stated later we propose those local attributes takes over if set concurrently with global specs.

#### viz attributes set globally

We propose to create plural version of viz attributes: `viz:colors`, `viz:sizes`, `viz:positions`, `viz:thicknesses`.
Those tag will host the dynamic definitions of viz attributes.

We propose to include those into the the attribute(s) definitions in order to:

- set the rule globally for the graph
- reuse the node/edge class attribute already set in the attributes
- nest the scale definition inside the corresponding attribute definition

To represent the dynamic definitions of viz attributes we need to define:

- which attribute to use
- the method: partition, ranking, layout...
- the parameters: color hashmap, domain, spline method...

Finally this specification allows to have more than one scale for one viz parameter set in the same gexf file. For instance colors could be derived from two different node attributes type and degree. So we add a defaultscales element to specify which scale has been used to render the colors, sizes (...) in the gexf.

##### viz-colors

**Set by a partition**

```xml
<attributes class="node" mode="static">
    <attribute id="modularity_class" title="Modularity Class" type="integer">
        <default>0</default>
        <viz:colors scale="qualitative">
            <viz:color forvalue="1" r="168" g="168" b="29"/>
            <viz:colordefault r="1" g="1" b="1"/>
        </viz:colors>
    </attribute>
</attributes>
```

**Set by a ranking**

```xml
<attributes class="node" mode="static">
    <attribute id="degree" title="Degree" type="integer">
        <default>0</default>
        <viz:colors use="degree" scale="continuous" scalelabel="greenish gradient">
            <viz:color forratio="0" hex="#EDF8FB"/>
            <viz:color forratio="0.5" hex="#66C2A4"/>
            <viz:color forratio="1" r="0" g="109" b="44"/>
            <viz:colordefault r="1" g="1" b="1"/>
        </viz:colors>
    </attribute>
</attributes>
```

**Two colors scales**

```xml
<attributes class="node" mode="static">
    <attribute id="modularity_class" title="Modularity Class" type="integer">
        <default>0</default>
        <viz:colors scale="qualitative">
            <viz:color forvalue="1" r="168" g="168" b="29"/>
            <viz:colordefault r="1" g="1" b="1"/>
        </viz:colors>
    </attribute>
    <attribute id="degree" title="Degree" type="integer">
        <default>0</default>
        <viz:colors scale="quantitative" scalelabel="greenish gradient">
            <viz:color forratio="0" hex="#EDF8FB"/>
            <viz:color forratio="0.5" hex="#66C2A4"/>
            <viz:color forratio="1" r="0" g="109" b="44"/>
            <viz:colordefault r="1" g="1" b="1"/>
        </viz:colors>
    </attribute>
     <viz:defaultscales  colors="type" />
</attributes>
```

##### viz-shapes

```xml
<attributes class="node" mode="static">
    <attribute id="node_type" title="Type of node" type="string">
        <default>person</default>
        <viz:shapes scale="qualitative">
            <viz:shape forvalue="person" value="disc"></viz:shape>
            <viz:shape forvalue="city" value="square"></viz:shape>
        </viz:shapes>
    </attribute>
</attributes>
```

##### viz-sizes

```xml
<attributes class="node" mode="static">
    <attribute id="degree" title="Degree" type="integer">
        <default>0</default>
        <viz:sizes scale="quantitative" scalelabel="square-root">
            <viz:scalepoint forratio="0" factor="0" ></viz:scalepoint>
            <viz:scalepoint forratio="0.1" factor="0.316227766" ></viz:scalepoint>
            <viz:scalepoint forratio="0.2" factor="0.447213595"></viz:scalepoint>
            <viz:scalepoint forratio="0.3" factor="0.547722558"></viz:scalepoint>
            <viz:scalepoint forratio="0.4" factor="0.632455532"></viz:scalepoint>
            <viz:scalepoint forratio="0.5" factor="0.707106781"></viz:scalepoint>
            <viz:scalepoint forratio="0.6" factor="0.774596669"></viz:scalepoint>
            <viz:scalepoint forratio="0.7" factor="0.836660027"></viz:scalepoint>
            <viz:scalepoint forratio="0.8" factor="0.894427191"></viz:scalepoint>
            <viz:scalepoint forratio="0.9" factor="0.948683298"></viz:scalepoint>
            <viz:scalepoint forratio="1" factor="1"></viz:scalepoint>
            <viz:sizedomain min="1" max="10" default="1" />
        </viz:sizes>
    </attribute>
</attributes>
```

##### viz-thicknesses

```xml
<attributes class="edge" mode="static">
    <attribute id="weightAttribute" title="Weight Attribute" type="integer">
        <default>1</default>
        <viz:thicknesses scale="quantitative">
            <viz:range min="1" max="10" default="1" />
        </viz:thicknesses>
    </attribute>
</attributes>
```

##### viz-positions

**Positions set by a layout**

Since positions layout does not depend on specific attribute we nest it in the attributes element.

```xml
<attributes class="node" mode="static">
    <attribute id="degree" title="Degree" type="integer">
        <default>0</default>
    </attribute>
    <viz:positions layoutalgorithm="forceatlas2" referenceURL="https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0098679">
        <viz:param name="scale" type="integer" value="10"/>
        <viz:param name="stronger gravity" type="boolean" value="true"/>
      </viz:positions>
</attributes>
```

#### local takes over global

In this proposition there is two ways to set the viz attributes: globally or locally.

A GEXF file can contain both definitions for the same graph.

We propose that implementations reading GEXF must use locally set viz attributes in priority if global rule are also indicated.

To ensure the best GEXF compatibility among existing consumers we recommend to set both systematically.
