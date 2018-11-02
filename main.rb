# Lesson36, task3
# ========================================
# Стабилизатор бивалютной корзины 50/50 v2
# ========================================

require_relative 'lib/course_parser'
require_relative 'lib/stabilizer'
require 'rexml/document'

VALUTES = {'Евро' => 'R01239', 'Доллар США' => 'R01235'}
VALUTES_SYMBOL = {'Евро' => '€', 'Доллар США' => '$'}
portfolio_params = {'course' => 0, 'currency' => 0, 'rub' => 0, 'symbol' => nil}

url = "http://www.cbr.ru/scripts/XML_daily.asp"

parser = CourseParser.parse_xml_by_url(url)

node = parser.node

# Просит пользователя выбрать валюту
puts 'Выберите, пожалуйста, номер валюты в списке: '

valutes_list = VALUTES.keys.sort

valutes_list.each_with_index {|valute, index| puts "#{index + 1}. #{valute}"}

users_choice = gets.to_i

selected_valute = valutes_list[users_choice - 1]

# Спрашивает сколько у пользователя валюты
puts 'Сколько у Вас валюты?: '

currency = gets.to_f.round(2)

# Спрашивает сколько у пользователя рублей
puts 'Сколько у Вас рублей?: '

rub = gets.to_f.round(2)

#
node.each_element_with_attribute('ID', "#{VALUTES[selected_valute]}") {|e| @course = e.elements['Value'].text}

course = @course.gsub(/,/, '.').to_f
puts
puts "Текущий курс: #{course} зв 1 #{selected_valute}"

# Назначает полученные данные соответствующим ключам хэша параметров
portfolio_params['course'] = course
portfolio_params['currency'] = currency
portfolio_params['rub'] = rub
portfolio_params['symbol'] = VALUTES_SYMBOL[selected_valute]

# Передает классу Стабилизатор хэшш параметров
stabilizer = Stabilizer.new(portfolio_params)

puts stabilizer.result


