require "option_parser"

game = Game.new

module Tictactoe
  VERSION = "0.1.0"

  option_parser = OptionParser.parse do |parser|
    parser.banner = "Welcome to Tic-tac-toe!"

    parser.on "-s", "--single", "Single player game" do
      puts "Single player mode is is still being worked on."
      puts "Try two player mode instead."
      exit
    end

    parser.on "-t", "--two", "Two player game" do
      game.two_player
    end

    parser.on "-v", "--version", "Show version" do
      puts "Version 0.1.0"
      exit
    end

    parser.on "-h", "--help", "Show help" do
      puts parser
      exit
    end
  end
end

struct Game
  property board = Board.new
  property result = Result::None

  def two_player
    # board = Board.new
    until over
      board.print
      puts "\n"
      puts "Enter Player 1's move (X):"
      board.handle_move('X')
      board.print
      break if over
      puts "\n"
      puts "Enter Player 2's move (O):"
      board.handle_move('O')
    end
    puts "\n----------\n"
    puts "GAME OVER"

    case result
    when .tie?
      puts "Game is tied."
    when .x?
      puts "Player 1 wins!"
    when .o?
      puts "Player 2 wins!"
    end
  end

  def over
    @result = Result::Tie if board.full
    # Implement win/loss logic
    return @result != Result::None
  end
end

class Board
  property data = [
    [' ', ' ', ' '],
    [' ', ' ', ' '],
    [' ', ' ', ' '],
  ]
  property columns = ['A', 'B', 'C']
  property rows = ['1', '2', '3']

  def print
    curr_board = "    "

    i = 0
    while i < @columns.size
      curr_board += @columns[i]
      curr_board += "   " if i < @columns.size - 1
      i += 1
    end

    curr_board += "\n   -----------\n"

    i = 0
    while i < @data.size
      curr_board += @rows[i] + " | "
      j = 0
      while j < @data[i].size
        curr_board += @data[i][j]
        curr_board += " | " if j < @data[i].size - 1
        j += 1
      end

      curr_board += "\n  | ----------\n" if i < @data.size - 1
      i += 1
    end

    puts curr_board
  end

  def handle_move(symbol)
    orig_input = gets

    if orig_input.nil? || orig_input.empty?
      print_error(orig_input)
      handle_move(symbol)
      return
    elsif orig_input.strip.size != 2
      exit if orig_input.strip.downcase == "exit"
      print_error(orig_input)
      handle_move(symbol)
      return
    end

    input = orig_input.strip.upcase

    first_char = input[0]
    second_char = input[1]

    has_valid_letter = false
    has_valid_number = false

    row = nil
    col = nil

    if first_char.ascii_letter?
      has_valid_letter = first_char.in_set?("A-C")
      has_valid_number = second_char.in_set?("1-3")
      if has_valid_letter && has_valid_number
        row = second_char.to_i
        col = (first_char.ord - 64).to_i
      end
    elsif first_char.ascii_number?
      has_valid_number = first_char.in_set?("1-3")
      has_valid_letter = second_char.in_set?("A-C")
      if has_valid_letter && has_valid_number
        row = first_char.to_i
        col = (second_char.ord - 64).to_i
      end
    end

    if has_valid_letter && has_valid_number && !row.nil? && !col.nil? && cell_is_open(row, col)
      move(row, col, symbol)
      return true
    else
      print_error(orig_input)
      handle_move(symbol)
    end
  end

  def print_error(input)
    puts "Input \"#{input}\" is invalid. Please try again."
    puts "Examples of valid coordinates: a2, c1, 3B, etc."
  end

  def cell_is_open(row, col)
    return false if row.nil? || col.nil?
    return @data[row - 1][col - 1] == ' '
  end

  def move(row, col, symbol)
    @data[row - 1][col - 1] = symbol
  end

  def full
    empty_cells = 9
    row = 0
    while row < 3
      col = 0
      while col < 3
        empty_cells -= 1 if @data[row][col] != ' '
        col += 1
      end
      row += 1
    end
    return empty_cells == 0
  end
end

enum Result
  None
  Tie
  X
  O
end
