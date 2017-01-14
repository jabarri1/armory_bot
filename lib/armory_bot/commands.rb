module ArmoryBot

	module Commands
		Dir["#{File.dirname(__FILE__)}/commands/*.rb"].each { |file| require file }
	end
end