require 'csv'
def readContent(file_name, encoding = "utf-8")
  csv_text = File.read("../../data/processed/#{file_name}", encoding: "#{encoding}:utf-8").gsub(/\\"/,'""')
  CSV.parse(csv_text, headers: true)
end
def getRegions(csv_array)
  result = Array.new
  csv_array.each do |csv|
    csv.each {|line| result << line['Grande région'] unless result.include? line['Grande région']}
  end

  return result
end
def generateFile(regions)
  id = 0
  CSV.open("../../data/processed/processed_grandes_regions.csv", "wb") do |csv|
    csv << ["Id","Grande région"]
    regions.each { |region| csv << [id,region]; id+=1}
  end
end

csv_array = Array.new
csv_array << readContent("processed_salaire_mensuel_brut_selon_domaine.csv")
csv_array << readContent("processed_salaire_mensuel_brut_selon_formation.csv")
csv_array << readContent("processed_salaire_mensuel_brut_suisse.csv")

regions = getRegions(csv_array)
generateFile(regions)
