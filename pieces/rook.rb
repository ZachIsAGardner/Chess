require_relative "piece"
require_relative "sliding_piece"

class Rook < Piece
  include SlidingPiece

  def move_dirs
    horizontal_dirs
  end

end
