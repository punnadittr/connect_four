require 'connect_four'

describe ConnectFour do

  before(:all) { @myboard = ConnectFour.new }
  before(:each) { @myboard.create_board(7, 6) }

  describe ".create_board" do

    context "given width and height" do
      it "creates arrays accordingly to specs" do
        expect(@myboard.create_board(7, 6)).to eql([
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ']])
      end
    end
  end

  describe ".put_piece" do

    context "when putting one piece in one row" do
      it "replaces space with the piece" do
        expect(@myboard.put_piece(2)).to eql([
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', 'O', ' ', ' ', ' ', ' ']])
      end
    end

    context "when putting a piece in already occupied space" do

      before { 2.times { @myboard.put_piece(2) } }

      it "moves to the upper row" do
        expect(@myboard.put_piece(2)).to eql([
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', 'O', ' ', ' ', ' ', ' '],
          [' ', ' ', 'O', ' ', ' ', ' ', ' '],
          [' ', ' ', 'O', ' ', ' ', ' ', ' ']])
      end
    end

    context "when putting a piece in a full column" do

      before { 6.times { @myboard.put_piece(3) } }

      it "returns false" do
        expect(@myboard.put_piece(3)).to eql false
      end
    end
  end

  describe ".game_over?" do

    describe ".row_condition" do

      context "when 4 pieces in a row" do

        before do
          4.times do |x = 0|
            @myboard.put_piece(x)
            x += 1
          end
        end

        it "returns true" do
          expect(@myboard.row_condition).to eql true
        end
      end

      context "when 4 pieces are not connected" do

        before do
          @myboard.put_piece(1)
          @myboard.put_piece(3)
          @myboard.put_piece(4)
          @myboard.put_piece(5)
        end

        it "returns false" do
          expect(@myboard.row_condition).to eql false
        end
      end
    end

    describe ".diagonal_condition" do

      context "when 4 same pieces across 0, 0" do

        before do
          @myboard.put_piece_debug(0,0)
          @myboard.put_piece_debug(1,1)
          @myboard.put_piece_debug(2,2)
          @myboard.put_piece_debug(3,3)
        end

        it "returns true" do
          expect(@myboard.diagonal_condition('O', 0)).to eql true
        end
      end

      context "when 4 same pieces across random position 1" do

        before do
          @myboard.put_piece_debug(3,0)
          @myboard.put_piece_debug(4,1)
          @myboard.put_piece_debug(5,2)
          @myboard.put_piece_debug(6,3)
        end

        it "returns true" do
          expect(@myboard.diagonal_condition('O', 0)).to eql true
        end
      end

      context "when 4 same pieces across random position 2" do

        before do
          @myboard.put_piece_debug(1,2)
          @myboard.put_piece_debug(2,3)
          @myboard.put_piece_debug(3,4)
          @myboard.put_piece_debug(4,5)
        end

        it "returns true" do
          expect(@myboard.diagonal_condition('O', 0)).to eql true
        end
      end

      context "when 4 same pieces across random position 3" do

        before do
          @myboard.put_piece_debug(0,2)
          @myboard.put_piece_debug(1,3)
          @myboard.put_piece_debug(2,4)
          @myboard.put_piece_debug(3,5)
        end

        it "returns true" do
          expect(@myboard.diagonal_condition('O', 0)).to eql true
        end
      end

      context "when 5 different pieces" do

        before do
          @myboard.put_piece_debug(0,1)
          @myboard.put_piece_debug(1,2,'X')
          @myboard.put_piece_debug(2,3)
          @myboard.put_piece_debug(3,4)
          @myboard.put_piece_debug(4,5)
        end

        it "returns false" do
          expect(@myboard.diagonal_condition('O', 0)).to eql false
        end
      end

      context "when less than 4 pieces" do
        before do
          @myboard.put_piece_debug(4,3)
          @myboard.put_piece_debug(5,4)
          @myboard.put_piece_debug(6,5)
        end
        it "returns false" do
          expect(@myboard.diagonal_condition('O', 0)).to eql false
        end
      end
    end

    #The other side of diagonal condition
    describe ".diagonal_condition_2" do

      context "when 4 same pieces across 3,1" do

        before do 
          @myboard.put_piece_debug(3,1)
          @myboard.put_piece_debug(2,2)
          @myboard.put_piece_debug(1,3)
          @myboard.put_piece_debug(0,4)
        end

        it "returns true" do
          expect(@myboard.diagonal_condition('O', 6)).to eql true
        end
      end

      context "when 4 same pieces across 6,1" do

        before do 
          @myboard.put_piece_debug(6,1)
          @myboard.put_piece_debug(5,2)
          @myboard.put_piece_debug(4,3)
          @myboard.put_piece_debug(3,4)
        end

        it "returns true" do
          expect(@myboard.diagonal_condition('O', 6)).to eql true
        end
      end

      context "when 4 same pieces across 6,0" do

        before do 
          @myboard.put_piece_debug(6,0)
          @myboard.put_piece_debug(5,1)
          @myboard.put_piece_debug(4,2)
          @myboard.put_piece_debug(3,3)
        end

        it "returns true" do
          expect(@myboard.diagonal_condition('O', 6)).to eql(true)
        end
      end
    end

    describe ".column_condition" do

      context "when 4 same pieces in the same column" do

        before { 4.times { @myboard.put_piece 6 } }

        it "returns true" do
          expect(@myboard.column_condition).to eql true
        end
      end

      context "when pieces are mixed in a column" do

        before do 
          @myboard.put_piece 6, 'X'
          @myboard.put_piece 6, 'O'
          4.times { @myboard.put_piece 6, 'X' }
        end

        it "returns true" do
          expect(@myboard.column_condition('X')).to eql true
        end
      end

      context "when 4 different pieces in the same column" do

        before do
          @myboard.put_piece 5, 'X'
          3.times { @myboard.put_piece 5 }
        end

        it "returns false" do
          expect(@myboard.column_condition).to eql false
        end
      end
    end

    describe ".tie?" do

      context "when all pieces are present in the board" do

        before do
          x = 0
          while x < 7
            2.times { @myboard.make_move(x, 'X') }
            2.times { @myboard.make_move(x, 'O') }
            2.times { @myboard.make_move(x, 'X') }
            x += 2
          end
          y = 1
          while y < 6
            2.times { @myboard.make_move(y, 'O') }
            2.times { @myboard.make_move(y, 'X') }
            2.times { @myboard.make_move(y, 'O') }
            y += 2
          end
        end

        it "returns true" do
          expect(@myboard.tie?).to eql true
        end
      end

      context "when pieces are missing from the board" do

        before do
          x = 0
          while x < 7
            2.times { @myboard.make_move(x, 'X') }
            2.times { @myboard.make_move(x, 'O') }
            2.times { @myboard.make_move(x, 'X') }
            x += 2
          end
        end

        it "returns false" do
          expect(@myboard.tie?).to eql false
        end
      end
    end
  end

  describe ".switch_turn" do

    context "when it is O's turn" do

      before do 
        @myboard.piece = 'O'
        @myboard.switch_turn
      end

      it "switches to X" do
        expect(@myboard.piece).to eql('X')
      end
    end

    context "when it is X's turn" do

      before do 
        @myboard.piece = 'X'
        @myboard.switch_turn
      end

      it "switches to O" do
        expect(@myboard.piece).to eql('O')
      end
    end
  end
end