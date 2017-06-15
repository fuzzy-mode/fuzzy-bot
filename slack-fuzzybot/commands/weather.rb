module SlackFuzzybot
  module Commands
    class Weather < SlackRubyBot::Commands::Base

      command 'weatherman' do |client, data, match|
        message = process_request(match[:expression])
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
