module ArmoryBot
  module Commands
    module ServerList
      extend Discordrb::Commands::CommandContainer
      command(:serverlist, bucket: :fight) do |event|
        
        if event.user.id == 
          event.bot.servers.map{|k,v| [k, v.name]}.to_h
        else
          nil
        end
        
      end
    end
  end
end
