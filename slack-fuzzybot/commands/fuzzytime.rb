require 'rest-client'
require 'google/cloud/language'
require 'timezone'
require 'geocoder'

module SlackFuzzybot
  module Commands
    class Fuzzytime < SlackRubyBot::Commands::Base
      match /.*fuzzy ?time.*/ do |client, data, match|
        fuzzytime = get_fuzzytime(match)
        client.web_client.chat_postMessage(
          channel: data.channel,
          as_user: true,
          attachments: [
            {
              pretext: fuzzytime[:pretext],
              title: fuzzytime[:time],
              text: fuzzytime[:text],
              mrkdwn_in: %w[text title]
            }
          ].compact.to_json
        )
      end

      def self.get_fuzzytime(input)
        entities = LanguageParser.new(input).entities
        acceptable_entities = %i[LOCATION WORK_OF_ART]
        rejected_entities = [:OTHER]
        location_phrase = entities.reject { |e| rejected_entities.include?(e.type) }.map(&:name).join(', ') if (entities.map(&:type) & acceptable_entities).any?
        return { pretext: 'I couldnt find any locations in your request' } if location_phrase.nil? || location_phrase.empty?

        location = Geocoder.search(location_phrase).first
        return { pretext: "I couldn't find a location for #{location_phrase}" } if location.nil?

        timezone = Timezone.lookup(location.latitude, location.longitude)
        return { pretext: "I couldnt find a timezone for #{location}" } if timezone.nil?

        fuzzytime = RestClient.get(ENV['FUZZYTIME_API_URL'], params: { timezone: timezone })
        return { pretext: 'I had problems getting the fuzzytime from the server' } if fuzzytime.nil?

        url = Geocoder::Lookup.get(:google).map_link_url(location.coordinates)
        formatted_address = location.formatted_address
        return {
          pretext: "Here's the fuzzy time",
          time: fuzzytime,
          text: "<#{url}|#{formatted_address}>"
        }
      rescue => e
        {
          pretext: 'Something went terribly wrong:',
          text: e
        }
      end
    end

  end
end