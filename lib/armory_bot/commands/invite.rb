module ArmoryBot
  module Commands
    module Invite
      extend Discordrb::Commands::CommandContainer
        command(:invite) do |event|

        puts '#{event.server.name} - CMD: INVITE MY BOT'
        
        event.respond """If you'd like to add this bot to your server, clink the link below
Only users with `manage server` permission are able to invite me.
<https://discordapp.com/oauth2/authorize?&client_id=169952497690083328&scope=bot&permissions=3200>

Join the ArmoryBot Discord: <https://discord.gg/013frAGN0omndjlkH>"""
      end
    end
  end
end
