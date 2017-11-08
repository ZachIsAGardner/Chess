class Piece

  attr_accessor :pos, :selected, :board
  attr_reader :color

  def initialize(pos, board, color = nil)
    @pos = pos
    @selected = false
    @board = board
    if (color)
      @color = color
    else
      add_to_team
    end
  end

  def toggle_selected
    @selected = !@selected
  end

  def add_to_team
    if pos[0] <= 3
      @color = :black
    else
      @color = :white
    end
  end

  def moves

  end

  def valid_moves
    moves.reject{|move| move_into_check?(move)}
    # moves
  end

  def move_into_check?(end_pos)
    start_pos = self.pos
    # duped_board = @board.dd_board

    @defeated_piece = @board.move_piece(self.color, self.pos, end_pos)

    result = @board.in_check?(self.color)
    undo_move(start_pos)

    return result
  end

  def undo_move(start_pos)
    defeated_pos = self.pos

    @board.move_piece!(self.pos, start_pos)

    if @defeated_piece.class != NullPiece
      @board[defeated_pos] = @defeated_piece.class.new(defeated_pos, @board, @defeated_piece.color)
    end
  end

  def valid_move?(pos)
    if !pos[0].between?(0,7) || !pos[1].between?(0,7) || @board[pos].color == self.color
      return false
    end
    true
  end


end
