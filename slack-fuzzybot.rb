require 'slack-ruby-bot'
require 'slack-fuzzybot/bot'
require 'slack-fuzzybot/language_parser'
require 'slack-fuzzybot/commands/fuzzytime'
require 'slack-fuzzybot/commands/snail'
require 'common-snail/scene'

SlackRubyBot.configure do |config|
  Timezone::Lookup.config(:google) { |c| c.api_key = ENV['GOOGLE_MAPS_TIMEZONE_API_KEY'] }
  Geocoder.configure(lookup: :google_places_search, api_key: ENV['GOOGLE_MAPS_API_KEY'], use_https: true)
end

