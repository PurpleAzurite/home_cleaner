INPUT = main.cpp
CC = clang++
CFLAGS = -std=c++2a -Wall -Wextra -Wpedantic -O3
OUTPUT = clean

main: $(INPUT)
	$(CC) $(CFLAGS) -o $(OUTPUT) $(INPUT) && strip --strip-all $(OUTPUT)

tidy: $(OUTPUT)
	rm -v $(OUTPUT)

install: $(OUTPUT)
	cp -v $(OUTPUT) /usr/local/bin/

uninstall:
	rm -v /usr/local/bin/$(OUTPUT)
