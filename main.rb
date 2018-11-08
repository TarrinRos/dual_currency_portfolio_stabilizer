# Lesson36, task3
# ========================================
# Стабилизатор бивалютной корзины 50/50 v2
# ========================================

require_relative 'lib/course_parser'
require_relative 'lib/stabilizer'
require 'rexml/document'

portfolio_params = {'course' => 0, 'currency' => 0, 'rub' => 0, 'symbol' => nil}

# Просит пользователя выбрать валюту
puts 'Выберите, пожалуйста, номер валюты в списке: '

# Возвращает виды валюты списком
valutes_list = CourseParser.return_valutes_list

valutes_list.each_with_index {|valute, index| puts "#{index + 1}. #{valute}"}

users_choice = gets.to_i

selected_valute = valutes_list[users_choice - 1]

# Возвращает текущий курс по ЦБ РФ
course =  CourseParser.return_current_course(selected_valute)

puts "Текущий курс: #{course} зв 1 #{selected_valute}"

# Спрашивает сколько у пользователя валюты
puts 'Сколько у Вас валюты?: '

currency = gets.to_f.round(2)

# Спрашивает сколько у пользователя рублей
puts 'Сколько у Вас рублей?: '

rub = gets.to_f.round(2)

puts

# Назначает полученные данные соответствующим ключам хэша параметров
portfolio_params['course'] = course
portfolio_params['currency'] = currency
portfolio_params['rub'] = rub
portfolio_params['symbol'] = CourseParser.return_valutes_symbol(selected_valute)

# Передает классу Стабилизатор хэшш параметров
stabilizer = Stabilizer.new(portfolio_params)

puts stabilizer.result


