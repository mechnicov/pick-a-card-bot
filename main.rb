require 'telegram/bot'
require 'dotenv/load'
require_relative 'lib/card'
require_relative 'lib/deck'

TOKEN = ENV['TELEGRAM_BOT_API_TOKEN'].freeze
HOW_MANY = ENV['HOW_MANY'].freeze
NEW_DECK = ENV['NEW_DECK'].freeze
WRONG_INPUT = ENV['WRONG_INPUT'].freeze
LEFT_CARDS = ENV['LEFT_CARDS'].freeze
EMPTY_DECK = ENV['EMPTY_DECK'].freeze
HERE_YOU_ARE = ENV['HERE_YOU_ARE'].freeze

cards = []

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    if message.text == '/start'
      deck = Deck.new.shuffle
      cards = deck.cards
      bot.api.send_message(chat_id: message.chat.id, text: "#{NEW_DECK} #{HOW_MANY}")
    else
      if message.text.to_i <= 0 && cards.any?
        bot.api.send_message(chat_id: message.chat.id, text: "#{WRONG_INPUT} #{HOW_MANY}")
      else
        number = message.text.to_i
        if number <= cards.count
          number.times { bot.api.send_message(chat_id: message.chat.id, text: cards.pop) }
          bot.api.send_message(chat_id: message.chat.id, text: "#{HOW_MANY} #{cards.size} #{LEFT_CARDS}") if cards.any?
        else
          bot.api.send_message(chat_id: message.chat.id, text: "#{cards.size} #{LEFT_CARDS} #{HERE_YOU_ARE}") if cards.any?
          cards.size.times { bot.api.send_message(chat_id: message.chat.id, text: cards.pop) }
        end
      end
    bot.api.send_message(chat_id: message.chat.id, text: EMPTY_DECK) if cards.empty?
    end
  end
end
