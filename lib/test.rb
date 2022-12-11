require_relative  'player'
require_relative  'deck'
require_relative  'dealer'
require_relative 'card'

class Test
  attr_accessor :player, :dealer, :deck

  def initialize
    @dealer = Dealer.new
    @player = User.new
    @deck   = Deck.new.deck_cards
    @bank   = 0
  end

  def start
    @player.cards << @deck[0] << @deck[-9]
  end

  def lol
    @player.checking_cards
  end

  def ss
    @player.score_points_player
    # @player.ace_value
  end

  def del
    @player.cards.delete_at(0)
  end

  def finish
    @player.cards << @deck[-1]
  end

  def point
    @player.points
  end
end
