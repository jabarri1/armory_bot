module ArmoryBot

	module Heroes
		Dir["#{File.dirname(__FILE__)}/heroes/*.rb"].each { |file| require file }
	end
end