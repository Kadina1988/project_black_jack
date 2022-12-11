class Deck
  H_RANK = %w[10 J Q K]
  S_RANK = %w[A 2 3 4 5 6 7 8 9]
  SUITS = ['<3', '^', '<>', '+']

  attr_reader :deck_cards

  def initialize
    @deck_cards = []
    create_high_deck
    crate_slow_deck
  end

  def create_high_deck
    SUITS.each do |suit|
      H_RANK.each do |rank|
        @deck_cards << Card.new(rank, suit, 10)
      end
    end
  end

  def crate_slow_deck
    SUITS.each do |suit|
      S_RANK.each_with_index do |rank, i|
        @deck_cards << Card.new(rank, suit, i + 1)
      end
    end
  end
end
