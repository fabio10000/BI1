require 'csv'
class ProcessCSV
  def initialize(file_name, file_encoding=nil)
    @file_name = file_name
    @file_encoding = file_encoding || "utf-8"
    @columns_to_remove = Array.new
    @regexes = Array.new
    @csv_array = Array.new
  end
  def changeFileName(file_name)
    @file_name = file_name
  end
  def setFileEncoding(encoding)
    @file_encoding = encoding
  end
  def addColumnToRemove(columnName)
    @columns_to_remove << columnName
  end
  def addRegex(columnName, regex)
    @regexes << {column: columnName, regex: regex}
  end
  def generateFile
    getCSVContent
    runRegex
    deleteColumns
    CSV.open("../../data/processed/processed_#{@file_name}", "wb") do |csv|
      csv << @csv_array.headers
      @csv_array.each { |element| csv << element }
    end

    #puts @csv_array.to_csv
    #puts "processed file(processed_#{@file_name}) generated on data/processed folder"
  end
  private
    def getCSVContent
      begin
        # use of .lines[2..-1] to remove the header lines of the file
        # gesub to replace double quotes by two double quotes (csv formating)
        csv_text = File.read("../../data/raw/#{@file_name}", encoding: "#{@file_encoding}:utf-8").lines[2..-1].join.gsub(/\\"/,'""')

      rescue
        puts "Wrong file name or encoding"
        return -1
      end
      #convert csv_text into a csv array with headers
      @csv_array = CSV.parse(csv_text, headers: true)
    end
    def runRegex
      @regexes.each do |regex|
        @csv_array.each {|element| element[regex[:column]] = element[regex[:column]][regex[:regex]]}
      end
    end
    def deleteColumns
      @columns_to_remove.each {|column| @csv_array.delete(column)}
    end
end
