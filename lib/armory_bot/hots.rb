module ArmoryBot

	module Hots
		Dir["#{File.dirname(__FILE__)}/hots/*.rb"].each { |file| require file }
	end
end