package main

import (
	"fmt"
	"os"
	"io/ioutil"
	"strings"
)

func check(e error) {
	if e != nil {
		fmt.Println("File not found")
		os.Exit(1)
	}
}

func GetList(filepath string) []string {
	file, e := os.Open(filepath)
	check(e)
	content, e := ioutil.ReadAll(file)
	check(e)

	result := strings.Split(string(content), "\n");

	return result
}

func CheckAndDelete(root string, path string) {
	if len(path) == 0 {
		return
	}

	full_path := root + "/" + path

	_, e := os.Stat(full_path)
	if os.IsNotExist(e) {
		return
	} else {
		os.RemoveAll(full_path)
		fmt.Printf("Removed: %s\n", full_path)
	}
}

func PrintUsage() {
    fmt.Println("Usage: clean [options]\n\t-v, --version\t\tDisplay program version information")
	fmt.Println("\t-h, --help\t\tDisplay this message\n\t-l, --list <p>\t\tSpecify list file")
}

func main() {
	root_dir, _ := os.UserHomeDir()
	list_path := root_dir + "/.config/clean/files.list"

    for idx, val := range os.Args[1:] {
        if val == "-v" || val == "--version" {
            fmt.Println("GoClean v1.0.1")
			os.Exit(0)

        } else if val == "-h" || val == "--help" {
			PrintUsage();
			os.Exit(0)

        } else if val == "-l" || val == "--list" {
            if len(os.Args) == idx + 2 {
                fmt.Println("No file specified")
				os.Exit(0)
            }

            next_arg := os.Args[idx + 2]
            if strings.HasPrefix(next_arg, "-") || strings.HasPrefix(next_arg, "--") {
                fmt.Println("Please specify path to list file")
				os.Exit(0)

            } else {
                list_path = next_arg
                fmt.Printf("Using alternative list file at: %s\n", list_path)
                break

            }
        } else {
            fmt.Printf("Unrecognized option: %s\n", val)
        }
    }

	list := GetList(list_path)
	for _, path := range list {
		CheckAndDelete(root_dir, path)
	}
}
