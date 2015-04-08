require 'boards/three_by_three_board'
require 'boards/four_by_four_board'

class BoardTypeFactory
  def create(side_size)
    case side_size
    when 3 then ThreeByThreeBoard.new
    when 4 then FourByFourBoard.new
    end
  end
end