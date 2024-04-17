# Property Graph Exchange Format (PG)

This repository is going to host a formal specification of Property Graph Exchange Format (PG) and its serializations [PG format](#pg-format), [PG-JSON](#pg-json), and [PG-JSONL](#pg-jsonl) based on the common property graph [data model](#property-graphs).

*THIS IS WORK IN PROGRESS*

## Table of Contents

- [Introduction](#introduction)
- [Property Graph Data Model](#property-graph-data-model)
- [Property Graph Serializations](#property-graph-serializations)
  - [PG format](#pg-format)
  - [PG-JSON](#pg-json)
  - [PG-JSONL](#pg-jsonl)
- [PG format grammar](#pg-format-grammar)
- [Examples](#examples)- 
- [JSON Schemas](#json-schemas)
- [Robustness principle](#robustness-principle)
- [References](#references)
  - [Normative references](#normative-references)
  - [Informative references](#informative-references)

## Introduction

**Property Graphs** (also known as **Labeled Property Graphs**) are used as
abstract data structure in graph databases and related applications. 

Implementations of property graphs slightly differ in support of data types,
restrictions on labels etc. The [definition of property graph used in this
specification](#property-graphs) is aimed to be a superset of property graph
models of common graph databases and formats. The model and its serializations
have first been proposed by Hirokazu Chiba, Ryota Yamanaka, and Shota Matsumoto
([2019](https://arxiv.org/abs/1907.03936),
[2022](https://arxiv.org/abs/2203.06393)) and revised into this specification
together with Jakob Voß.

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL
NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "NOT RECOMMENDED",
"MAY", and "OPTIONAL" in this document are to be interpreted as
described in BCP 14 (RFC 2119 and RFC 8174) when, and only when,
they appear in all capitals, as shown here.

## Property Graph Data Model

A property graph consists of **nodes** and **edges** between these nodes. Each
node has a unique **node identifier**. Each edge is either directed or undirected
and may have an optional **edge identifier**.
Each of the nodes and edges can have **properties** and **labels**. Properties
are mappings from **keys** to non-empty lists of **values**. Node identifiers,
labels, and keys are non-empty Unicode strings. A value is a Unicode string,
a boolean value, or a number as defined by RFC 8259.

The following features are implied by this definition, among others:

- edges connecting a node to itself (self-loops) and multiple edges with same
  direction, labels, and properties (multi-edges) are allowed
- values don't have data types other than string, boolean, and number
- as specified in RFC 8259, implementations may set limits on the range and
  precision of numbers and double precision (IEEE754) is the most likely common limit
- values of the same property key are allowed to have different types
- a property must have at least one value
- the meaning of labels and property keys is out of the scope of this specification
- there are no graph attributes, hierarchies, hyper-edges or other extened features


## Property Graph Serializations

### PG format

A **PG format** document allows writing down a property graph in a compact textual
form. A PG format document is a Unicode string that conforms to grammar and
additional constraints going to be defined in this specification.

*See <https://github.com/orgs/pg-format/discussions> and <https://github.com/pg-format/pg-formatter/wiki> for discussion and references*

Some preliminary rules before full definition of the format:

#### Basic structure

A PG format document encodes a property graph as Unicode string. The document
MUST be encoded in UTF-8 (RFC 3629). Unicode codepoints can also be given by
escape sequences in quoted strings.

The document consists of statements, each defining a [node](#nodes) or an
[edge](#edges). Empty statements consisting of nothing but whitespace and/or
a [comment](#comments) ar ignored.

#### Nodes

##### Implicit nodes

Node identifiers referenced in edges imply the existence of nodes with these
identifiers. For instance the following documents encode the same graph:

~~~pg
a -> b
~~~

~~~pg
a
b
a -> b
~~~

#### Node merging

Parts of the same node can be defined at multiple places in a PG format
document. Nodes definitions with same identifier are merged by appending labels
and property values. For instance the document

~~~pg
a :x k:1 m:true
a :y k:2
~~~

encodes the graph

~~~pg
a :x :y k:1,2 m:true
~~~

#### Edges

##### Multi-edges

The Property Graph Data Model allows for multiple edges between same nodes. For
instance the following graph contains two indistinguishable edges:

~~~pg
a -> b :follows since:2024
a -> b :follows since:2024
~~~

##### Edge identifiers

Optional edge identifiers can be preceded an edge, directly followed by a colon
and whitespace. The following examples extends the previous example with
individual identifiers for each edge: 

~~~pg
1: a -> b :follows since:2024
2: a -> b :follows since:2024
~~~

Edge identifiers MUST NOT be repeated. For instance the following is invalid:

~~~pg
1: a -> b :follows
1: a -> b since:2024
~~~

#### Comments

A comment begin with a hash (`#` = `U+0023`) and ends at the next line break
or at the end of the document.

### PG-JSON

A **PG-JSON** document serializes a property graph in JSON. A PG-JSON document
is a JSON document (RFC 8259) with a JSON object with exactely two fields:

- `nodes` an array of nodes
- `edges` an array of edges

Each node is a JSON object with exactely three fields:

- `id` the node identifier, being a non-empty string.
  Node identifiers MUST be unique per PG-JSON document.
- `labels` an array of labels, each being a non-empty string.
  Labels MUST be unique per node.
- `properties` a JSON object mapping non-empty strings as property keys to
  non-empty arrays of scalar JSON values (string, number, boolean) as property values.

Each edge is a JSON object with one optional and four mandatory fields:

- `id` (optional) the edge identifier, being a non-empty string.
  Edge identifiers MUST be unique per PG-JSON document.
- `undirected` (optional) a boolean value whether the edge is undirected
- `from` an identifier of a node in this graph
- `to` an identifier of a node in this graph
- `labels` and `properties` as defined above at nodes

### PG-JSONL

A **PG-JSONL** document or stream serializes a property graph in JSON Lines
format, also known as newline-delimited JSON. A PG-JSONL document is a sequence
of JSON objects, separated by line separator (`U+000A`) and optional whitespace
(`U+0020`, `U+0009`, and `U+000D`) around JSON objects, and an optional line
separator at the end. Each object is

- either a node with field `type` having string value `"node"` and the same
  mandatory node fields from PG-JSON format,
- or an edge with field `type` having string value `"edge"` and the same
  mandatory edge fields from PG-JSON format.

Node objects SHOULD be given before their node identifiers are referenced in an
edge object but applications MAY also create implicit node objects for this
cases. Applications MAY allow multiple node objects with same node identifier
in PG-JSONL but they MUST make clear whether nodes with repeated identifier are
ignored, merged into existing nodes, or replace existing nodes.

## PG format grammar

*Will be provided*

## Examples

*This section is non-normative!*

...

## JSON Schemas

The [PG-JSON format](#pg-json) can be validated with a non-normative JSON Schema file [`pg-json.json`](schema/pg-json.json) in this repository. Rules not covered by the JSON schema include:

- nodes referenced in edges must be defined (no implicit nodes)
- node identifiers must be unique per graph
- edge identifiers must be unique per graph

The [PG-JSONL format](#pg-jsonl) can be validated with a non-normative JSON Schema file [`pg-jsonl.json`](schema/pg-jsonl.json) in this repository. Validation is limited in the same way as validation of PG-JSON with its JSON Schema.

## Robustness principle

*This section is non-normative!*

Applications may automatically convert documents not fully conforming to the specification of PG-JSON and/or PG-JSONL to valid form, for instance by:

- creation of implicit nodes for node identifiers referenced in edges
- addition of missing empty fields `labels` and/or `properties`
- removal or mapping of invalid property values such as `null` and JSON objects
- mapping of numeric node identifiers and edge identifiers to strings
- removal of additional fields not defined in this specification

## References

### Normative References

- Bradner, S.: Key words for use in RFCs to Indicate Requirement Levels.
  BCP 14, RFC 2119, March 1997,
  <http://www.rfc-editor.org/info/rfc2119>.
              
- Bray, T.: The JavaScript Object Notation (JSON) Data Interchange Format.
  RFC 8259, December 2017. <https://tools.ietf.org/html/rfc8259>

- Leiba, B.:  Ambiguity of Uppercase vs Lowercase in RFC 2119 Key Words.
  BCP 14, RFC 8174, May 2017,
  <http://www.rfc-editor.org/info/rfc8174>.
  
- The Unicode Consortium: The Unicode Standard.
  <http://www.unicode.org/versions/latest/>

- Yergeau, F.: UTF-8, a transformation format of ISO 10646.
  RFC 3629, November 2003. <https://tools.ietf.org/html/rfc3629>

### Informative references

- [JSON Schema](https://json-schema.org/) schema language

- [IEEE Standard for Floating-Point Arithmetic](https://doi.org/10.1109/IEEESTD.2019.8766229)

