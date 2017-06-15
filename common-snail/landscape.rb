module CommonSnail
  class Landscape

    def initialize(sprite)
      @sprite = sprite
      file = File.read('common-snail/tiles.json')
      @tiles = JSON.parse(file)["landscapes"]
    end

    def generate(name)
      tiles = @tiles[name]["tiles"] rescue ["❗️"]
      landscape = []
      1.times do
        landscape << row(tiles)
      end
      landscape << sprite_row(@sprite, [" "])
      1.times do
        landscape << row(tiles)
      end
      landscape
    end

    protected

    def sprite_row(sprite, tiles)
      new_row = row(tiles)
      new_row[0] = sprite
      new_row.split("").shuffle.join
    end

    def row(tiles)
      new_row = []
      18.times do
        if rand(0..1000) % 5 == 0
          new_row << tiles.sample
        else
          new_row << " "
        end
      end
      new_row << "\n"
      new_row.join
    end

  end
end
