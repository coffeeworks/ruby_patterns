# https://github.com/coffeeworks/gradie

Gradie::Images.new(:dir => './output') do
  image('background-header.png', :width => 5) do
    gradient :white, '#DADADA', :height => 50
    solid :red, :height => 10
    gradient :red, :black, :height => 50
  end

  image('stripes.png', :width => 10) do
    10.times do
      solid :black, :height => 10
      solid :red, :height => 10
    end
  end
end

