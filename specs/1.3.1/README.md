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

TWe propose to keep the existing way (1.3) to set viz attributes at the node/edge level to cover the manually set (locally set) use case.

To cover the cases where the viz atts were computed we need to add the specifications which indicates the computation specs. We propose to set this at the data attributes definition level (globally).

#### viz attributes set locally

we propose to keep the viz attributes as they exist. First to ensure retro-compatibility and second because it's a good way to cover cases where viz attributes are set arbitrary by hand. As stated later we propose those local attributes takes over if set concurrently with global specs.

#### viz attributes set globally

We propose to create plural version of viz attributes: `viz:colors`, `viz:sizes`, `viz:positions`, `viz:thicknesses`.
Those tag will host the dynamic definitions of viz attributes.

We propose to include those into the the attributes definition in order to:

- set the rule globally for the graph
- reuse the node/edge class attribute already set in the attributes
- impose to have only one plural viz attributes set by node/edge attributes definition

To represent the dynamic definitions of viz attributes we need to define:

- which attribute to use
- the method: partition, ranking, layout...
- the parameters: color hashmap, domain, spline method...

##### viz-colors

```relaxng
element colors {
    attribute use { id-type }
    attribute method { "ranking" | "partition" }
    element color {
        color-content
        & attribute forvalue {xsd:string}?
        & attribute forratio {xsd: float}?
    }*
    element spline {
        element controlpoint {
            attribute x { xsd:float }
            attribute y { xsd:float }
        }+
    }?
}
```

**Set by a partition**

```xml
<attributes class="node" mode="static">
    <attribute id="modularity_class" title="Modularity Class" type="integer">
        <default>0</default>
    </attribute>
    <viz:colors use="modularity_class" method="partition">
        <viz:color forvalue="1" r="168" g="168" b="29"></viz:color>
    </viz:colors>
</attributes>
```

**Set by a ranking**

```xml
<attributes class="node" mode="static">
    <attribute id="degree" title="Degree" type="integer">
        <default>0</default>
    </attribute>
    <viz:colors use="degree" method="ranking">
        <viz:color forratio="0" r="168" g="168" b="29"></viz:color>
        <viz:color forratio="0.5" r="168" g="168" b="29"></viz:color>
        <viz:color forratio="1" r="168" g="200" b="56"></viz:color>
        <viz:spline>
            <viz:controlpoint x="0" y="1" />
            <viz:controlpoint x="0" y="1" />
        </viz:spline>
    </viz:colors>
</attributes>
```

##### viz-sizes

```relaxng
element sizes {
    attribute use { id-type }
    attribute method { "ranking" }
    element size {
        size-content
        & attribute forratio { xsd:float }
    }*
    element spline {
        element controlpoint {
            attribute x { xsd:float }
            attribute y { xsd:float }
        }+
    }?
}
```

```xml
<attributes class="node" mode="static">
    <attribute id="degree" title="Degree" type="integer">
        <default>0</default>
    </attribute>
    <viz:sizes use="degree" method="ranking">
        <viz:color forratio="0" value="1" ></viz:color>
        <viz:color forratio="0.5" value="4"></viz:color>
        <viz:color forratio="1" value="10"></viz:color>
        <viz:spline>
            <viz:controlpoint x="0" y="1" />
            <viz:controlpoint x="0" y="1" />
        </viz:spline>
    </viz:colors>
</attributes>
```

##### viz-positions

```relaxng
element positions {
    element xpositions {
        attribute use { id-type }?
        attribute method { "ranking" }
        element x {
            attribute forratio { xsd:float }
            attribute value { xsd:float }
        }*
        element spline {
            element controlpoint {
                attribute x { xsd:float }
                attribute y { xsd:float }
            }+
        }?
    }?
    element ypositions {
        attribute use { id-type }?
        attribute method { "ranking" }
        element y {
            attribute forratio { xsd:float }
            attribute value { xsd:float }
        }*
        element spline {
            element controlpoint {
                attribute x { xsd:float }
                attribute y { xsd:float }
            }+
        }?
    }?
    element layout {
        attribute algorithm { xsd:string }
        element param {
            attribute name { xsd:string }
            text
        }
    }?
}
```

**Positions set by a ranking**

```xml
<attributes class="node" mode="static">
    <attribute id="lat" title="Lattitude" type="float">
        <default>0.0</default>
    </attribute>
    <attribute id="lng" title="Longitude" type="float">
        <default>0.0</default>
    </attribute>
    <viz:positions>
        <viz:xpositions use="lat" method="ranking">
            <viz:x forratio="0" value="0" ></viz:color>
            <viz:x forratio="0.5" value="0.4"></viz:color>
            <viz:x forratio="1" value="1"></viz:color>
            <viz:spline>
                <viz:controlpoint x="0" y="1" />
                <viz:controlpoint x="0" y="1" />
            </viz:spline>
        </viz:xpositions>
        <viz:xpositions use="lng" method="ranking" />
    </viz:positions>
</attributes>
```

**Positions set by a layout**

```xml
<attributes class="node" mode="static">
    <attribute id="lat" title="Lattitude" type="float">
        <default>0.0</default>
    </attribute>
    <attribute id="lng" title="Longitude" type="float">
        <default>0.0</default>
    </attribute>
    <viz:positions>
        <viz:layout algorithm="forceatlas2">
            <viz:param name="scale">10</viz:param>
        </viz:layout>
    </viz:positions>
</attributes>
```

| **viz attributes** | **method** |                                     **parameters**                                     |
| :----------------: | :--------: | :------------------------------------------------------------------------------------: |
|   **viz:color**    | partition  |                                {[value:string]: string}                                |
|   **viz:color**    |  ranking   | {domain:{[ratio:number]: string}, spline?:[{x:number, y:number},{x:number, y:number}]} |
|    **viz:size**    |  ranking   | {domain:{min: number, max:number}, spline?:[{x:number, y:number},{x:number, y:number}} |
|  **viz:position**  |   layout   |                     {algorithm:enum, params:{[param:string]:any}}                      |
|   **viz:shape**    | partition  |                                {[value:string]: string}                                |
| **viz:thickness**  |  ranking   | {domain:{min: number, max:number}, spline?:[{x:number, y:number},{x:number, y:number}} |

#### local takes over global

In this proposition there is two ways to set the viz attributes: globally or locally.

A GEXF file can contain both definitions for the same graph.

We propose that implementations reading GEXF must use locally set viz attributes in priority if global rule are also indicated.

### questions

transform missing values
