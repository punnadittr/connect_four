class ConnectFour
  attr_accessor :piece

  def initialize
    @piece = 'O'
  end

  def switch_turn
    @piece = @piece == 'O' ? 'X' : 'O'
    return "#{@piece}'s turn"
  end

  def create_board(width, height)
    @board = []
    height.times do
      @board << Array.new(width, ' ')
    end
    @board
  end

  # combine put_piece and game_over function to evaluate every move
  def make_move(x, piece = @piece)
    return 'INVALID MOVE' if put_piece(x, piece) == false
    print_board
    unless game_over?
      switch_turn
    else
      return "GAME OVER #{@piece} wins!"
    end
  end

  def put_piece(x_line, piece = 'O')
    y_line = 0
    # find empty space to put a piece
    until @board[y_line].nil? || @board[y_line][x_line] == ' '
      y_line += 1
    end
    # if the y line is full, return false
    return false if @board[y_line].nil?
    @board[y_line][x_line] = piece
    @board.reverse
  end

  def game_over?
    if row_condition(@piece) || column_condition(@piece) ||
      diagonal_condition(@piece, 0) || diagonal_condition(@piece, 6)
      true
    else
      false
    end
  end

  def tie?
    if @board.flatten.all? { |piece| piece != ' ' }
      true
    else 
      false
    end
  end

  # create a new board
  def reset
    @piece = 'O'
    create_board 7, 6
  end

  # condition for diagonal winning (both sides)
  def diagonal_condition(piece, x)
    initial_x = x
    y = 0
    x_counter = x
    y_counter = 0
    piece_counter = 0
    until y_counter > 2
      until @board[y].nil? || @board[y][x].nil?
        if @board[y][x] == piece
          piece_counter += 1
          return true if piece_counter == 4
        else
          piece_counter = 0
        end
        y += 1
        x += 1 if initial_x == 0
        x -= 1 if initial_x == 6
      end
      if (x_counter < 3 || x_counter > 3) && y_counter == 0
        x_counter += 1 if initial_x == 0
        x_counter -= 1 if initial_x == 6
      else
        x_counter = initial_x
        y_counter += 1
      end
      x = x_counter
      y = y_counter
      piece_counter = 0
    end
    false
  end

  def column_condition(piece = 'O')
    y = 0
    x = 0
    piece_counter = 0
    7.times do
      until @board[y].nil?
        if @board[y][x] == piece
          piece_counter += 1
          return true if piece_counter == 4
        else
          piece_counter = 0
        end
        y += 1
      end
      x += 1
      y = 0
      piece_counter = 0
    end
    return false
  end

  def row_condition(piece = 'O')
    piece_counter = 0
    for row in @board
      for space in row
        if space == piece
          piece_counter += 1
          return true if piece_counter == 4
        else
          piece_counter = 0
        end
      end
      piece_counter = 0
    end
    false
  end

  def print_board
    @board.reverse.each_with_index do |row, i|
      puts "+---+---+---+---+---+---+---+"
      print "| "
      print row.join(" | ")
      puts " |"
      if i == @board.size - 1
        puts "+---+---+---+---+---+---+---+"
      end
    end
  end

  # get the correct game over condition (used for testing)
  def game_over_debug?
    if diagonal_condition(@piece, 6)
      puts "GAME OVER DIAG2 #{@piece} wins"
      return true
    elsif diagonal_condition(@piece, 0)
      puts "GAME OVER DIAG1 #{@piece} wins"
      return true
    elsif row_condition(@piece)
      puts "GAME OVER ROW #{@piece} wins"
      return true
    elsif column_condition(@piece)
      puts "GAME OVER COLUMN #{@piece} wins"
      return true
    elsif tie?
      puts 'TIE'
      return true
    else
      return false
    end
  end

  # put piece anywhere in the board (used for testing)
  def put_piece_debug(x_line, y_line, piece = 'O')
    @board[y_line][x_line] = piece
    print_board
  end
end

game = ConnectFour.new
game.create_board 7,6