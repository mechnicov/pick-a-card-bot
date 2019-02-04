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

cards = {}
decks = {}


begin
  Telegram::Bot::Client.run(TOKEN) do |bot|
    bot.listen do |rqst|
      Thread.start(rqst) do |rqst|
        if rqst.text == '/start'
          decks[rqst.chat.id] = Deck.new.shuffle
          cards[rqst.chat.id] = decks[rqst.chat.id].cards
          bot.api.send_message(chat_id: rqst.chat.id, text: "#{NEW_DECK} #{HOW_MANY}")
        else
          if rqst.text.to_i <= 0 && cards[rqst.chat.id].any?
            bot.api.send_message(chat_id: rqst.chat.id, text: "#{WRONG_INPUT} #{HOW_MANY}")
          else
            number = rqst.text.to_i
            if number <= cards[rqst.chat.id].count
              number.times { bot.api.send_message(chat_id: rqst.chat.id, text: cards[rqst.chat.id].pop) }
              bot.api.send_message(chat_id: rqst.chat.id, text: "#{HOW_MANY} #{cards[rqst.chat.id].size} #{LEFT_CARDS}") if cards[rqst.chat.id].any?
            else
              bot.api.send_message(chat_id: rqst.chat.id, text: "#{cards[rqst.chat.id].size} #{LEFT_CARDS} #{HERE_YOU_ARE}") if cards[rqst.chat.id].any?
              cards[rqst.chat.id].size.times { bot.api.send_message(chat_id: rqst.chat.id, text: cards[rqst.chat.id].pop) }
            end
          end
        bot.api.send_message(chat_id: rqst.chat.id, text: EMPTY_DECK) if cards[rqst.chat.id].empty?
        end
      end
    end
  end
rescue Exception => e
  File.write("#{__dir__}/errors.log", "#{Time.now}\n#{e.message}\n", mode: 'a')
  sleep 60
  retry
end
