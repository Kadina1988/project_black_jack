module PlayersMeth
  def bank_zero?
    @bank.zero?
  end

  def checking_cards
    case @cards.size
    when 2 then cards_2
    when 3 then cards_3
    end
  end

  # private

  def score_points
    @points = @cards[0].point + @cards[1].point if @cards.size == 2
    @points = @cards[0].point + @cards[1].point + @cards[2].point if @cards.size == 3
    @points
  end

  def ace_value
    if @points + 10 < 21
      ace = @cards.find_all { |card| card.rank == 'A' }
      ace[0].point = 11
    elsif @points + 10 >= 21
      ace = @cards.find_all { |card| card.rank == 'A' }
      ace[0].point = 1
    end
  end

  def cards_2
    if @cards[0].rank == 'A' || @cards[1].rank == 'A'
      score_points
      ace_value
      score_points
    else
      score_points
    end
  end

  def cards_3
    if @cards[0].rank == 'A' || @cards[1].rank == 'A' || @cards[2].rank == 'A'
      score_points
      ace_value
      score_points
    else
      score_points
    end
  end
end
