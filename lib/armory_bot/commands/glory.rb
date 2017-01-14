module ArmoryBot
  module Commands
    module Glory
      extend Discordrb::Commands::CommandContainer
      command(:glory, bucket: :armory) do |event, *realm, char, region|

        realm = realm.join('-')

        region = region.downcase

        @@api_key = ''

        wolfus = HTTParty.get("https://us.api.battle.net/wow/character/#{realm}/#{URI.escape(char)}?fields=mounts&locale=en_US&apikey=#{@@api_key}", :verify => false ).parsed_response
        wolfeu = HTTParty.get("https://eu.api.battle.net/wow/character/#{realm}/#{URI.escape(char)}?fields=mounts&locale=en_GB&apikey=#{@@api_key}", :verify => false ).parsed_response
        
        realm1 = realm.downcase

        if region == "us"
          wolf = wolfus
        elsif region == "eu"
          wolf = wolfeu
        else
          event.respond "Sorry #{event.user.name}, please insert the region US or EU(?help for more info)"
        end

        wolves = wolf["mounts"]["collected"].find { |r| r["name"] == "Infernal Direwolf" }

        puts "#{event.server.name} - wolf CHECK"

        wolves ? "**#{char.capitalize}** | **Infernal Direwolf**: `Yes`" : "**#{char.capitalize}** | **Infernal Direwolf**: `No`"
     
      end
    end
  end
end
