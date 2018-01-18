require './parse.rb'

processCSV = ProcessCSV.new('salaire_mensuel_brut_selon_formation.csv', 'windows-1252')
processCSV.addRegex("Homme Médiane", /\d+/)
processCSV.addRegex("Femme Médiane", /\d+/)
processCSV.addColumnToRemove("Position professionnelle")
processCSV.generateFile
