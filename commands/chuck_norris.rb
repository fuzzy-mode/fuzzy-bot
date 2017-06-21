require 'rest-client'
class ChuckNorris < SlackRubyBot::Commands::Base

  command 'chuck'
  command 'chucknorris'

  def self.call(client, data, _match)
    chuck_norris = RestClient.get(ENV['CHUCK_NORRIS_URL'])
    joke = JSON.parse(chuck_norris)["value"]
    client.web_client.chat_postMessage(
      channel: data.channel,
      as_user: true,
      attachments: [
        {
          thumb_url: 'https://assets.chucknorris.host/img/avatar/chuck-norris.png',
          text: joke,
          mrkdwn_in: %w[text]
        }
      ].compact.to_json
    )
  end

end
