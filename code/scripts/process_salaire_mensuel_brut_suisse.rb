require './parse.rb'

processCSV = ProcessCSV.new('salaire_mensuel_brut_suisse.csv', 'windows-1252')
processCSV.addRegex("Homme Médiane", /\d+/)
processCSV.addRegex("Femme Médiane", /\d+/)
processCSV.addColumnToRemove("Niveau de qualification")
processCSV.addColumnToRemove("Nationalité / Autorisation de résidence")
processCSV.generateFile
