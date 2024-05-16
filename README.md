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
- `script.js` and `style.css`: additional JavaScript and CSS
- `pg.xml`: Kate syntax highlighting file of PG format ([source](https://github.com/pg-format/pg-highlight))

Calling `quarto render` will update the HTML version in directory `docs`.
