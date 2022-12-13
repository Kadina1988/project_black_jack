require_relative  'player'
require_relative  'deck'
require_relative  'dealer'
require_relative 'card'
require_relative 'module/players_methods'
require_relative 'bank.rb'

class Game

  BET = 10
  MONEY_BANK = 20

  attr_reader :bank, :player, :dealer, :deck

  def initialize
    @dealer = Dealer.new
    @player = User.new
    @deck   = Deck.new.deck_cards
    @bank   = Bank.new
  end

  def start
    print 'Введите имя: '
    @name = gets.chomp.capitalize
    start_game
    loop do
      menu
      @choice = met_choice
      break if @choice.zero?

      process_choice
    end
  end

  def menu
    puts 'Menu'
    puts '1.Пропустить ход'
    puts '2.Добавить карту'
    puts '3.Открыть карты'
    puts '0.Выход'
  end

  def met_choice
    gets.chomp.to_i
  end

  def process_choice
    case @choice
    when 1 then miss
    when 2 then add_card
    when 3 then open_cards
    end
  end

  def start_game
    exit if @player.bank_zero? || @dealer.bank_zero?
    @player.bank -= BET
    @dealer.bank -= BET
    @bank.money  += MONEY_BANK
    @deck.shuffle!
    @player.cards << @deck.shift << @deck.shift
    @dealer.cards << @deck.shift << @deck.shift
    @player.checking_cards
    @dealer.checking_cards
    puts "#{show_cards_pl} Points: #{@player.points}; Dealer: *,*"
  end

  def miss
    dealer_plays
  end

  def add_card
    return puts 'У вас достаточно карт' if @player.cards.size == 3

    @player.cards << @deck.shift
    dealer_plays
    open_cards if @player.cards.size == 3 && @dealer.cards.size == 3
    @player.checking_cards
  end

  def open_cards
    @player.checking_cards
    @dealer.checking_cards
    show_cards_pl
    show_cards_d
    puts "#{@name} points: #{@player.points}"
    puts "Dealer points: #{@dealer.points}"
    game_result
    method_end
  end

  private

  attr_writer :name

  def show_cards_pl
    print "#{@name}: "
    if @player.cards.size == 2
      puts "#{@player.cards[0].rank}#{@player.cards[0].suit} #{@player.cards[1].rank}#{@player.cards[1].suit}"
    end
    if @player.cards.size == 3
      puts "#{@player.cards[0].rank}#{@player.cards[0].suit} #{@player.cards[1].rank}#{@player.cards[1].suit} #{@player.cards[2].rank}#{@player.cards[2].suit}"
    end
  end

  def show_cards_d
    print 'Dealer: '
    if @dealer.cards.size == 2
      puts "#{@dealer.cards[0].rank}#{@dealer.cards[0].suit} #{@dealer.cards[1].rank}#{@dealer.cards[1].suit}"
    end
    if @dealer.cards.size == 3
      puts "#{@dealer.cards[0].rank}#{@dealer.cards[0].suit} #{@dealer.cards[1].rank}#{@dealer.cards[1].suit} #{@dealer.cards[2].rank}#{@dealer.cards[2].suit}"
    end
  end

  def dealer_plays
    return if @dealer.cards.size == 3
    puts 'Ход Диллера'
    sleep(1)
    if @dealer.points < 17
      @dealer.cards << @deck.shift
      puts 'Диллер взял карту'
    else
      puts 'Диллер пропустил ход'
    end
  end

  def return_cards_deck
    numb_cards_pl = @player.cards.size
    numb_cards_d  = @dealer.cards.size
    numb_cards_pl.times { @deck << @player.cards.pop }
    numb_cards_d.times  { @deck << @dealer.cards.pop }
  end

  def method_end
    puts 'Хотите сыграть еще?(y/n)'
    ans = gets.chomp
    if ans == 'y'
      return_cards_deck
      start_game
    else
      exit
    end
  end

  def game_result
    if ((@player.points > @dealer.points) && @player.points < 21) || (@dealer.points >= 21 && @player.points < 21)
      @player.bank += @bank.money
      @bank.money = 0
      puts "#{@name} win.Bank #{@player.bank}$"
    elsif (@player.points == @dealer.points) || (@player.points > 21 && @dealer.points > 21)
      @player.bank += 0.5 * @bank.money
      @dealer.bank += 0.5 * @bank.money
      @bank = 0
      puts "Draw.Bank #{@player.bank}$"
    elsif ((@dealer.points > @player.points) && @dealer.points < 21) || (@player.points >= 21 && @dealer.points < 21)
      @dealer.bank += @bank.money
      @bank.money = 0
      puts "#{@name} loose.Bank #{@player.bank}$ "
    end
  end
end
