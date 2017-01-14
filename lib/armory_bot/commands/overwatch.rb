module ArmoryBot
  module Commands
    module Overwatch
      extend Discordrb::Commands::CommandContainer
        command(:overwatch, bucket: :overwatch, min_args: 2) do |event, *account, mode|

        if account.last == "xbl"
      override = "?platform=xbl"
      region = "global"
      plat = "xbl"
    elsif account.last == "eu"
      override = "?region=eu"
      region = "eu"
      plat = "pc"
    elsif account.last == "psn"
      override = "?platform=psn"
      region = "global"
      plat = "psn"
    else
      override = ""
      region = "us"
      plat = "pc"
    end

    #platform = platform.downcase

    if mode == "cp"
      modename = "competitive"
      modename2 = "competitive-play"
    else
      modename = "general"
      modename2 = "quick-play"
    end

      acc = account.first
      acc = acc.split('#')
      acc = acc.join('-')

    stats1 = HTTParty.get("https://owapi.net/api/v2/u/#{acc}/heroes/#{modename}#{override}", :verify => false ).parsed_response

    stats2 = HTTParty.get("https://owapi.net/api/v2/u/#{acc}/stats/#{modename}#{override}", :verify => false ).parsed_response

    stats3 = HTTParty.get("https://api.lootbox.eu/#{plat}/#{region}/#{acc}/#{modename2}/heroes", :verify => false ).parsed_response



    stats4 = stats3.to_s

    if stats2["overall_stats"]["prestige"] == 0
      efflevel = "#{stats2["overall_stats"]["level"]}"
    else
      efflevel = "#{stats2["overall_stats"]["prestige"]}#{stats2["overall_stats"]["level"]}"
    end

    puts stats3[0]
    statt = stats4.split("\"")

    if statt[3] == "Soldier: 76"
      hero1 = "soldier76"
    elsif statt[3] == "D.Va"
      hero1 = "dva"
    elsif statt[3] == "Torbj&#xF6;rn"
      hero1 = "torbjorn"
    elsif statt[3] == "L&#xFA;cio"
      hero1 = "lucio"
    else
      hero1 = statt[3]
    end

    if statt[17] == "Soldier: 76"
      hero2 = "soldier76"
    elsif statt[17] == "D.Va"
      hero2 = "dva"
    elsif statt[17] == "Torbj&#xF6;rn"
      hero2 = "torbjorn"
    elsif statt[17] == "L&#xFA;cio"
      hero2 = "lucio"
    else
      hero2 = statt[17]
    end

    if statt[31] == "Soldier: 76"
      hero3 = "soldier76"
    elsif statt[31] == "D.Va"
      hero3 = "dva"
    elsif statt[31] == "Torbj&#xF6;rn"
      hero3 = "torbjorn"
    elsif statt[31] == "L&#xFA;cio"
      hero3 = "lucio"
    else
      hero3 = statt[31]
    end

    if statt[45] == "Soldier: 76"
      hero4 = "soldier76"
    elsif statt[45] == "D.Va"
      hero4 = "dva"
    elsif statt[45] == "Torbj&#xF6;rn"
      hero4 = "torbjorn"
    elsif statt[45] == "L&#xFA;cio"
      hero4 = "lucio"
    else
      hero4 =statt[45]
    end

    #data1 = stats1["heroes"]

    #data2 = data1.sort_by{ |k, v| v }.to_a

    #hero1 = data2[21][0]
    #hero2 = data2[20][0]
    #hero3 = data2[19][0]
    #hero4 = data2[18][0]

    image1 = MiniMagick::Image.open("/app/lib/assets/imgs/overall-average-#{mode}.png")
    image2 = MiniMagick::Image.open("/app/lib/assets/full-icons/#{hero1}.png")
    image4 = MiniMagick::Image.open("/app/lib/assets/full-icons/#{hero2}.png")
    image5 = MiniMagick::Image.open("/app/lib/assets/full-icons/#{hero3}.png")
    image6 = MiniMagick::Image.open("/app/lib/assets/full-icons/#{hero4}.png")
    image3 = MiniMagick::Image.open("#{stats2["overall_stats"]["avatar"]}")

    #account name
    image1.combine_options do |cmd|
      cmd.gravity 'northwest'
      cmd.pointsize 30
      cmd.font "/app/lib/assets/big_noodle_titling.ttf"
      cmd.draw "text 70,12 '#{account.first}'"
      cmd.fill 'white'
    end

    #skill rating
    if mode == "cp"
      image1.combine_options do |cmd|
        cmd.gravity 'center'
        cmd.pointsize 30
        cmd.font "/app/lib/assets/big_noodle_titling.ttf"
        cmd.draw "text 252,-158 '#{stats2["overall_stats"]["comprank"]}'"
        cmd.fill 'white'
      end

      #account level
      image1.combine_options do |cmd|
        cmd.gravity 'center'
        cmd.pointsize 30
        cmd.font "/app/lib/assets/big_noodle_titling.ttf"
        cmd.draw "text 186,-158 '#{efflevel}'"
        cmd.fill 'white'
      end
    else
      image1.combine_options do |cmd|
        cmd.gravity 'center'
        cmd.pointsize 30
        cmd.font "/app/lib/assets/big_noodle_titling.ttf"
        cmd.draw "text 252,-158 '#{efflevel}'"
        cmd.fill 'white'
      end
    end


    #Games Played
    image1.combine_options do |cmd|
      cmd.gravity 'center'
      cmd.pointsize 36
      cmd.font "/app/lib/assets/big_noodle_titling.ttf"
      cmd.draw "text -218,-41 '#{stats2["overall_stats"]["games"]}'"
      cmd.fill '#5A5A5A'
    end

    #Time Played
    image1.combine_options do |cmd|
      cmd.gravity 'center'
      cmd.pointsize 36
      cmd.font "/app/lib/assets/big_noodle_titling.ttf"
      cmd.draw "text -71,-41 '#{stats2["game_stats"]["time_played"].to_i}hrs'"
      cmd.fill '#5A5A5A'
    end

    #Win %
    image1.combine_options do |cmd|
      cmd.gravity 'center'
      cmd.pointsize 36
      cmd.font "/app/lib/assets/big_noodle_titling.ttf"
      cmd.draw "text 72,-41 '#{stats2["overall_stats"]["win_rate"]}%'"
      cmd.fill '#5A5A5A'
    end

    #Medals
    image1.combine_options do |cmd|
      cmd.gravity 'center'
      cmd.pointsize 36
      cmd.font "/app/lib/assets/big_noodle_titling.ttf"
      cmd.draw "text 222,-41 '#{stats2["game_stats"]["medals"].to_i}'"
      cmd.fill '#5A5A5A'
    end

    image3 = image3.combine_options do |i|
      i.resize "48x48"
    end

    image2 = image2.combine_options do |i|
      i.resize "80"
    end

    image4 = image4.combine_options do |i|
      i.resize "80"
    end

    image5 = image5.combine_options do |i|
      i.resize "80"
    end

    image6 = image6.combine_options do |i|
      i.resize "80"
    end

    result1 = image1.composite(image3) do |c|
      c.compose "Over"
      c.geometry "+12+12"
    end

    result2 = result1.composite(image2) do |c|
      c.compose "Over"
      c.geometry "+88+268"
    end

    result3 = result2.composite(image4) do |c|
      c.compose "Over"
      c.geometry "+202+268"
    end

    result4 = result3.composite(image5) do |c|
      c.compose "Over"
      c.geometry "+317+268"
    end

    result = result4.composite(image6) do |c|
      c.compose "Over"
      c.geometry "+432+268"
    end

    result.write "/app/lib/assets/#{event.user.name}.png"

    jesus = File.open("/app/lib/assets/#{event.user.name}.png")

    event.respond "#{event.user.mention}"
    event.channel.send_file(jesus)

    File.delete("/app/lib/assets/#{event.user.name}.png")
    nil

    puts "Pong! Time taken: #{Time.now - event.timestamp} seconds."
    puts "#{event.server.name} | Overwatch"

      end
    end
  end
end