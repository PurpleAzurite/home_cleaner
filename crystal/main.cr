require "option_parser"
require "file_utils"

iname_list_path = Path.home.to_s + "/.config/clean/files.list"

OptionParser.parse do |parser|
   parser.banner = "CrystalClear\nUsage: clean [options]"

   parser.on "-v", "--version", "Prints application version information" do
     puts "CrystalClear v1.3.1"
     exit
   end

   parser.on "-h", "--help", "Prints this message" do
     puts parser
     exit
   end

   parser.on "-l PATH", "--list=PATH", "Specifies the list file to use instead" do |path|
     iname_list_path = path
   end

   parser.missing_option do |flag|
     STDERR.puts "#{flag} is missing required arugment"
     exit
   end

   parser.invalid_option do |flag|
     STDERR.puts "#{flag} is not recognized"
     exit
   end
end

if !File.exists?(iname_list_path)
  puts "No list file found at: #{iname_list_path}\nAborting"
  exit
end

iname_list = File.read_lines(iname_list_path)

iname_list.each do |iname|
  if File.exists?(Path.home.to_s + '/' + iname)
    FileUtils.rm_rf(Path.home.to_s + '/' + iname)
    puts "Removed: " + iname
  end
end
