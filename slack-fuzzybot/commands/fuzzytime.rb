require 'rest-client'
require 'google/cloud/language'
require 'timezone'
require 'geocoder'

module SlackFuzzybot
  module Commands
    class Fuzzytime < SlackRubyBot::Commands::Base
      match /.*fuzzy ?time.*/ do |client, data, match|
        user_timezone = client.web_client.users_info(user: data.user).user['tz']
        fuzzytime_request = get_fuzzytime(match, user_timezone)
        client.web_client.chat_postMessage(
          channel: data.channel,
          as_user: true,
          attachments: [
            {
              pretext: fuzzytime_request[:pretext],
              title: fuzzytime_request[:title],
              text: fuzzytime_request[:text],
              mrkdwn_in: %w[text title]
            }
          ].compact.to_json
        )
      end

      def self.get_fuzzytime(input, user_timezone)
        entities = LanguageParser.new(input).entities
        acceptable_entities = %i[LOCATION WORK_OF_ART]
        rejected_entities = [:OTHER]
        location_phrase = entities.reject { |e| rejected_entities.include?(e.type) }.map(&:name).join(', ') if (entities.map(&:type) & acceptable_entities).any?
        if location_phrase.nil? || location_phrase.empty?
          fuzzytime_request = RestClient.get(ENV['FUZZYTIME_API_URL'], params: { timezone: user_timezone })
          return { text: "Your fuzzy time is *#{fuzzytime_request}*" }
        end

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
          title: fuzzytime,
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