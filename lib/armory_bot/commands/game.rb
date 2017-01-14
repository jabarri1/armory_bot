module ArmoryBot
  module Commands
    module Game
      extend Discordrb::Commands::CommandContainer
      command(:game, min_args: 1) do |event, *text|
        event.bot.game = text.join(' ') if event.author.id == 100311929821626368
        nil
        event.message.delete
      end
    end
  end
end