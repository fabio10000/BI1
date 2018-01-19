require './processCSV.rb'

processCSV = ProcessCSV.new('salaire_mensuel_brut_selon_formation.csv', 'windows-1252')
processCSV.addColumnToRename("Homme Médiane", "Homme")
processCSV.addColumnToRename("Femme Médiane", "Femme")
processCSV.addRegex("Homme", /\d+/)
processCSV.addRegex("Femme", /\d+/)
processCSV.addColumnToRemove("Position professionnelle")
processCSV.generateFile
