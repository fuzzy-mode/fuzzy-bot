module CommonSnail
  class Sky
    def initialize
      file = File.read('common-snail/tiles.json')
      @tiles = JSON.parse(file)["sky"]
    end

    def generate(weather)
      tiles = @tiles[weather]["tiles"] rescue ["❗️"]
      orb = @tiles[weather]["orbs"].sample rescue " "
      sky(tiles,orb).to_s
    end

    private

    def sky(tiles,orb=" ")
      sky = []
      sky << insert_orb(row(tiles),orb)
      sky.unshift("­")
      sky.join("")
    end

    def row(tiles,num_chars=18)
      row = []
      num_chars.times do
        if rand(0..100) % 10 == 0
          row << tiles.sample
        else
          row << " "
        end
      end
      row
    end

    def insert_orb(row,orb)
      row << orb
      row = row.shuffle
    end

  end
end
