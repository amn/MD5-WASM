SRCDIR = $(dir $(lastword $(MAKEFILE_LIST)))

all: $(DESTDIR)MD5.wasm

$(DESTDIR)MD5.wasm: $(DESTDIR)%.wasm: $(SRCDIR)%.wat | $(DESTDIR)
	wat2wasm $< -o $@

$(DESTDIR):
	mkdir $@
