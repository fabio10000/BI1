require 'csv'

def getCSVContent(file_name, file_encoding)
  #Windows-1252
  begin
    # if there is any escaped double quote replace it by two double quotes (csv formating)
    csv_text = File.read(file_name, encoding: "#{file_encoding}:utf-8").gsub(/\\"/,'""')

  rescue
    puts "Wrong file name or encoding"
    help
    return -1
  end
  #convert cav_text into an array
  csv_array = CSV.parse(csv_text, headers: true)
end

# display help for the users
def help
  puts "\nSyntax: parse.rb <file_name> [file_encoding]"
  puts "------------------------------------------------------------------------------"
  puts "  -file_name      Path to the file"
  puts "  -file_encoding  Encoding of the inputed file default=utf-8"
end

file_name = ARGV[0]
encoding = ARGV[1] || "utf-8"

unless file_name
  puts "You must specify a file name"
  help
else
  getCSVContent(file_name, encoding)
end
