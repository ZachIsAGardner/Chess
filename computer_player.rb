require_relative 'display'
require_relative 'board'
require_relative 'player'
require 'byebug'

class ComputerPlayer < Player

  def make_move
    pieces = @board.pieces(@color)
    selectedPiece = pieces[rand(pieces.length - 1)]
    while selectedPiece.valid_moves.length <= 0 do
      selectedPiece = pieces[rand(pieces.length - 1)]
    end
    puts "selected piece: " + selectedPiece.class.to_s

    moves = selectedPiece.valid_moves
    move = moves[rand(moves.length - 1)]
    puts "valid moves :" + moves.to_s
    puts "move: " + move.to_s

    @board.move_piece(@color, selectedPiece.pos, move)
    display.render
  end

end
