#require 'discordrb'
#require 'httparty'
#require 'nokogiri'
require 'bundler/setup'
Bundler.require(:default)

require_relative 'armory_bot/version'

require_relative 'armory_bot/bot'

#Dir["#{File.dirname(__FILE__)}/armory_bot/commands/*.rb"].each { |file| require file }
#Dir["#{File.dirname(__FILE__)}/armory_bot/events/*.rb"].each { |file| require file }
#Dir["#{File.dirname(__FILE__)}/armory_bot/heroes/*.rb"].each { |file| require file }
#Dir["#{File.dirname(__FILE__)}/armory_bot/hots/*.rb"].each { |file| require file }

require_relative 'armory_bot/commands'
require_relative 'armory_bot/events'
require_relative 'armory_bot/heroes'
require_relative 'armory_bot/hots'

require_relative 'armory_bot/armorybot'