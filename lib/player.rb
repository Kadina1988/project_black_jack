require_relative 'module/players_methods'

class User
  include PlayersMeth

  attr_accessor :cards, :bank, :points

  def initialize
    @bank = 100
    @points = 0
    @cards = []
  end
end
