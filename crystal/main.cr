require "option_parser"

OptionParser.parse do |parser|
   parser.banner = "CrystalClear"

   parser.on "-v", "--version", "Prints application version information" do
     puts "CrystalClear 1.0"
	 exit
   end

   parser.on "-h", "--help", "Prints this message" do
     puts parser
     exit
   end
end

iname_list_path = "/home/soda/.config/clean/files.list"

iname_list = File.read_lines(iname_list_path)

iname_list.each do |iname|
  if File.delete?("/home/soda/" + iname)
     puts "Deleted: " + iname
  end
end
