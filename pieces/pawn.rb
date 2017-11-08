require_relative "piece"
require_relative "stepping_piece"

class Pawn < Piece
  include SteppingPiece

  def moves
    end_positions = []

    forward_steps.each do |f_step|
      end_positions << f_step if valid_move?(f_step)
    end
    side_attacks.each do |a_pos|
      end_positions << a_pos if valid_move?(a_pos)
    end

    end_positions
  end

  protected

  def at_start_row?()
    if self.color == :black && self.pos[0] == 1
      return true
    elsif self.color == :white && self.pos[0] == 6
      return true
    end
    false
  end

  def forward_dir
    (self.color == :black) ? [1,0] : [-1,0]
  end

  def forward_steps
    forward_moves = []
    if at_start_row?
      forward_moves << [pos[0] + forward_dir[0], pos[1]]
      forward_moves << [forward_moves.last[0] + forward_dir[0], pos[1]]
    else
      forward_moves << [pos[0] + forward_dir[0], pos[1]]
    end
    forward_moves
  end

  def side_attacks
    attack_positions = []
    attack_positions << [pos[0] + forward_dir[0], pos[1] - 1]
    attack_positions << [pos[0] + forward_dir[0], pos[1] + 1]

    attack_positions.select {|a_pos| @board[a_pos] != nil && @board[a_pos].class != NullPiece && @board[a_pos].color != self.color}
    # attack_positions.select {|a_pos| p @board[a_pos].class}
  end

end
