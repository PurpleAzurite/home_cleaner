import os
import sys
import shutil


def check_and_delete(root_dir, path):
    final_path = root_dir + '/' + path
    if os.path.isdir(final_path):
        shutil.rmtree(final_path)
        print("Removed directory:", final_path)

    elif os.path.isfile(final_path):
        print("Removed file:", final_path)
        os.remove(final_path)


def main():
    root_dir = os.path.expanduser('~')
    list_path = root_dir + "/.config/clean/files.list"

    for idx, arg in enumerate(sys.argv[1:]):
        if arg == "-v" or arg == "--version":
            print("Clean v1.0")
            exit(0)

        elif arg == "-h" or arg == "--help":
            print("Usage: clean [option]\n\t-v, --version\tDisplay program version information")
            print("\t-h, --help\tDisplay this message")
            print("\t-l, --list <p>  Specify an alternative list file")
            exit(0)

        elif arg == "-l" or arg == "--list":
            if len(sys.argv[1:]) < idx + 2:
                print("Please specify a list file")
                exit(1)

            list_path = sys.argv[idx + 2]
            print("Using list file:", list_path)
            break

        else:
            print("Unknown option:", arg)
            exit(2)


    items = list()
    try:
        items = list(filter(lambda x: len(x) > 0, open(list_path).read().split('\n')))

    except:
        print("Could not find file:", list_path)
        exit(3)

    for i in items:
        check_and_delete(root_dir, i)


if __name__ == "__main__":
    main()
