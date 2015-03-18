require 'main'

RSpec.describe "Integration" do
  def format_for_stdin(commands)
    commands.push("").join("\n")
  end

  class Allways0Random
    def rand
      0.0
    end
  end

  def run_game(commands)
    input = StringIO.new format_for_stdin commands
    output = StringIO.new
    Main.new(input, output, Allways0Random.new).run
    output.string
  end

  describe "full game with 3x3 board between two humans" do
    it "should have announced the winner" do
      expect(run_game %w(3 hvh 0,0 1,0 0,1 1,1 0,2 n)).to include("X has won!")
    end
  end
  
  describe "two full games with 3x3 board between two humans" do
    it "should have announced the winner of the second game" do
      commands = %w(3 hvh 0,0 1,0 0,1 1,1 0,2 y 3 hvh 0,0 1,0 0,1 1,1 2,0 1,2 n)
      expect(run_game commands).to include("O has won!")
    end
  end

  describe "full game with 3x3 board between human and computer" do
    it "should have announced the winner" do
      expect(run_game %w(3 hvc 2,0 2,1 2,2 n)).to include("X has won!")
    end
  end
end