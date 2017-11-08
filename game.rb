require_relative 'board'
require_relative 'display'
require_relative 'human_player'

class Game

  attr_accessor :board, :display

  def initialize(board, display, player_1, player_2)
    @board = board
    @display = display
    @players = [player_2, player_1]
  end

  def swap_turn!
    @players.rotate!
  end

  def play
    until @board.checkmate(@players.first.color)
      @board.in_check?(@players.first.color)
      take_turn
      swap_turn!
    end
    puts "Checkmate! #{@players.last.name} wins!"
  end

  def take_turn
    @players.first.make_move
  end

end

board = Board.new
display = Display.new(board)
player_1 = HumanPlayer.new("Bowser", board, display, :white)
player_2 = HumanPlayer.new("Ganondorf", board, display, :black)

game = Game.new(board, display, player_1, player_2)
game.play
