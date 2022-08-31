INPUT = main.cr
OUTPUT = clean
CC = crystal
CFLAGS = build --release

main: $(INPUT)
	$(CC) $(CFLAGS) -o $(OUTPUT) $(INPUT) && strip --strip-all $(OUTPUT)

tidy:
	rm -v clean

install: $(OUTPUT)
	cp -v $(OUTPUT) /usr/local/bin/

uninstall:
	rm -v /usr/local/bin/$(OUTPUT)
