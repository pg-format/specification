# Property Graph Exchange Format (PG)

This repository is going to host a formal specification of Property Graph
Exchange Format (PG) and its serializations **PG format**, **PG-JSON**, and
**PG-JSONL** based on the common **property graph data model**.

## State of publication

The specification is written with [quarto](https://quarto.org/) and going to be
published at <https://pg-format.github.io/specification/>.

Source files:

- `index.qmd`: specification in Quarto Markdown
- `_quarto.yml`: quarto configuration
- `pg.xml`: draft of Kate syntax highlighting file of PG format
- `script.js` and `style.css`: additional JavaScript and CSS

Calling `quarto render` will update the HTML version in directory `docs`.
