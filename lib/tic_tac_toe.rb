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

  def initialize()
    @board = [
      " ", " ", " ",
      " ", " ", " ",
      " ", " ", " "
    ]
  end
  
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    input = input.to_i - 1
    input
  end

  def move(index, token)
    @board[index] = token
  end

  def position_taken?(index)
    taken = false
    taken = true if @board[index] != " "
    taken
  end

  def valid_move?(index)
    valid = true
    if index >= 0 && index <= 8
      valid = false if self.position_taken?(index)
    else
      valid = false
    end
    valid
  end

  def turn_count
    count = 0
    @board.each do |value|
      count +=1 if value != " "
    end
    count
  end

  def current_player
    player = "O"
    player = "X" if self.turn_count.even?
    player
  end

  def turn
    input = gets.chomp
    index = self.input_to_index(input)

    until self.valid_move?(index) do
      input = gets.chomp
      index = self.input_to_index(input)
    end

    @board[index] = self.current_player
    self.display_board
  end

  def won?
    won = false

    x_locations = []
    o_locations = []
    @board.each_with_index do |value,index|
      x_locations << index if value == "X"
      o_locations << index if value == "O"
    end

    WIN_COMBINATIONS.each do |win_combo|
      won = win_combo if x_locations.combination(3).include?(win_combo)
      won = win_combo if o_locations.combination(3).include?(win_combo)
    end

    won
  end

  def full?
    full = false
    full = true if @board.count{|value| value == " "} == 0
    full
  end

  def draw?
    if self.full? && self.won? == false
      draw = true
    else
      draw = false
    end
    draw
  end

  def over?
    if self.draw? || self.won?
      over = true
    else
      over = false
    end
    over
  end

  def winner
    the_winner = nil

    x_locations = []
    o_locations = []
    @board.each_with_index do |value,index|
      x_locations << index if value == "X"
      o_locations << index if value == "O"
    end

    WIN_COMBINATIONS.each do |win_combo|
      the_winner = "X" if x_locations.combination(3).include?(win_combo)
      the_winner = "O" if o_locations.combination(3).include?(win_combo)
    end

    the_winner
  end

  def play
    until self.over? do
      self.turn
    end

    if self.won?
      puts "Congratulations #{self.winner}!"
    else
      puts "Cat's Game!"
    end
  end
end