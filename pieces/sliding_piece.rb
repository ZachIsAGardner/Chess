module SlidingPiece

  def moves
    end_positions = []
    directions = move_dirs
    directions.each do |dxdy|
      end_positions += grow_unblocked_moves_in_dir(dxdy[0], dxdy[1])
    end
    end_positions
  end

  private

  def move_dirs()

  end

  def horizontal_dirs()
    [[-1,0],
    [1,0],
    [0,1],
    [0,-1]]
  end

  def diagonal_dirs()
    [[-1,1],
    [-1,-1],
    [1,-1],
    [1,1]]
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    new_pos = @pos
    valid_end_positions = []
    new_pos = increment(new_pos, dx, dy)

    while valid_move?(new_pos)

      valid_end_positions << new_pos
      break if @board[new_pos].class != NullPiece && @board[pos].color != @board[new_pos].color
      new_pos = increment(new_pos, dx, dy)

    end
    valid_end_positions
  end

  def increment(pos, dx, dy)
    [pos[0] + dx, pos[1] + dy]
  end

end
