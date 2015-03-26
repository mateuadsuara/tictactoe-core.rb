require 'coordinator'
require 'cli'
require 'state'
require 'play_again_option'
require 'board_type_option'
require 'players_option'

class Main
  def initialize(input=$stdin, output=$stdout)
    @output = output
    @play_again = PlayAgainOption.new(input, output)
    @board_type = BoardTypeOption.new(input, output)
    @who_will_play = PlayersOption.new(input, output)
  end

  def run
    begin 
      engine = create_game_engine
      engine.start
      engine.step until engine.finished?
    end while play_again.ask
  end

  private
  attr_accessor :output, :play_again, :board_type, :who_will_play

  def create_game_engine
    board = board_type.ask
    players = who_will_play.ask
    Coordinator.new(
      State.new(board),
      Cli.new(output),
      players
    )
  end
end
