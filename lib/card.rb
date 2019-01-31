class Card
  def initialize(value, suit, joker = false)
    @value = value
    @suit = suit
    @joker = joker
  end

  def to_s
    @joker ? "🤡" : "#{@value} #{@suit}"
  end
end
