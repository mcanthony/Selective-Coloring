require 'rubygems'
require 'chunky_png'

module ChunkyPNG::Color
  def h(color)
    color_value = {
      :red => r(color) / 255.0,
      :green => g(color) / 255.0,
      :blue => b(color) / 255.0
    }
    c = color_value.values.max - color_value.values.min
    return nil if c == 0
    case color_value.values.max
    when color_value[:red]
      hue = ((color_value[:green] - color_value[:blue]) / c) % 6
    when color_value[:green]
      hue = 2.0 + ((color_value[:blue] - color_value[:green]) / c)
    when color_value[:blue]
      hue = 4.0 + ((color_value[:red] - color_value[:green]) / c)
    end
    hue * 60  
  end
end
  
module ChunkyPNG::Canvas::Operations
  def selective_color(rgb, tolerance)
    target_hue = ChunkyPNG::Color.h(ChunkyPNG::Color.rgb(rgb[0], rgb[1], rgb[2]))
    output = self.grayscale
    (0...dimension.width).each do |x|
      (0...dimension.height).each do |y|
        current_hue = ChunkyPNG::Color.h(self[x,y])
        if !current_hue.nil? && ((target_hue - current_hue).abs < tolerance)
          output[x,y] = self[x,y]
        end
      end
    end
    output
  end
end

input = ChunkyPNG::Image.from_file('input.png')
input.selective_color([79,61,171], 30).save('output-purple.png')
input.selective_color([90,160,218], 20).save('output-blue.png')
input.selective_color([165, 224, 81], 5).save('output-green.png')
input.selective_color([255, 160, 0], 18).save('output-yellow.png')
input.selective_color([213, 50, 41], 10).save('output-red.png')