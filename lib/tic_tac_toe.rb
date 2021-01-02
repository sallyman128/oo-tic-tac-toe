require 'pry'

class TicTacToe
  # 0 1 2
  # 3 4 5
  # 6 7 8

  WIN_COMBINATIONS = [
    [0,1,2], #Top row
    [3,4,5], #Center row
    [6,7,8], #Bottom row

    [0,3,6], #Left column
    [1,4,7], #Center column
    [2,5,8], #Right Column

    [0,4,8], #Top Left - Bottom Right Diagonal
    [2,4,6]  #Top Right - Bottom Left Diagonal
  ]

  def initialize
    @board = Array.new(9," ")
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    input = user_input.to_i
    input -= 1
  end

  def move(input, token = "X")
    @board[input] = token
  end

  def position_taken?(index)
    decision = false
    decision = true if @board[index] == "X" || @board[index] == "O"
    decision
  end
  
  def valid_move?(position)
    decision = false

    on_board = false
    on_board = true if position >= 0 && position <= 8

    unoccupied = false
    unoccupied = true if position_taken?(position) == false
    
    decision = true if unoccupied && on_board
    decision
  end

  def turn_count
    @board.count {|token| token == "X" || token == "O"}
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn
    loop do
      input = gets.chomp

      index = input_to_index(input)
      token = current_player
      if valid_move?(index)
        move(index, token)
        display_board
        break
      end
    end
  end

  def won?
    decision = false

    winning_combo = []

    WIN_COMBINATIONS.each do |combo|
      win_index1 = combo[0]
      win_index2 = combo[1]
      win_index3 = combo[2]

      one_two_same = @board[win_index1] == @board[win_index2]
      two_three_same = @board[win_index2] == @board[win_index3]
      one_three_same = @board[win_index1] == @board[win_index3]

      if one_two_same && two_three_same && one_three_same
        winning_combo = combo
      end
    end

    winning_combo = false if winning_combo == []

    winning_combo
  end

  def full?
    full = true
    full = false if @board.include?(" ")
    full
  end

  def draw?
    draw = true
    draw = false if (won? && full?) || (full? != true)
    draw
  end

  def over?
    over = false
    over = true if draw? || won?
    over
  end

  def winner

    if won?.length > 0 && draw? == false
      winning_combo = won?
      the_winner = @board[winning_combo[0]]
    end

    the_winner = nil if the_winner == " "
    the_winner
  end

end