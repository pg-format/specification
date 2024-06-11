# Property Graph Exchange Format (PG)

This repository hosts a formal specification of **Property Graph Exchange
Format (PG)** and its serializations **PG format**, **PG-JSON**, and
**PG-JSONL** based on the common **property graph data model**.

## State of publication

The specification is written with [quarto](https://quarto.org/) and going to be
published at <https://pg-format.github.io/specification/>.

Source files:

- `index.qmd`: specification in Quarto Markdown
- `_quarto.yml`: quarto configuration
- `script.js` and `style.css`: additional JavaScript and CSS

Calling `quarto render` or `make` updates the HTML version in directory `docs`.

Calling `make pg.xml` updates the syntax highlighting file [from pg-highlight](https://github.com/pg-format/pg-highlight/blob/main/kate/pg.xml).

## Test suite

Directory [tests](tests) contains a test suite with valid and invalid data to
test against.

