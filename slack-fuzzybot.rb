require 'slack-ruby-bot'
require 'slack-fuzzybot/bot'
require 'slack-fuzzybot/language_parser'
require 'slack-fuzzybot/commands/help'
require 'slack-fuzzybot/commands/fuzzytime'
require 'slack-fuzzybot/commands/snail'
require 'slack-fuzzybot/commands/weather'
require 'common-snail/scene'

require 'forecast_io'

SlackRubyBot.configure do |config|
  Timezone::Lookup.config(:google) { |c| c.api_key = ENV['GOOGLE_MAPS_TIMEZONE_API_KEY'] }
  Geocoder.configure(lookup: :google_places_search, api_key: ENV['GOOGLE_MAPS_API_KEY'], use_https: true)
  ForecastIO.api_key = ENV['FORECAST_IO_API_KEY']
end

