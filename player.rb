class Player

  attr_reader :display, :color, :name

  def initialize(name, board, display, color)
    @name = name
    @board = board
    @display = display
    @color = color
  end

end
