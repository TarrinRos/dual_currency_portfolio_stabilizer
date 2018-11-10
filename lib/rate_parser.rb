require 'net/http'
require 'uri'
require 'rexml/document'

class RateParser
  CURRENCY = {euro: 'R01239', usd: 'R01235'}
  CURRENCY_SYMBOL = {euro: '€', usd: '$'}

  def self.parse_xml_by_url
    uri = URI.parse("http://www.cbr.ru/scripts/XML_daily.asp")

    response = Net::HTTP.get_response(uri)

    REXML::Document.new(response.body).elements['ValCurs']
  end

  def self.return_valutes_list
    CURRENCY.keys.sort
  end

  def self.return_current_course(selected_currency)
    node = self.parse_xml_by_url

    # Проходит по ноде курсов и и возвращает курс, введенной пользователем валюты
    node.each_element_with_attribute('ID', "#{CURRENCY[selected_currency]}") do |e|
      @rate = e.elements['Value'].text.gsub(/,/, '.').to_f
    end
    @rate
  end
end