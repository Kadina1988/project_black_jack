class Card
  attr_accessor :point
  attr_reader :rank, :suit

  def initialize(rank, suit, point)
    @rank = rank
    @suit = suit
    @point = point
  end
end
