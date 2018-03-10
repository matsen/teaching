ALL_MDS = $(wildcard src/*.mds)
ALL = $(notdir $(ALL_MDS:mds=html))

LAST_MDS = $(shell ls -tu src/*.mds | head -1)
LAST = $(notdir $(LAST_MDS:mds=html))

SVGS=$(shell grep svg $(LAST_MDS) | cut -f 2 -d' ')

# Default target: last modified .mds file
last-modified: $(LAST)

all: $(ALL)

%.html: src/%.mds insert.py Makefile build.sh src/simple-small.css
	./build.sh src/$*.mds $@

continuous:
	while :; do inotifywait -e modify $(LAST_MDS); make $(LAST); done

edit:
	vim $(LAST_MDS)

view:
	xdg-open $(LAST)

count:
	grep "<section" $(LAST) | wc -l

png: $(SVGS)
	sed -e 's/\.svg/.svg.png/' $(LAST) > png_$(LAST)
	for i in $(SVGS); do inkscape --without-gui --export-png=$$i.png --export-dpi 200 $$i; done

.PHONY: edit view continuous all default last last-modified
