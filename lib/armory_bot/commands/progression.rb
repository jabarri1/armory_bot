module ArmoryBot
  module Commands
    module Progression
      extend Discordrb::Commands::CommandContainer
      command(:prog, bucket: :armory) do |event, *realm, char, region|

        api_key = ''

        realm = realm.join('-')

        region = region.downcase

        puts "PROGRESSION SEARCH"

        progus = HTTParty.get("https://us.api.battle.net/wow/character/#{realm}/#{URI.escape(char)}?fields=progression&locale=en_US&apikey=#{api_key}", :verify => false ).parsed_response
        progeu = HTTParty.get("https://eu.api.battle.net/wow/character/#{realm}/#{URI.escape(char)}?fields=progression&locale=en_GB&apikey=#{api_key}", :verify => false ).parsed_response
        
        if region == "us"
          prog = progus
        elsif region == "eu"
          prog = progeu
        else
          event.respond "Sorry #{event.user.name}, please insert the region US or EU(?help for more info)"
        end

        puts "#{event.server.name} - Char Prog"
        
        mychar = prog["progression"]["raids"].find { |r| r["name"] == "The Emerald Nightmare" }
        assault = mychar["bosses"].find { |r| r["name"] == "Nythendra"}
        iron = mychar["bosses"].find { |r| r["name"] == "Il'gynoth, Heart of Corruption" }
        korm = mychar["bosses"].find { |r| r["name"] == "Elerethe Renferal" }
        hellfire_council = mychar["bosses"].find { |r| r["name"] == "Ursoc" }
        killrogg = mychar["bosses"].find { |r| r["name"] == "Dragons of Nightmare" }
        gore = mychar["bosses"].find { |r| r["name"] == "Cenarius" }
        iskar = mychar["bosses"].find { |r| r["name"] == "Xavius" }
        socrethar = mychar["bosses"].find { |r| r["name"] == "Socrethar the Eternal" }
        velhari = mychar["bosses"].find { |r| r["name"] == "Tyrant Velhari" }
        fellord = mychar["bosses"].find { |r| r["name"] == "Fel Lord Zakuun" }
        xhul = mychar["bosses"].find { |r| r["name"] == "Xhul'horac" }
        mann = mychar["bosses"].find { |r| r["name"] == "Mannoroth" }
        archi = mychar["bosses"].find { |r| r["name"] == "Archimonde" }
        
        if assault["mythicKills"] >= 1
        event.respond """**#{char.capitalize} - #{realm.capitalize}(#{region.upcase}) | Mythic Progression**
`#{assault["mythicKills"]}` | `Nythendra`
`#{iron["mythicKills"]}` | `Ilgynoth Heart of Corruption`
`#{korm["mythicKills"]}` | `Elerethe Renferal`
`#{hellfire_council["mythicKills"]}` | `Ursoc`
`#{killrogg["mythicKills"]}` | `Dragons of Nightmare`
`#{gore["mythicKills"]}` | `Cenarius`
`#{iskar["mythicKills"]}` | `Xavius`
"""
            elsif assault["heroicKills"] >= 1
                        event.respond """**#{char.capitalize} - #{realm.capitalize}(#{region.upcase}) | Heroic Progression**
`#{assault["heroicKills"]}` | `Nythendra`
`#{iron["heroicKills"]}` | `Ilgynoth Heart of Corruption`
`#{korm["heroicKills"]}` | `Elerethe Renferal`
`#{hellfire_council["heroicKills"]}` | `Ursoc`
`#{killrogg["heroicKills"]}` | `Dragons of Nightmare`
`#{gore["heroicKills"]}` | `Cenarius`
`#{iskar["heroicKills"]}` | `Xavius`
"""
            else
                        event.respond """**#{char.capitalize} - #{realm.capitalize}(#{region.upcase}) | Normal Progression**
`#{assault["normalKills"]}` | `Nythendra`
`#{iron["normalKills"]}` | `Ilgynoth Heart of Corruption`
`#{korm["normalKills"]}` | `Elerethe Renferal`
`#{hellfire_council["normalKills"]}` | `Ursoc`
`#{killrogg["normalKills"]}` | `Dragons of Nightmare`
`#{gore["normalKills"]}` | `Cenarius`
`#{iskar["normalKills"]}` | `Xavius`
"""
end

     end
    end
  end
end
