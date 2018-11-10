require 'rate_parser'
require 'net/http'
require 'uri'
require 'rexml/document'

describe RateParser do
  describe '.parse_xml_by_url' do
    doc = RateParser.parse_xml_by_url

    it 'returns parsed xml document' do
      expect(doc).to be_an_instance_of(REXML::Element)
    end
  end

  describe '.return_current_course' do
    selected_currency = :usd
    rate = RateParser.return_current_course(selected_currency)

    it 'returns current course' do
      expect(rate).to be_an_instance_of(Float)
    end
  end
end