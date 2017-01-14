module ArmoryBot
  module Commands
    module GuildRank
      extend Discordrb::Commands::CommandContainer
      command(:guildrank, bucket: :armory) do |event, *info, region|

        if info.length >= 1
          info = info.join(' ')
        else
          info = info.first
        end

        info = info.split('-')

        realm = info.at(0)
        
        guild = info.at(1)
        
        if realm.include? "'"
          realm1 = realm.split("'")
          realm1 = realm1.join('-')
        elsif realm.include? " "
          realm1 = realm.split(' ')
          realm1 = realm1.join('-')
        else
          realm1 = realm
        end

        if guild.include?(" ")
          guild1 = guild.split(' ')
          guild1 = guild1.join('+')
        else
          guild1 = guild
        end

        prog = HTTParty.get("http://www.wowprogress.com/guild/#{region.downcase}/#{realm1}/#{guild1}/json_rank", :verify => false ).parsed_response

        progsrv1 = prog.split(',')
        progsrv2 = progsrv1.at(3)
        progsrv3 = progsrv2.split(':')
        progsrv4 = progsrv3.at(1)
        server_rank = progsrv4.delete!("}")

        progreg1 = prog.split(',')
        progreg2 = progreg1.at(2)
        progreg3 = progreg2.split(':')
        region_rank = progreg3.at(1)

        progwor1 = prog.split(',')
        progwor2 = progwor1.at(1)
        progwor3 = progwor2.split(':')
        world_rank = progwor3.at(1)

        puts "#{event.server.name} - Getting Guild Ranking"

    event.respond("""**<#{guild.upcase}> - #{realm.upcase}(#{region.upcase}) | Guild Rank**
**Server Rank:** `#{server_rank}`
**Region Rank:** `#{region_rank}`
**World Rank:** `#{world_rank}`
<http://www.wowprogress.com/guild/#{region.downcase}/#{realm1}/#{guild1}>""")


      end
    end
  end
end