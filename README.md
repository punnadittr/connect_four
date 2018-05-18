**# Simple Ruby Connect Four**

## Sample Display Grid 7*6 (There is no number indicator in actual program)
  ```
    +---+---+---+---+---+---+---+
  5 |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+
  4 |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+
  3 |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+
  2 |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+
  1 |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+
  0 |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+
      0   1   2   3   4   5   6
  ```
## To start, use 
`ruby connect_four.rb`

## To make a move, use 
`game.make_move(horizontal_position)`

  ### Example

  `game.make_move 1`
```
    +---+---+---+---+---+---+---+
  5 |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+
  4 |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+
  3 |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+
  2 |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+
  1 |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+
  0 |   | O |   |   |   |   |   |
    +---+---+---+---+---+---+---+
      0   1   2   3   4   5   6

  => X's Turn
```
  `game.make_move 1`
```
    +---+---+---+---+---+---+---+
  5 |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+
  4 |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+
  3 |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+
  2 |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+
  1 |   | X |   |   |   |   |   |
    +---+---+---+---+---+---+---+
  0 |   | O |   |   |   |   |   |
    +---+---+---+---+---+---+---+
      0   1   2   3   4   5   6
      
  => O's Turn
```