require_relative 'landscape'
require_relative 'sky'

module CommonSnail
  class Scene
    def initialize(sprite: '🐌')
      @sprite = sprite
    end
    def generate(landscape='forest', weather='clear-day')
      scene = []
      scene << Sky.new.generate(weather)
      scene << "\n"
      scene << Landscape.new(@sprite).generate(landscape)
      scene.join
    end
  end

  if __FILE__ == $0
    landscape_name, weather, *options = ARGV
    puts Scene.new.generate(landscape_name, weather)
  end
end
