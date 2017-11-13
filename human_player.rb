require_relative 'display'
require_relative 'board'
require_relative 'player'
require 'byebug'

class HumanPlayer < Player

  def make_move
    begin
      start_pos = nil
      end_pos = nil

      until start_pos && end_pos
        display.render

        if !start_pos
          puts "#{@name.colorize(@color)} make your move. Select a piece."
          start_pos = display.cursor.get_input
        else
          puts "#{@name.colorize(@color)} make your move. Select a destination."
          end_pos = display.cursor.get_input
        end

      end

      display.render
      if end_pos == start_pos
        raise "stop"
      else
        if @board.valid_move?(start_pos, end_pos)
          @board.move_piece(color, start_pos, end_pos)
        else
          raise "Invalid move"
        end

      end

    rescue StandardError => error
      start_pos = nil
      end_pos = nil

      @display.reset_selected
      @display.selection_1, @display.selection_2 = nil, nil
      @board.messages[:error] = error
      retry
    end

    @display.reset_selected
    @display.selection_1, @display.selection_2 = nil, nil
  end

end
