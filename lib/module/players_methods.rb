module PlayersMeth

  MAX_POINT = 21
  MAX_ACE = 11
  MIN_ACE = 1
  ADD_A = 10

  def bank_zero?
    @bank.zero?
  end

  def checking_cards
    card_with_a
  end

  private

  def card_with_a
    if (@cards[0].rank == 'A' || @cards[1].rank == 'A') || ((@cards.size == 3) && ( @cards[0].rank == 'A' || @cards[1].rank == 'A' || @cards[2].rank == 'A'))
      score_points
      ace_value
      score_points
    else
       score_points
    end
  end

  def score_points
    @points = @cards[0].point + @cards[1].point if @cards.size == 2
    @points = @cards[0].point + @cards[1].point + @cards[2].point if @cards.size == 3
    @points
  end

  def ace_value
    if @points + ADD_A < MAX_POINT
      ace = @cards.find_all { |card| card.rank == 'A' }
      ace[0].point = MAX_ACE
    elsif @points + ADD_A >= MAX_POINT
      ace = @cards.find_all { |card| card.rank == 'A' }
      ace[0].point = MIN_ACE
    end
  end
end
