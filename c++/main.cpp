#include <stdlib.h>

#include <filesystem>
#include <fstream>
#include <iostream>
#include <vector>
#include <map>
#include <utility>

std::vector<std::filesystem::path> getFileList(std::string fp)
{
  std::vector<std::filesystem::path> result;
  std::fstream file(fp, std::ios::in);
  std::string line;

  while (file >> line)
    if (line.size() != 0)
      result.push_back(line);

  return result;
}

void checkAndDelete(const std::string& root, const std::string& path)
{
  std::string finalPath = root + "/" + std::string(path);

  if (std::filesystem::is_directory(finalPath))
  {
    std::filesystem::remove_all(finalPath);
    std::cout << "Removed directory: " << finalPath << '\n';
  }

  if (std::filesystem::is_regular_file(finalPath))
  {
    std::filesystem::remove(finalPath);
    std::cout << "Removed file: " << finalPath << '\n';
  }
}

void printUsage()
{
  std::cout << "Usage clean [options]\n\t-v, --version\tDisplay program version information";
  std::cout << "\n\t-h, --help\tDisplay this message";
  std::cout << "\n\t-l, --list <p>\tSpecifiy alternative list file\n";
}

int main(int argc, char* argv[])
{
  std::string root = getenv("HOME");
  std::string filePath = root + "/.config/clean/files.list";

  std::map<int, std::string> args;
  for (int i = 1; i < argc; ++i)
    args.insert(std::make_pair(i, argv[i]));

  for (auto& kv : args)
  {
    if (!(kv.second.compare("-v") & kv.second.compare("--version")))
    {
      std::cout << "Clean++ v1.0\n";
      return 0;
    }

    else if (!(kv.second.compare("-h") & kv.second.compare("--help")))
    {
      printUsage();
      return 0;
    }

    else if (!(kv.second.compare("-l") & kv.second.compare("--list")))
    {
      if (args.size() < kv.first + 1)
      {
        std::cerr << "Please specify a list file\n";
        return 1;
      }

      filePath = args[kv.first + 1];
      std::cout << "Using list file: " << filePath << '\n';
      break;
    }

    else
    {
      std::cerr << "Unknown option: " << args[kv.first] << '\n';
      return 2;
    }
  }

  if (!std::filesystem::exists(filePath))
  {
    std::cerr << "Could not locate list file: " << filePath << '\n';
    return 3;
  }

  auto list = getFileList(filePath);
  for (const auto& path : list)
    checkAndDelete(root, path);
}
