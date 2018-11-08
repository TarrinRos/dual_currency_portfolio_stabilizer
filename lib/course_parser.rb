require 'net/http'
require 'uri'
require 'rexml/document'

class CourseParser
  VALUTES = {'Евро' => 'R01239', 'Доллар США' => 'R01235'}
  VALUTES_SYMBOL = {'Евро' => '€', 'Доллар США' => '$'}

  def self.parse_xml_by_url
    uri = URI.parse("http://www.cbr.ru/scripts/XML_daily.asp")

    response = Net::HTTP.get_response(uri)

    REXML::Document.new(response.body).elements['ValCurs']
  end

  def self.return_valutes_list
    VALUTES.keys.sort
  end

  def self.return_current_course(selected_valute)
    node = self.parse_xml_by_url

    # Проходит по ноде курсов и и возвращает курс, введенной пользователем валюты
    node.each_element_with_attribute('ID', "#{VALUTES[selected_valute]}") do |e|
      @course = e.elements['Value'].text.gsub(/,/, '.').to_f
    end
    @course
  end

  def self.return_valutes_symbol(selected_valute)
    VALUTES_SYMBOL[selected_valute]
  end
end