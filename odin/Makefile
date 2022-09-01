INPUT = main.odin
CC = odin
OUTPUT = clean.out

main: main.odin
	$(CC) build $(INPUT) -file -out:$(OUTPUT)

tidy: $(OUTPUT)
	rm -v $(OUTPUT)

install: $(OUTPUT)
	cp -v $(OUTPUT) /usr/local/bin/

uninstall:
	rm -v /usr/local/bin/$(OUTPUT)
