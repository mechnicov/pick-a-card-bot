class Deck
  VALUES = %w(2⃣ 3⃣ 4⃣ 5⃣ 6⃣ 7⃣ 8⃣ 9⃣ 🔟 👨 👰 🤴 🅰).freeze
  SUITS = %w(♠ ♥ ♦ ♣).freeze

  attr_reader :cards

  def initialize
    @cards = []

    VALUES.each do |value|
      SUITS.each do |suit|
        cards << Card.new(value, suit)
      end
    end

    2.times { cards << Card.new(nil, nil, true) }
  end

  def shuffle
    cards.shuffle!
    self
  end
end
