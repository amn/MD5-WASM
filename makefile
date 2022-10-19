SRCDIR = $(dir $(lastword $(MAKEFILE_LIST)))

all: $(DESTDIR)MD5.wasm

$(DESTDIR)MD5.wasm: %.wasm: %.wat | $(DESTDIR)
	wat2wasm $< -o $@

$(DESTDIR)MD5.wat: $(DESTDIR)%.wat: $(SRCDIR)%.wat.m4 | $(DESTDIR)
	m4 $< > $@

$(DESTDIR):
	mkdir -p $@

.INTERMEDIATE: $(DESTDIR)MD5.wat
