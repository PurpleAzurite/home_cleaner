require "option_parser"

iname_list_path = "/home/soda/.config/clean/files.list"

OptionParser.parse do |parser|
   parser.banner = "CrystalClear"

   parser.on "-v", "--version", "Prints application version information" do
     puts "CrystalClear v1.1"
	 exit
   end

   parser.on "-h", "--help", "Prints this message" do
     puts parser
     exit
   end

   parser.on "-l PATH", "--list=PATH", "Specifies the list file to use instead" do |path|
     iname_list_path = path
   end
end

iname_list = File.read_lines(iname_list_path)

iname_list.each do |iname|
  if File.delete?("/home/soda/" + iname)
     puts "Deleted: " + iname
  end
end
