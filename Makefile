default:
	quarto render

update: pg.xml default

pg.xml:
	wget -N https://github.com/pg-format/pg-highlight/raw/main/kate/pg.xml
