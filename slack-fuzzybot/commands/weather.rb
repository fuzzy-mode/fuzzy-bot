require 'forecast_io'

module SlackFuzzybot
  module Commands
    class Weather < SlackRubyBot::Commands::Base
      help do
        title 'weatherman'
        desc 'Tells you the weather'
        long_desc 'Tells you the current coniditions for a location'
        command 'weatherman' do
          desc 'Current conditions'
        end
      end

      command 'weatherman' do |client, data, match|
        location = match[:expression] || ENV['DEFAULT_LOCATION']
        message = process_request(location)
        client.web_client.chat_postMessage(
          channel: data.channel,
          as_user: true,
          attachments: [
            {
              pretext: message[:pretext],
              text: message[:text],
              mrkdwn_in: %w[text]
            }
          ].compact.to_json
        )
      end


      def self.process_request(query)
        location = Geocoder.search(query).first
        return { text: "I couldn't find a location for #{query}" } if location.nil?
        forecast = ForecastIO.forecast(location.latitude,location.longitude)
        current_conditions = forecast[:currently]
        url = Geocoder::Lookup.get(:google).map_link_url(location.coordinates)
        return { text: "The current conditions for <#{url}|#{query}> is *#{current_conditions[:temperature]}* and *#{current_conditions[:summary]}*." }
      rescue => e
        {
          pretext: 'Something went terribly wrong:',
          text: e
        }
      end

    end
  end
end
