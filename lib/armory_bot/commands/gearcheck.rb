module ArmoryBot
  module Commands
    module GearCheck
      extend Discordrb::Commands::CommandContainer
      command(:gear, bucket: :armory) do |event, *realm, char, region|

        wh = '<http://www.wowhead.com/item='

        api_key = ''

        realm = realm.join('-')

        region = region.downcase

        dataus = HTTParty.get("https://us.api.battle.net/wow/character/#{realm}/#{URI.escape(char)}?fields=items&locale=en_US&apikey=#{api_key}", :verify => false ).parsed_response
        dataeu = HTTParty.get("https://eu.api.battle.net/wow/character/#{realm}/#{URI.escape(char)}?fields=items&locale=en_GB&apikey=#{api_key}", :verify => false ).parsed_response

        if region == "us"
          data = dataus
        elsif region == "eu"
          data = dataeu
        else
          event.respond "Sorry #{event.user.name}, please insert your region US or EU(?help for more info)"
        end

        puts '#{event.server.name} - CMD: Gear Search'

        offh = if data["items"]["offHand"] == nil
          "No Off Hand Equipped"
        else
          "#{data["items"]["offHand"]["itemLevel"]} #{data["items"]["offHand"]["name"]}: #{wh}#{data["items"]["offHand"]["id"]}>"
        end
        
        if region == "us"
            event.respond """
**#{char.capitalize} - #{realm.capitalize} - #{region.upcase}**
Armory: <http://us.battle.net/wow/en/character/#{realm}/#{URI.escape(char)}/advanced>
Item Level: `#{data["items"]["averageItemLevel"]}` | `#{data["items"]["averageItemLevelEquipped"]}`
#{data["items"]["head"]["itemLevel"]} #{data["items"]["head"]["name"]}: #{wh}#{data["items"]["head"]["id"]}>
#{data["items"]["neck"]["itemLevel"]} #{data["items"]["neck"]["name"]}: #{wh}#{data["items"]["neck"]["id"]}>
#{data["items"]["shoulder"]["itemLevel"]} #{data["items"]["shoulder"]["name"]}: #{wh}#{data["items"]["shoulder"]["id"]}>
#{data["items"]["back"]["itemLevel"]} #{data["items"]["back"]["name"]}: #{wh}#{data["items"]["back"]["id"]}>
#{data["items"]["chest"]["itemLevel"]} #{data["items"]["chest"]["name"]}: #{wh}#{data["items"]["chest"]["id"]}>
#{data["items"]["wrist"]["itemLevel"]} #{data["items"]["wrist"]["name"]}: #{wh}#{data["items"]["wrist"]["id"]}>
#{data["items"]["hands"]["itemLevel"]} #{data["items"]["hands"]["name"]}: #{wh}#{data["items"]["hands"]["id"]}>
#{data["items"]["waist"]["itemLevel"]} #{data["items"]["waist"]["name"]}: #{wh}#{data["items"]["waist"]["id"]}>
#{data["items"]["legs"]["itemLevel"]} #{data["items"]["legs"]["name"]}: #{wh}#{data["items"]["legs"]["id"]}>
#{data["items"]["feet"]["itemLevel"]} #{data["items"]["feet"]["name"]}: #{wh}#{data["items"]["feet"]["id"]}>
#{data["items"]["finger1"]["itemLevel"]} #{data["items"]["finger1"]["name"]}: #{wh}#{data["items"]["finger1"]["id"]}>
#{data["items"]["finger2"]["itemLevel"]} #{data["items"]["finger2"]["name"]}: #{wh}#{data["items"]["finger2"]["id"]}>
#{data["items"]["trinket1"]["itemLevel"]} #{data["items"]["trinket1"]["name"]}: #{wh}#{data["items"]["trinket1"]["id"]}>
#{data["items"]["trinket2"]["itemLevel"]} #{data["items"]["trinket2"]["name"]}: #{wh}#{data["items"]["trinket2"]["id"]}>
#{data["items"]["mainHand"]["itemLevel"]} #{data["items"]["mainHand"]["name"]}: #{wh}#{data["items"]["mainHand"]["id"]}>
#{offh}"""
          elsif region == "eu"
            event.respond """
**#{char.capitalize} - #{realm.capitalize} - #{region.upcase}**
Armory: <http://eu.battle.net/wow/en/character/#{realm}/#{URI.escape(char)}/advanced>
Item Level: `#{data["items"]["averageItemLevel"]}` | `#{data["items"]["averageItemLevelEquipped"]}`
#{data["items"]["head"]["itemLevel"]} #{data["items"]["head"]["name"]}: #{wh}#{data["items"]["head"]["id"]}>
#{data["items"]["neck"]["itemLevel"]} #{data["items"]["neck"]["name"]}: #{wh}#{data["items"]["neck"]["id"]}>
#{data["items"]["shoulder"]["itemLevel"]} #{data["items"]["shoulder"]["name"]}: #{wh}#{data["items"]["shoulder"]["id"]}>
#{data["items"]["back"]["itemLevel"]} #{data["items"]["back"]["name"]}: #{wh}#{data["items"]["back"]["id"]}>
#{data["items"]["chest"]["itemLevel"]} #{data["items"]["chest"]["name"]}: #{wh}#{data["items"]["chest"]["id"]}>
#{data["items"]["wrist"]["itemLevel"]} #{data["items"]["wrist"]["name"]}: #{wh}#{data["items"]["wrist"]["id"]}>
#{data["items"]["hands"]["itemLevel"]} #{data["items"]["hands"]["name"]}: #{wh}#{data["items"]["hands"]["id"]}>
#{data["items"]["waist"]["itemLevel"]} #{data["items"]["waist"]["name"]}: #{wh}#{data["items"]["waist"]["id"]}>
#{data["items"]["legs"]["itemLevel"]} #{data["items"]["legs"]["name"]}: #{wh}#{data["items"]["legs"]["id"]}>
#{data["items"]["feet"]["itemLevel"]} #{data["items"]["feet"]["name"]}: #{wh}#{data["items"]["feet"]["id"]}>
#{data["items"]["finger1"]["itemLevel"]} #{data["items"]["finger1"]["name"]}: #{wh}#{data["items"]["finger1"]["id"]}>
#{data["items"]["finger2"]["itemLevel"]} #{data["items"]["finger2"]["name"]}: #{wh}#{data["items"]["finger2"]["id"]}>
#{data["items"]["trinket1"]["itemLevel"]} #{data["items"]["trinket1"]["name"]}: #{wh}#{data["items"]["trinket1"]["id"]}>
#{data["items"]["trinket2"]["itemLevel"]} #{data["items"]["trinket2"]["name"]}: #{wh}#{data["items"]["trinket2"]["id"]}>
#{data["items"]["mainHand"]["itemLevel"]} #{data["items"]["mainHand"]["name"]}: #{wh}#{data["items"]["mainHand"]["id"]}>
#{offh}"""
          else
            nil
          end
          
      end
    end
  end
end
