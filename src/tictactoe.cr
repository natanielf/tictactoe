require "option_parser"

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
      two_player_game()
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

def two_player_game
  board = Board.new
  game_over = false
  until game_over
    board.print
    puts "\n"
    puts "Enter Player 1's move (X):"
    until input_is_valid(input = gets)
      puts "Input \"#{input}\" is invalid. Please try again."
      puts "Examples of valid coordinates: A2, C1, 3B, etc."
    end
  end
end

def input_is_valid(input)
  return false if input.nil? || input.empty?
  exit if input.lstrip.rstrip.downcase == "exit"

  input = input.lstrip.rstrip.upcase
  return false if input.size != 2

  if /[^ABC]/ =~ input
    puts "starts with a letter"
  elsif /[^1-3]/ =~ input
    puts "starts with a number"
  end

  return true
end

def parse_input
end

class Board
  def initialize
    @data = [
      ['X', 'O', 'X'],
      ['O', 'X', 'O'],
      ['X', 'O', 'X'],
    ]
    @columns = ['A', 'B', 'C']
    @rows = ['1', '2', '3']
  end

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
end
