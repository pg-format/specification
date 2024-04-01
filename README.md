# Property Graph Exchange Format (PG)

This repository is going to host a formal specification of Property Graph Exchange Format (PG) and its serializations [PG format](#pg-format), [PG-JSON](#pg-json), and [PG-JSONL](#pg-jsonl) based on the common property graph [data model](#property-graphs).

*THIS IS WORK IN PROGRESS*

## Table of Contents

- [Introduction](#introduction)
- [Property Graphs](#property-graphs)
- [Serializations](#serializations)
  - [PG format](#pg-format)
  - [PG-JSON](#pg-json)
  - [PG-JSONL](#pg-jsonl)
- [Examples](#examples)
- [PG format grammar](#pg-format-grammar)
- [JSON Schemas](#json-schemas)
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
[2022](https://arxiv.org/abs/2203.06393)).


## Property graphs

A property graph consists of **nodes** and **edges** between these nodes. Each
node has a unique **node identifier**. Each edge can be directed or undirected.
Each of the nodes and edges can have **properties** and **labels**. Properties
are mappings from **keys** to non-empty lists of **values**. Node identifiers,
labels, and keys are non-empty Unicode strings. A value is a Unicode string,
a boolean value, or a number as defined by RFC 8259.

The following features are implied by this definition, among others:

- edges don't have identifiers
- edges connecting a node to itself (self-loops) and multiple edges with same
  direction, labels, and properties (multi-edges) are allowed
- values don't have data types other than string, boolean, and number
- as specified in RFC 8259, implementations may set limits on the range and
  precision of numbers and double precision (IEEE754) is the most likely common limit
- values of the same property key are allowed to have different types
- a property must have at least one value
- the meaning of labels and property keys is out of the scope of this specification
- there are no graph attributes, hierarchies, hyper-edges or other extened features


## Serializations

### PG format

A **PG format** document allows writing down a property graph in a compact textual
form. A PG format document is a Unicode string that conforms to grammar and
additional constraints going to be defined in this specification.

A PG format document MUST be encoded in UTF-8 (RFC 3629).

...

*See <https://github.com/orgs/pg-format/discussions> and <https://github.com/pg-format/pg-formatter/wiki> for discussion and references*


### PG-JSON

A **PG-JSON** document serializes a property graph in JSON. A PG-JSON document is a JSON 
document (RFC 8259) with a JSON object with exactely two fields:

- `nodes` an array of nodes
- `edges` an array of edges

Each node is a JSON object with exactely three fields:

- `id` the internal node identifier, being a non-empty string. Node identifiers MUST be unique per PG-JSON document.
- `labels` an array of labels, each being a non-empty string. Labels MUST be unique per node.
- `properties` a JSON object mapping non-empty strings as property keys to non-empty arrays of scalar JSON values (string, number, boolean) as property values.

Each edge is a JSON object with one optional and four mandatory fields:

- `undirected` (optional) a boolean value whether the edge is undirected
- `from` an identifier of a node in this graph
- `to` an identifier of a node in this graph
- `labels` and `properties` as defined above at nodes

### PG-JSONL

A **PG-JSONL** document serializes a property graph in JSON Lines format, also
known as newline-delimited JSON. A PG-JSONL document is a sequence of JSON
objects, separated by line separator (`U+000A`) and optional whitespace
(`U+0020`, `U+0009`, and `U+000D`) around JSON objects, and an optional line
separator at the end. Each object is

- either a node with field `type` having string value `"node"` and the same mandatory node fields from PG-JSON format,
- or an edge with field `type` having string value `"edge"` and the same mandatory edge fields from PG-JSON format.

Applications MAY accept objects that can automatically be transformed to valid
form, for instance a missing `type` field inferred from existence of fields
`from` and `to`.

## Examples

...

## PG format grammar

...

## JSON Schemas

*This section is non-normative*

The [PG-JSON format](#pg-json) can be validated with JSON Schema file [`pg-json.json`](schema/pg-json.json) in this repository. Rules not covered by the JSON schema include:

- nodes referenced in edges must be defined (no implicit nodes)
- node identifiers must be unique per graph (no repeated nodes)

Applications MAY accept documents not fully conforming to this specification when they can automatically be transformed to valid form, for instance:

- creation of implicit nodes for node identifiers referenced in edges
- add empty `labels` and/or `properties` if not specified

The [PG-JSONL format](#pg-jsonl) can be validated with JSON Schema file [`pg-jsonl.json`](schema/pg-jsonl.json) in this repository. Validation is limited in the same way as validation of PG-JSON with its JSON Schema.


## References

### Normative References

- Bray, T.: The JavaScript Object Notation (JSON) Data Interchange Format.
  RFC 8259, December 2017. <https://tools.ietf.org/html/rfc8259>

- The Unicode Consortium: The Unicode Standard.
  <http://www.unicode.org/versions/latest/>

- Yergeau, F.: UTF-8, a transformation format of ISO 10646.
  RFC 3629, November 2003. <https://tools.ietf.org/html/rfc3629>

### Informative references

- [JSON Schema](https://json-schema.org/) schema language

- IEEE, "IEEE Standard for Floating-Point Arithmetic", IEEE 754.

