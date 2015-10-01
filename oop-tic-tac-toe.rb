class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

end

class Human < Player
  def take_turn(board)
    begin
      puts "\nPlease choose a square #{self.name}:"
      choice = gets.chomp.to_i
    end until board.free_squares.include?(choice)

    board.game_board[choice] = "X"
  end
end

class Computer < Player
  def take_turn(board)
    choice = board.free_squares.sample
    board.game_board[choice] = "O"
  end
end

class Board
  attr_accessor :game_board
  attr_reader   :empty_squares

  def initialize
    @game_board = {}
  end

  def create_empty_board
    1.upto(9) { |square| self.game_board[square] = " " }
  end

  def free_squares
    self.game_board.select { |k, v| v == " " }.keys
  end

  def draw_board
    system 'clear'
    puts " #{self.game_board[1]} | #{self.game_board[2]} | #{self.game_board[3]} "
    puts "-----------"
    puts " #{self.game_board[4]} | #{self.game_board[5]} | #{self.game_board[6]} "
    puts "-----------"
    puts " #{self.game_board[7]} | #{self.game_board[8]} | #{self.game_board[9]} "
  end

  def winner(human, computer)
    winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7],
                     [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
    winning_lines.each do |line|
      return human.name if game_board.values_at(*line).count('X') == 3
      return computer.name if game_board.values_at(*line).count('O') == 3
    end
    nil
  end
end

class Game
  attr_reader :board, :human, :computer

  def initialize
    @board    = Board.new
    @human    = Human.new("Joe")
    @computer = Computer.new("iMac")
  end

  def play
    begin
      board.create_empty_board
      board.draw_board
      loop do
        human.take_turn(board)
        board.draw_board
        break if board.winner(human, computer) || board.free_squares.empty?
        computer.take_turn(board)
        board.draw_board
        break if board.winner(human, computer) || board.free_squares.empty?
      end

      if board.winner(human, computer)
        puts "\n#{board.winner(human, computer)} was the winner, well done!"
      else
        puts "\nSorry, no winner this time!"
      end

    puts "\nWould you like to play again? [y/n]"
    end until gets.chomp != 'y'
  end
end

Game.new.play
