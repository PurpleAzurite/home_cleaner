package main

import "core:fmt"
import "core:os"
import "core:strings"

get_list :: proc(fp: string) -> []string {
	if !os.exists(fp) {
		fmt.printf("List file not found: %s\n", fp)
		return {}
	}

	content, e := os.read_entire_file_from_filename(fp);

	return strings.split(string(content), "\n");
}

check_and_remove :: proc(user_root: string, path: string) {
	if len(path) == 0 do return

	b := strings.builder_make();
	strings.write_string(&b, user_root);
	strings.write_string(&b, "/");
	strings.write_string(&b, path);
	final_path := strings.to_string(b);

	if os.exists(final_path) {
		if os.is_file(final_path) {
			os.remove(final_path);

		// Odin has no recursive dir removing function
		} else if os.is_dir(final_path) {
			os.remove_directory(final_path)
		}

		fmt.printf("Removed: %s\n", final_path)
	}
}

print_usage :: proc() {
	fmt.printf("Usage: clean [options]\n\t-v, --version\tDisplay program version information\n\t-h, --help\tDisplay this message\n\t-l, --list <p>\tSpeciy alternative list file\n")
}

main :: proc() {
	b := strings.builder_make();
	user_root := os.get_env("USERPROFILE");
	strings.write_string(&b, user_root);
	strings.write_string(&b, "/.config/clean/files.list");
	list_path := strings.to_string(b);

	for i, idx in os.args[1:] {
		if i == "-v" || i == "--version" {
			fmt.println("Clean v1.0")
			return

		} else if i == "-h" || i == "--help" {
			print_usage()
			return

		} else if i == "-l" || i == "--list" {
			next_arg := os.args[idx + 2]
			list_path = next_arg
			fmt.printf("Using alternative list file: %s\n", next_arg)
			break

		} else {
			fmt.printf("Unrecognized option: %s", i)
		}
	}

	list := get_list(list_path);
	for path in list {
		check_and_remove(user_root, path);
	}
}
