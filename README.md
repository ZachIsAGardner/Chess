# Chess

Chess is an app coded in ruby that can be played in the terminal.

Instructions
===

To run navigate into the root folder and run ```ruby game.rb```

Sample Code
===

Creates pieces base on name in array.

```
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
```

```
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
```
