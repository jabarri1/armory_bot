module ArmoryBot
  module Commands
    module Talents
      extend Discordrb::Commands::CommandContainer
      command(:tals, bucket: :armory) do |event, *realm, char, region|

        puts '#{event.server.name} - TALENT CHECK IN AISLE 9'

        cclass = {
            1 => "Warrior", 2 => "Paladin", 3 => "Hunter",       
            4 => "Rogue", 5 => "Priest", 6 => "Death Knight",
            7 => "Shaman", 8 => "Mage", 9 => "Warlock",
            10 => "Monk", 11 => "Druid"
        }

        realm = realm.join('-')
        region = region.downcase

        dataus = HTTParty.get("https://us.api.battle.net/wow/character/#{realm}/#{URI.escape(char)}?fields=talents&locale=en_US&apikey=", :verify => false ).parsed_response
        dataeu = HTTParty.get("https://eu.api.battle.net/wow/character/#{realm}/#{URI.escape(char)}?fields=talents&locale=en_GB&apikey=", :verify => false ).parsed_response

        if region == "us"
          data = dataus
          armory = "<http://us.battle.net/wow/en/character/#{realm}/#{URI.escape(char)}/advanced>"
        elsif region == "eu"
          data = dataeu
          armory = "<http://eu.battle.net/wow/en/character/#{realm}/#{URI.escape(char)}/advanced>"
        else
          event.respond "Sorry #{event.user.name}, please insert your region US or EU(?help for more info)"
        end
        
        talents = data["talents"].find { |r| r["selected"] == true }

        talent0 = talents["talents"].find { |r| r["tier"] == 0 }
        talentid0 = talent0["spell"]["id"]

        talent1 = talents["talents"].find { |r| r["tier"] == 1 }
        talentid1 = talent1["spell"]["id"]

        talent2 = talents["talents"].find { |r| r["tier"] == 2 }
        talentid2 = talent2["spell"]["id"]

        talent3 = talents["talents"].find { |r| r["tier"] == 3 }
        talentid3 = talent3["spell"]["id"]

        talent4 = talents["talents"].find { |r| r["tier"] == 4 }
        talentid4 = talent4["spell"]["id"]

        talent5 = talents["talents"].find { |r| r["tier"] == 5 }
        talentid5 = talent5["spell"]["id"]
        
        talent6 = talents["talents"].find { |r| r["tier"] == 6 }
        talentid6 = talent6["spell"]["id"]

        charclass = cclass[data["class"]]

        event.respond """**#{char.capitalize} - #{realm.capitalize}(#{region.upcase}) | #{charclass} #{talents["spec"]["name"].capitalize}**
Armory: #{armory}

`TALENTS`
`15` `#{talent0["spell"]["name"]}`
`30` `#{talent1["spell"]["name"]}`
`45` `#{talent2["spell"]["name"]}`
`60` `#{talent3["spell"]["name"]}`
`75` `#{talent4["spell"]["name"]}`
`90` `#{talent5["spell"]["name"]}`
`100` `#{talent6["spell"]["name"]}`
"""
      end
    end
  end
end
