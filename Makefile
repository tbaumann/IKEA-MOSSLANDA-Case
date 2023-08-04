.SUFFIXES: 
.SUFFIXES: .3mf .stl .png

models = Case.scad


generated/%.3mf: %.scad
	openscad --export-format 3mf -o $@ $<

generated/%.stl: %.scad
	openscad --export-format stl -o $@ $<

generated/%.png: %.scad
	openscad --export-format png -o $@ $<

all: generated/Case.3mf generated/Case.stl generated/Case.png

