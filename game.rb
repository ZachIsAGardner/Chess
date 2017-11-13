require_relative 'board'
require_relative 'display'
require_relative 'human_player'
require_relative 'computer_player'

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

puts "Player one is a human player? (y/n)"
input = gets.chomp
player_1 = (input == "y") ? HumanPlayer.new("Bowser", board, display, :white)
: ComputerPlayer.new("Bowser", board, display, :white)

puts "Player two is a human player? (y/n)"
input = gets.chomp
player_2 = (input == "y") ? HumanPlayer.new("Ganondorf", board, display, :black)
: ComputerPlayer.new("Ganondorf", board, display, :black)

game = Game.new(board, display, player_1, player_2)
game.play
