class Help < SlackRubyBot::Commands::Base
  class << self
    private

    def general_text
      other_commands_descs = CommandsHelper.instance.other_commands_descs
    end
  end
end
