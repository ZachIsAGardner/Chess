require_relative "piece"
require_relative 'stepping_piece'

class Knight < Piece
  include SteppingPiece

  def move_diffs
    [[-2, -1],
    [-2,  1],
    [-1, -2],
    [-1,  2],
    [ 1, -2],
    [ 1,  2],
    [ 2, -1],
    [ 2,  1]]
  end
end
