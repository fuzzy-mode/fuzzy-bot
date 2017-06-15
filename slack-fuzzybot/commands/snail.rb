module SlackFuzzybot
  module Commands
    class Snail < SlackRubyBot::Commands::Base

      command 'snail' do |client, data, match|
        message = CommonSnail::Scene.new.generate(match[:expression])
        client.say(channel: data.channel, text: message)
      end

    end
  end
end
