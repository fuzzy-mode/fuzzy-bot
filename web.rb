require 'sinatra/base'

module SlackFuzzybot
  class Web < Sinatra::Base
    get '/' do
      "It's Fuzzytime"
    end
  end
end
