require './processCSV.rb'

# create a new processCSV object
processCSV = ProcessCSV.new('salaire_mensuel_brut_suisse.csv', 'windows-1252')
processCSV.addColumnToRename("Homme Médiane", "Homme") # change the name of column "Homme Médiane" into "Homme"
processCSV.addColumnToRename("Femme Médiane", "Femme") # change the name of column "Femme Médiane" into "Femme"
processCSV.addRegex("Homme", /\d+/) #make sure the numbers are well formatted
processCSV.addRegex("Femme", /\d+/) #make sure the numbers are well formatted
processCSV.generateFile # generate the processsed csv file
