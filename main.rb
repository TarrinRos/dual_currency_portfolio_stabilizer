# Lesson36, task3
# ========================================
# Стабилизатор бивалютной корзины 50/50 v2
# ========================================

require_relative 'lib/rate_parser'
require_relative 'lib/stabilizer'
require 'rexml/document'

portfolio_params = {rate: 0, currency: 0, rub: 0}

# Просит пользователя выбрать валюту
puts 'Выберите, пожалуйста, номер валюты в списке: '

# Возвращает виды валюты списком
currency_list = RateParser.return_valutes_list

currency_list.each_with_index { |valute, index| puts "#{index + 1}. #{valute.upcase}" }

users_choice = gets.to_i

if users_choice.between?(1, currency_list.size)
  selected_currency = currency_list[users_choice - 1]

  # Возвращает текущий курс по ЦБ РФ
  rate = RateParser.return_current_course(selected_currency)
else
  abort "Валюты с таким порядковым номером в списке нет"
end

puts "Текущий курс: #{rate} зв 1 #{selected_currency.upcase}"

# Спрашивает сколько у пользователя валюты
puts 'Сколько у Вас валюты?: '

currency_on_hand = gets.to_f.round(2)

# Спрашивает сколько у пользователя рублей
puts 'Сколько у Вас рублей?: '

rub_on_hand = gets.to_f.round(2)

puts

# Назначает полученные данные соответствующим ключам хэша параметров
portfolio_params[:rate] = rate
portfolio_params[:currency] = currency_on_hand
portfolio_params[:rub] = rub_on_hand

# Передает классу Стабилизатор хэшш параметров
stabilizer = Stabilizer.new(portfolio_params)

if stabilizer.result == :balanced
  puts 'Ваша корзина и без того уравновешена.'
elsif stabilizer.result == :sell
  puts "Вам нужно продать: #{RateParser::CURRENCY_SYMBOL[selected_currency]} #{stabilizer.amount}"
else
  puts "Вам нужно докупить: #{RateParser::CURRENCY_SYMBOL[selected_currency]} #{stabilizer.amount}"
end
