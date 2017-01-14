module ArmoryBot
  module Commands
    module PvP
      extend Discordrb::Commands::CommandContainer
      command(:pvp, bucket: :armory) do |event, *realm, char, region|

      	api_key = ''

        realm = realm.join('-')
        region = region.upcase

        dataus = HTTParty.get("https://us.api.battle.net/wow/character/#{realm}/#{URI.escape(char)}?fields=pvp&locale=en_US&apikey=#{api_key}", :verify => false ).parsed_response
        dataeu = HTTParty.get("https://eu.api.battle.net/wow/character/#{realm}/#{URI.escape(char)}?fields=pvp&locale=en_GB&apikey=#{api_key}", :verify => false ).parsed_response


        if region == "US"
          arena = dataus
        elsif region == "EU"
          arena = dataeu
        else
          event.respond "Sorry #{event.user.name}, please insert your region US or EU(?help for more info)"
        end

    		arena2v2 = arena["pvp"]["brackets"]["ARENA_BRACKET_2v2"]
    		arena2v2r = arena2v2["rating"]
    		arena2v2w = arena2v2["seasonWon"]
    		arena2v2l = arena2v2["seasonLost"]

    		arena3v3 = arena["pvp"]["brackets"]["ARENA_BRACKET_3v3"]
    		arena3v3r = arena3v3["rating"]
    		arena3v3w = arena3v3["seasonWon"]
    		arena3v3l = arena3v3["seasonLost"]

    		rbg = arena["pvp"]["brackets"]["ARENA_BRACKET_RBG"]
    		rbgr = rbg["rating"]
    		rbgw = rbg["seasonWon"]
    		rbgl = rbg["seasonLost"]

        puts "#{event.server.name} - PvP"

		    event.respond """**#{char.capitalize} - #{realm.capitalize}(#{region.upcase}) | PvP Stats**
```Ruby
Type | Rating - Wins - Loses
2v2  | #{arena2v2r} - #{arena2v2w} - #{arena2v2l}
3v3  | #{arena3v3r} - #{arena3v3w} - #{arena3v3l}
RBG  | #{rbgr} - #{rbgw} - #{rbgl}
```"""

      end
    end
  end
end
