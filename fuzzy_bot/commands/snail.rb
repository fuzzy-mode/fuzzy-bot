class Snail < SlackRubyBot::Commands::Base
  help do
    title 'snail'
    desc 'Common Snail'
    long_desc 'Updates you with common snails adventures'
  end

  command 'snail' do |client, data, match|
    args = match[:expression].split(' ') rescue []
    scene = args[0] || 'beach'
    weather = args[1] || 'clear-day'
    message = CommonSnail::Scene.new.generate(scene,weather)
    client.say(channel: data.channel, text: message)
  end

end
