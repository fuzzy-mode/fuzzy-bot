module SlackFuzzybot
  class LanguageParser
    def initialize(message)
      @document = language_client.document message
    end

    def entities
      @document.entities
    end

    def sentiment
      @document.sentiment
    end

    def syntax
      @document.syntax
    end

    private

    def language_client
      @language_client ||= Google::Cloud::Language.new project: ENV['GOOGLE_CLOUD_PLATFORM_PROJECT_ID']
    end
  end
end
