module SlackFuzzybot
  module Commands
    class Snail < SlackRubyBot::Commands::Base

      command 'snail' do |client, data, match|
        args = match[:expression].split(' ') rescue []
        scene = args[0] || 'beach'
        weather = args[1] || 'clear-day'
        message = CommonSnail::Scene.new.generate(scene,weather)
        client.say(channel: data.channel, text: message)
      end

    end
  end
end
