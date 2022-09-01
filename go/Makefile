INPUT = main.go
CC = go
CFLAGS = -ldflags "-s -w"
OUTPUT = clean

main: $(INPUT)
	$(CC) build $(CFLAGS) -o $(OUTPUT)


tidy: $(OUTPUT)
	rm -v $(OUTPUT)

install: $(OUTPUT)
	cp -v $(OUTPUT) /usr/local/bin/

uninstall:
	rm -v /usr/local/bin/$(OUTPUT)
