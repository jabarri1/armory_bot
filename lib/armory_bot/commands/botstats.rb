module ArmoryBot
  module Commands
    module BotStats
      extend Discordrb::Commands::CommandContainer
      	command(:bstats, bucket: :fight) do |event|

          servers = event.bot.servers.count
          users = event.bot.users.count

        puts "Server Count: #{event.bot.servers.count}"
        #puts postData

event.respond """```ruby
Armory Bot Stats

Servers: #{servers}
Users: #{users}
```"""

      end
    end
  end
end
