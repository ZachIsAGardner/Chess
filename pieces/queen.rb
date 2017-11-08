require_relative "piece"
require_relative "sliding_piece"

class Queen < Piece
  include SlidingPiece

  def move_dirs
    horizontal_dirs + diagonal_dirs
  end

end
