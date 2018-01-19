require './processCSV.rb'

processCSV = ProcessCSV.new('salaire_mensuel_brut_selon_domaine.csv', 'windows-1252')
processCSV.addRegex("Homme", /\d+/)
processCSV.addRegex("Femme", /\d+/)
processCSV.addColumnToRemove("Niveau de qualification")
processCSV.generateFile
