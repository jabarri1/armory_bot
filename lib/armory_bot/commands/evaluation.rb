module ArmoryBot
  module Commands
    module Evaluation
      extend Discordrb::Commands::CommandContainer
      command(:eval, bucket: :armory) do |event, *code|
        break unless event.user.id == 100311929821626368

        begin
          eval code.join(' ')
        rescue
          "An error occured 😞"
        end
      end
    end
  end
end