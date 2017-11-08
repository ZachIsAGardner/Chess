
require 'colorize'
require_relative 'cursor'

ICONS = {
  Rook => "R",
  Pawn => "p",
  Queen => "Q",
  King => "K",
  Knight => "N",
  Bishop => "B",
  NullPiece => " "
}

class Display

attr_accessor :selection_1, :selection_2
attr_reader :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
    @selection_1 = nil
    @selection_2 = nil
  end

  def reset_selected
    @board.grid.each_with_index do |row, i|
      row.each_with_index do |col, j|
        pos = [i, j]
        if @board[pos].selected
          @board[pos].toggle_selected
        end
      end
    end
  end

  def render
    system "clear"
    # debug_info
    @board.grid.each_with_index do |row, i|
      row.each_with_index do |col, j|
        pos = [i, j]

        if @board[pos].selected

          @selection_2 = pos if @selection_1 && @selection_1 != pos
          @selection_1 = pos if @selection_1 == nil

          print "[#{ICONS[@board[pos].class]}]".green
          next
        end

        if pos == @cursor.cursor_pos
          print "[#{ICONS[@board[pos].class]}]".red
        else
          print "[#{ICONS[@board[pos].class].colorize(@board[pos].color)}]"
        end

      end
      puts "\n"
    end
    puts "\n"
    @board.messages.each {|k, message| puts message}
    puts "\n"
  end

  # def test_render
  #   p "Display debug info? y/n"
  #   bool = gets.chomp.downcase
  #
  #   while true
  #
  #     system 'clear'
  #
  #     render
  #     debug_info if bool == "y"
  #     @cursor.get_input
  #   end
  # end

  def debug_info
    if @selection_1
      puts "\n"
      puts "selection 1: #{@selection_1}"
      puts "selection 2: #{@selection_2}"
      puts "piece: #{@board[@selection_1]}"
      puts "color: #{@board[@selection_1].color}"
      puts "current position: #{@selection_1}"
      puts "moves: #{@board[@selection_1].moves}"
      puts "\n"
    end


  end

end
