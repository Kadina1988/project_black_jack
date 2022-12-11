require_relative 'module/players_methods'

class Dealer
  include PlayersMeth

  attr_accessor :bank, :cards, :points

  def initialize
    @bank = 100
    @cards = []
    @points = 0
  end
end
