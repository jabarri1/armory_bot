module ArmoryBot
  module Commands
    module Help
      extend Discordrb::Commands::CommandContainer
      command(:help, bucket: :fight) do |event, *info|

        break if info.length >= 1

        puts '#{event.server.name} - CMD: help'

        event << ''

        
      end
    end
  end
end
