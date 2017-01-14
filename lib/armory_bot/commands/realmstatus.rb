module ArmoryBot
  module Commands
    module RealmStatus
      extend Discordrb::Commands::CommandContainer
        command(:status, bucket: :armory) do |event, *realm, region|

        api_key = ''

        region = region.downcase

        rstatusus = HTTParty.get("https://us.api.battle.net/wow/realm/status?locale=en_US&apikey=#{api_key}", :verify => false ).parsed_response
        rstatuseu = HTTParty.get("https://eu.api.battle.net/wow/realm/status?locale=en_GB&apikey=#{api_key}", :verify => false ).parsed_response

        realm = realm.join('-')
        realmevent = realm.split('-')
        realmevent = realmevent.join(' ')

        realm1 = realm.downcase
          if region == "us"
            rstatus = rstatusus
          elsif region == "eu"
            rstatus = rstatuseu
          else
            event.respond "Sorry #{event.user.name}, please insert the region US or EU(?help for more info)"
          end

        myrealm = rstatus["realms"].find { |r| r["slug"] == realm1 }

        puts "#{event.server.name} Getting Realm Status"

        myrealm["status"] ? "**Realm Status |** #{realmevent.capitalize} `Online`" : "**Realm Status |** #{realmevent.capitalize} `Offline`"
      end
    end
  end
end
