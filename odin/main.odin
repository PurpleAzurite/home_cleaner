package main

import "core:fmt"
import "core:os"
import "core:strings"

get_list :: proc(fp: string) -> []string {
	content, _ := os.read_entire_file_from_filename(fp);

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

main :: proc() {
	b := strings.builder_make();
	user_root := os.get_env("USERPROFILE");
	strings.write_string(&b, user_root);
	strings.write_string(&b, "/.config/clean/files.list");
	list_path := strings.to_string(b);

	list := get_list(list_path);
	for path in list {
		check_and_remove(user_root, path);
	}
}
