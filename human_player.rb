require_relative 'display'
require_relative 'board'
require 'byebug'

class HumanPlayer

  attr_reader :display, :color, :name

  def initialize(name, board, display, color)
    @name = name
    @board = board
    @display = display
    @color = color
  end

  def make_move
    begin
      start_pos = nil
      end_pos = nil

      until start_pos && end_pos
        display.render

        if !start_pos
          puts "#{@name} make your move. Select a piece."
          start_pos = display.cursor.get_input
        else
          puts "#{@name} make your move. Select a destination."
          end_pos = display.cursor.get_input
        end

      end

      display.render
      if @board.valid_move?(start_pos, end_pos)
        @board.move_piece(color, start_pos, end_pos)
      else
        raise "You're still in check"
      end

    rescue StandardError => error
      start_pos = nil
      end_pos = nil
      @board[@display.selection_1].toggle_selected
      @board[@display.selection_2].toggle_selected
      @display.selection_1, @display.selection_2 = nil, nil
      @board.messages[:error] = error
      retry
    end

    @board[@display.selection_2].toggle_selected
    @display.selection_1, @display.selection_2 = nil, nil
  end


end
