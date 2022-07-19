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
    player_one_move = gets
    exit if player_one_move == "exit"
  end
end

class Board
  def initialize
    @data = [
      ['X', 'O', 'X'],
      [' ', ' ', ' '],
      [' ', ' ', ' '],
    ]
    @columns = ['A', 'B', 'C']
    @rows = ['1', '2', '3']
  end

  def print
    curr_board = "    "

    i = 0
    while i < @columns.size
      curr_board += @columns[i] + " "
      i += 1
    end

    curr_board += '\n'

    i = 0
    while i < @data.size
      curr_board += @rows[i] + " [ "
      j = 0
      while j < @data[i].size
        curr_board += @data[i][j] + " "
        j += 1
      end
      curr_board += "]"
      i += 1
      curr_board += "\n"
    end

    puts curr_board
  end
end
