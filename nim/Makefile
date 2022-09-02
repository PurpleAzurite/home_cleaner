INPUT = main.nim
CC = nim
OUTPUT = clean

main: $(INPUT)
	$(CC) c -r -o:$(OUTPUT) --opt:size $(INPUT) && strip --strip-all $(OUTPUT)

tidy: $(OUTPUT)
	rm -v $(OUTPUT)

install: $(OUTPUT)
	cp -v $(OUTPUT) /usr/local/bin/

uninstall:
	rm -v /usr/local/bin/$(OUTPUT)
