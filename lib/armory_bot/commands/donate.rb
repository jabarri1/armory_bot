module ArmoryBot
  module Commands
    module Donate
      extend Discordrb::Commands::CommandContainer
      command(:donate) do |event|

      	puts "#{event.server.name} - donate?"

        event << 'Patreon: <https://www.patreon.com/blizzardbot>'
        event << 'PayPal: <http://bit.ly/1RTGoox>'
        
      end
    end
  end
end