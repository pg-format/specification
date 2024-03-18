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
edge can be directed or undirected.  Each of the nodes and edges can have
**labels** and **properties**. Properties are key-value pairs where the same
key can have multiple values. Labels and property keys are non-empty Unicode strings.
Property values are Unicode strings, numbers or the null-value.


## Serializations

### PG format

A **PG format** document allows writing down a property graph in a compact textual
form. A PG format document is a Unicode string that conforms to grammar and
additional constraints going to be defined in this specification.

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
- `properties` a JSON object mapping non-empty strings as property keys to non-empty arrays of scalar JSON values (string, number, boolean, or null) as property values.

Each edge is a JSON object with one optional and four mandatory fields:

- `undirected` (optional) a boolean value whether the edge is undirected
- `from` an identifier of a node in this graph
- `to` an identifier of a node in this graph
- `labels` and `properties` as defined above at nodes

The PG-JSON format is also defined by a non-normative JSON Schema file [`pg-schema.json`](pg-schema.json) in this repository. Rules not covered by the JSON schema:

- node ids must be unique per graph
- nodes referenced in edges must be defined

Applications MAY accept documents not fully conforming to this specification when they can automatically be transformed to valid form, for instance:

- creation of missing nodes for node identifiers referenced in edges
- add empty `labels` and/or `properties` if not specified


### PG-JSONL

A **PG-JSONL** document serializes a property graph in JSON Lines format, also
known as newline-delimited JSON. A PG-JSONL document is a sequence of JSON
objects, separated by line separator (`U+000A`) and optional whitespace
(`U+0020`, `U+0009`, and `U+000D`) around JSON objects. Each object is

- either a node with field `type` having string value `"node"` and the same mandatory node fields from PG-JSON format,
- or an edge with field `type` having string value `"edge"` and the same mandatory edge fields from PG-JSON format.

Applications MAY accept objects that can automatically be transformed to valid
form, for instance a missing `type` field inferred from existence of fields
`from` and `to`.

## Examples

...

## PG format grammar

...


## References

### Normative References

- Bray, T.: The JavaScript Object Notation (JSON) Data Interchange Format.
  RFC 7159, March 2014. <https://tools.ietf.org/html/rfc7159>

- The Unicode Consortium: The Unicode Standard.
  <http://www.unicode.org/versions/latest/>

### Informative references

- [JSON Schema](https://json-schema.org/) schema language
- ...

