module ArmoryBot
  module Commands
    module Zenyatta
      extend Discordrb::Commands::CommandContainer
      command([:zenyatta, :Zenyatta, :ZENYATTA], bucket: :overwatch, min_args: 4, rate_limit_message: 'All heroes share a rate limit. Wait %time% more seconds.') do |event, *account, region, platform, mode|

        mode = mode.downcase

        platform = platform.downcase

        acc = account.join(' ')

        if platform == "pc"
          acc = acc.split('#')
          acc = acc.join('-')
        elsif platform == "xbl"
          acc = acc.split(' ')
          acc = acc.join('%20')
        else
          acc = acc.downcase
        end

        if platform == "pc" && region == "us"
          region = "us"
        elsif platform == "pc" && region =="eu"
          region = "eu"
        elsif platform == "psn" || platform == "xbl"
          region = "global"
        else
          nil
        end

        data1 = HTTParty.get("https://api.lootbox.eu/#{platform}/#{region}/#{acc}/quick-play/hero/Zenyatta/", :verify => false ).parsed_response
        data2 = HTTParty.get("https://api.lootbox.eu/#{platform}/#{region}/#{acc}/competitive-play/hero/Zenyatta/", :verify => false ).parsed_response

        break unless mode == "qp" || mode == "cp"

        if mode == nil || mode == "qp"
          data = data1["Hanzo"]
          type = "Quick Play"
        elsif mode == "cp"
          data = data2["Hanzo"]
          type = "Competitive Play"
        else
          nil
        end

        if platform == "pc"
          name = account.first
        else
          name = acc.split('%20')
          name = name.join(' ')
        end

        thealing = data["TranscendenceHealing"]
        thealing_best = data["TranscendenceHealing-Best"]
        oassist = data["OffensiveAssists"]
        oassist_most = data["OffensiveAssists-MostinGame"]
        oassist_average = data["OffensiveAssists-Average"]
        dassist = data["DefensiveAssists"]
        dassist_most = data["DefensiveAssists-MostinGame"]
        dassist_average = data["DefensiveAssists-Average"]

        elims = data["Eliminations"]
        healing = data["HealingDone"]
        healing_most = data["Healing_MostinGame"]
        objk = data["ObjectiveKills"]
        objt = data["ObjectiveTime"]
        dmg = data["DamageDone"]
        wacc = data["WeaponAccuracy"]
        ksm = data["KillStreak-Best"]
        dmgm = data["DamageDone-MostinGame"]
        healing_average = data["HealingDone-Average"]
        elimsm = data["Eliminations-MostinGame"]
        objkm = data["ObjectiveKills-MostinGame"]
        objtm = data["ObjectiveTime-MostinGame"]
        deathsavg = data["Deaths-Average"]
        objtavg = data["ObjectiveTime-Average"]
        objkavg = data["ObjectiveKills-Average"]
        elimsavg = data["Eliminations-Average"]
        solokill = data["SoloKills"]
        solokillavg = data["SoloKills-Average"]
        dmgavg = data["DamageDone-Average"]
        deaths = data["Deaths"]
        bmedals = data["Medals-Bronze"]
        smedals = data["Medals-Silver"]
        gmedals = data["Medals-Gold"]
        playedt = data["TimePlayed"]
        gplayed = data["GamesPlayed"]
        gwon = data["GamesWon"]
        winperc = data["WinPercentage"]
        cards = data["Cards"]

        if data["statusCode"] == 500
          event << "Sorry, you inputted everything correctly, just seems to be an error while retrieving your account. :( "
        elsif data["statusCode"] == 404
          event << "Sorry, no account was found with that name."
        else
          event.respond """#{event.user.mention} - #{name.capitalize} - Zenyatta - #{type}
```ruby
- Hero Specific -
Transcendence Healing: #{thealing} | Best in Game: #{thealing_best}
Offensive Assists: #{oassist} | Most in Game: #{oassist_most} | Average: #{oassist_average}
Defensive Assists: #{dassist} | Most in Game: #{dassist_most} | Average: #{dassist_average}

- Total Stats -
Eliminations: #{elims} | Damage Done: #{dmg} | Healing: #{healing} | Deaths: #{deaths}
Objective Kills: #{objk} | Best Killstreak: #{ksm} | Solo Kills: #{solokill}

- Average Stats -
Eliminations: #{elimsavg} | Damage Done: #{dmgavg} | Healing: #{healing_average} | Deaths: #{deathsavg}
Objective Kills: #{objkavg} | Objective Time: #{objtavg} | Solo Kills: #{solokillavg}

- Game -
Time Played: #{playedt} | Games Won: #{gwon} | Win Percentage: #{winperc}
Gold: #{gmedals} | Silver: #{smedals} | Bronze: #{bmedals} | Cards: #{cards}
```"""
        end
        puts "#{event.server.name} - Zenyatta"
      end
    end
  end
end