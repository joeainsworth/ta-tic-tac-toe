# 1. Come up with requirements
# 2. Application logic - sequence of actions
# 3. Translation of steps into code
# 4. Run code to verify the logic
#
# draw a board
#
# loop until a winner or all suqares are taken
#   player1 picks an empty square
#   check for winner
#   player2 picks an empty square
#   check for winner

# if there's a winner
#   show the winner
# or else
#   it's a tie

require 'pry'

def draw_board(b)
  system 'clear'
  puts " #{b[1]} | #{b[2]} | #{b[3]} "
  puts "-----------"
  puts " #{b[4]} | #{b[5]} | #{b[6]} "
  puts "-----------"
  puts " #{b[7]} | #{b[8]} | #{b[9]} "
end

def initialize_board
  board = {}
  1.upto(9) { |square| board[square] = " "}
  board
end

def empty_squares(b)
  b.select { |k,v| v == " " }.keys
end

def player_pick_square(b)
  loop do
    puts "\nPick a square:"
    square = gets.chomp.to_i
    if empty_squares(b).include?(square)
      b[square] = "X"
      break
    end
  end
end

def computer_pick_square(b)
  b[empty_squares(b).sample] = "O"
end

def winner(b)
  winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7],
                   [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
  winning_lines.each do |line|
    return "Player" if b.values_at(*line).count('X') == 3
    return "Computer" if b.values_at(*line).count('O') == 3
  end
  nil
end

board = initialize_board
draw_board(board)

loop do
  player_pick_square(board)
  draw_board(board)
  if winner(board)
    puts "\n#{winner(board)} is the winner!"
    break
  elsif empty_squares(board).empty?
    puts "\nAll squares taken, no winner!"
    break
  end
  computer_pick_square(board)
  draw_board(board)
    if winner(board)
    puts "\n#{winner(board)} is the winner!"
    break
  elsif empty_squares(board).empty?
    puts "\nAll squares taken, no winner!"
    break
  end
end
