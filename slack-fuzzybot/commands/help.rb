module SlackRubyBot
  module Commands
    class HelpCommand < Base
      class << self
        private

        def general_text
          other_commands_descs = CommandsHelper.instance.other_commands_descs
        end
      end
    end
  end
end
