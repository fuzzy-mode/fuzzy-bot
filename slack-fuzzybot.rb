require 'slack-ruby-bot'
require 'slack-fuzzybot/bot'
require 'slack-fuzzybot/commands/fuzzytime'

SlackRubyBot.configure do |config|
  Timezone::Lookup.config(:google) { |c| c.api_key = ENV['GOOGLE_MAPS_TIMEZONE_API_KEY'] }
  Geocoder.configure(lookup: :google, api_key: ENV['GOOGLE_MAPS_API_KEY'], use_https: true)
end

