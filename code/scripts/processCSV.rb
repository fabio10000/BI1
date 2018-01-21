require 'csv'
# class to generate a processed csv file
class ProcessCSV
  ###
  # function to initialize all variables
  #
  # @file_name(string) name of the file located on data/raw
  # @file_encoding(string) encoding of raw csv, default "utf-8"
  ###
  def initialize(file_name, file_encoding="utf-8")
    @file_name = file_name
    @file_encoding = file_encoding
    @columns_to_remove = Array.new # array with the name of columns to be removed
    @regexes = Array.new # array with the name of column and the regex to use
    @csv_array = Array.new # csv_table object
    @replacements = Array.new # array with the name of a column and the name to replace
  end
  ###
  # set the file name
  #
  # @file_name(string) file name
  ###
  def setFileName(file_name)
    @file_name = file_name
  end

  ###
  # set the file encoding
  #
  # @encoding(string) encoding
  ###
  def setFileEncoding(encoding)
    @file_encoding = encoding
  end

  ###
  # add a column to delete
  #
  # @column_name(string) name of column to remove
  ###
  def addColumnToRemove(column_name)
    @columns_to_remove << column_name
  end

  ###
  # add a regex of value format to a column
  #
  # @column_name(string) name of the column
  # @regex(regex) regex of value format
  ###
  def addRegex(column_name, regex)
    @regexes << {column: column_name, regex: regex}
  end

  ###
  # add a column_name to rename
  #
  # @column_name(string) name of the column
  # @new_column_name(string) new name to the column
  ###
  def addColumnToRename(column_name, new_column_name)
    @replacements << [column_name, new_column_name]
  end

  ###
  # generate a csv file into the folder data/processed
  ###
  def generateFile
    getCSVContent # get the content of the raw csv
    runRegex # run all regexes to format the data
    deleteColumns # delete all unwanted columns

    # create the new csv file into the folder data/processed
    CSV.open("../../data/processed/processed_#{@file_name}", "wb") do |csv|
      csv << @csv_array.headers
      @csv_array.each { |element| csv << element }
    end
  end

  private
    ###
    # get the content of the raw csv and rename the columns needed
    ###
    def getCSVContent
      begin
        # use of .lines[2..-1] to remove the header lines of the file
        # gsub to replace double quotes by two double quotes (csv formating)
        csv_text = File.read("../../data/raw/#{@file_name}", encoding: "#{@file_encoding}:utf-8").lines[2..-1].join.gsub(/\\"/,'""')

      rescue
        puts "Wrong file name or encoding"
        return -1
      end
      #convert csv_text into a csv array with headers
      @csv_array = CSV.parse(csv_text, headers: true, header_converters: lambda do |h|
          #rename column name
          @replacements.each{|replacement| h.gsub!(replacement[0], replacement[1]) }
          return h
        end
      )
    end

    ###
    # run all regexes
    ###
    def runRegex
      @regexes.each do |regex|
        @csv_array.each {|element| element[regex[:column]] = element[regex[:column]][regex[:regex]]}
      end
    end

    ###
    # delete all unwanted columns
    ###
    def deleteColumns
      @columns_to_remove.each {|column| @csv_array.delete(column)}
    end
end
