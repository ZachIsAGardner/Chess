module SteppingPiece

  def moves
    end_positions = []

    differentials = move_diffs
    differentials.each do |diff|
      new_pos = [diff[0] + pos[0], diff[1] + pos[1]]
      end_positions << new_pos if valid_move?(new_pos)
    end
    end_positions
  end

  private

  def move_diffs
    raise "Need differentials of individual pieces"
  end

end
