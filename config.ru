ENV['RACK_ENV'] ||= 'development'

Bundler.require :default

require 'dotenv'
require 'yaml'
require 'forecast_io'

require_relative 'fuzzy_bot/app'

Dotenv.load

ActiveRecord::Base.establish_connection(YAML.load_file('config/postgresql.yml')[ENV['RACK_ENV']])

SlackRubyBotServer.configure do |config|
  Timezone::Lookup.config(:google) { |c| c.api_key = ENV['GOOGLE_MAPS_TIMEZONE_API_KEY'] }
  Geocoder.configure(lookup: :google_places_search, api_key: ENV['GOOGLE_MAPS_API_KEY'], use_https: true)
  ForecastIO.api_key = ENV['FORECAST_IO_API_KEY']
end

FuzzyBot::App.instance.prepare!

SlackRubyBotServer::Service.start!

run SlackRubyBotServer::Api::Middleware.instance
