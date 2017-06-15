require 'json'

landscapes = {
  desert: {
    tiles: ["🌵","🌵","🌴","🌴","🐪","🐢","🐎"]
  },
  forest: {
    tiles: ["🌲","🌲","🌲","🌲","🐇","🌳","🌳"]
  },
  beach: {
    seperators: {
      bottom_tiles: ["🏖","🌊","⛱"]
    },
    tiles: ["🌴","🌴","🍍","🐢","🗿","🐚"]
  },
  sea: {
    tiles: ["🐬","🐳","🐙"],
    sperators: {
      top_tiles: ["🌊"]
    },
  }
}

sky = {
  "clear-day": {
    tiles: [" "],
    orbs: ["☀️"],
    extras: ["🛩","✈️"]
  },
  "clear-night": {
    tiles: [" "],
    orbs: ["🌛","🌜","🌙"],
    extras: ["🛰","🚀"]
  },
  "rain": {
    tiles: ["🌧","💧"]
  },
  "snow": {
    tiles: ["❄️","🌨"]
  },
  "sleet": {
    tiles: ["🌨","❄️","🌧","🌨","💧"]
  },
  "wind": {
    tiles: ["💨","🌬"]
  },
  "cloudy": {
    tiles: ["☁️"]
  },
  "partly-cloudy-day": {
    tiles: ["☁️"],
    orbs: ["🌤","⛅️","🌥"]
  },
  "partly-cloudy-night": {
    tiles: ["☁️"],
    orbs: ["🌛","🌜","🌙"]
  }
}

tiles = {
  "landscapes": landscapes,
  "sky": sky
}

File.open('tiles.json', 'w') do |file|
  file.write(JSON.pretty_generate(tiles))
end
