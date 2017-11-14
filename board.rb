require_relative 'pieces/pieces'

class Board

  def self.default_board
    [['Rook','Knight','Bishop', 'King', 'Queen', 'Bishop', 'Knight', 'Rook'],
    ['Pawn','Pawn','Pawn','Pawn', 'Pawn','Pawn','Pawn','Pawn'],
    [nil, nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil, nil],
    ['Pawn','Pawn','Pawn','Pawn','Pawn','Pawn','Pawn','Pawn'],
    ['Rook','Knight','Bishop', 'King', 'Queen', 'Bishop', 'Knight', 'Rook']]
  end

  attr_accessor :grid, :messages

  def initialize(grid = Board.default_board)
    @grid = grid
    @messages = {check: '', error: ''};
    populate_board
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def populate_board
    grid.each_with_index do |row, i|
      row.each_with_index do |col, j|
        pos = [i, j]
        piece = create_piece(pos)
        self[pos] = piece
      end
    end
  end

  def create_piece(pos)
    case self[pos]
    when "Rook"
      Rook.new(pos, self)
    when "Knight"
      Knight.new(pos, self)
    when "Pawn"
      Pawn.new(pos, self)
    when "Queen"
      Queen.new(pos, self)
    when "King"
      King.new(pos, self)
    when "Bishop"
      Bishop.new(pos, self)
    when nil
      NullPiece.new
    end
  end

  def in_check?(color)
    #returns false if not in check
    grid.each_with_index do |row, i|
      row.each_with_index do |col, j|
        pos = [i, j]

        if self[pos].class != NullPiece && self[pos].color != color
          if self[pos].moves.include?(find_king(color))
            return true
          end
        end
      end
    end
    false
  end

  def find_king(color)
    grid.each_with_index do |row, i|
      row.each_with_index do |col, j|
        pos = [i, j]
        if self[pos].class == King && self[pos].color == color
          return pos
        end
      end
    end
  end

  def dd_board
    new_array = Board.new
      grid.each_with_index do |row, i|
       row.each_with_index do |col, j|
         pos = [i, j]
         new_array[pos] = self[pos]
       end
     end
     new_array
  end

  def pieces(color)
    result = []
    grid.each_with_index do |row, i|
      row.each_with_index do |col, j|
        pos = [i, j]
        result.push(self[pos]) if self[pos].color == color
      end
    end
    return result
  end

  def checkmate(color)
    @messages[:check] = ""

    grid.each_with_index do |row, i|
      row.each_with_index do |col, j|

        pos = [i, j]

        if self[pos].color == color
          return false if !self[pos].valid_moves.empty?
        end
      end
    end

    @messages[:check] = "Check!"
    true
  end

  def valid_move?(start_pos, end_pos)
    self[start_pos].valid_moves.include?(end_pos)
  end

  def move_piece(current_color, start_pos, end_pos)
    raise "No piece at starting position" if self[start_pos].class == NullPiece
    raise "Not your piece!" if self[start_pos].color != current_color

    if self[end_pos].class != NullPiece && self[end_pos].color == self[start_pos].color
      raise "Not a valid end position"
    end

    if self[start_pos].moves.include?(end_pos)
      piece = self[start_pos]
      end_piece = self[end_pos]

      self[end_pos] = piece
      self[start_pos] = NullPiece.new
      piece.pos = end_pos
      @messages[:error] = ""

      return end_piece
    else
      raise "Piece cannot move there"
    end

  end

  def move_piece!(start_pos, end_pos)
    piece = self[start_pos]
    end_piece = self[end_pos]

    self[end_pos] = piece
    self[start_pos] = NullPiece.new
    piece.pos = end_pos
  end
end
