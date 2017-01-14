module ArmoryBot
  module Commands
    module Moose
      extend Discordrb::Commands::CommandContainer
      command(:moose, bucket: :armory) do |event, *realm, char, region|

        realm = realm.join('-')

        region = region.downcase

        @@api_key = ''

        mooseus = HTTParty.get("https://us.api.battle.net/wow/character/#{realm}/#{URI.escape(char)}?fields=mounts&locale=en_US&apikey=#{@@api_key}", :verify => false ).parsed_response
        mooseeu = HTTParty.get("https://eu.api.battle.net/wow/character/#{realm}/#{URI.escape(char)}?fields=mounts&locale=en_GB&apikey=#{@@api_key}", :verify => false ).parsed_response
        
        realm1 = realm.downcase
          
        if region == "us"
          moose = mooseus
        elsif region == "eu"
          moose = mooseeu
        else
          event.respond "Sorry #{event.user.name}, please insert the region US or EU(?help for more info)"
        end

        mooses = moose["mounts"]["collected"].find { |r| r["name"] == "Grove Warden" }

        puts "#{event.server.name} - MOOSE CHECK"

        mooses ? "**#{char.capitalize}** | **Grove Warden**: `Yes`" : "**#{char.capitalize}** | **Grove Warden**: `No`"
      
      end
    end
  end
end
