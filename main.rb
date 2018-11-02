# Lesson36, task3
# ========================================
# Стабилизатор бивалютной корзины 50/50 v2
# ========================================

require_relative 'lib/stabilizer'

VALUTES = {'Евро' => 'R01239', 'Доллар США' => 'R01235'}

url = "http://www.cbr.ru/scripts/XML_daily.asp"

parser = CourseParser.parse_xml_by_url(url)

puts doc.class

# Просит пользователя выбрать валюту
puts 'Выберите, пожалуйста, номер валюты в списке: '

valutes_list = VALUTES.keys.to_a.sort

valutes_list.each_with_index do |valute, index|
  puts "#{index + 1}. #{valute}"
end

selected_valute = gets.to_i

# # # Спрашивает сколько у пользователя рублей
# puts 'Сколько у Вас рублей?: '
#
# rub = gets.to_f.round(2)
#
# # # Спрашивает сколько у пользователя долларов
# puts 'Сколько у Вас долларов?: '
#
# usd = gets.to_f.round(2)
#

