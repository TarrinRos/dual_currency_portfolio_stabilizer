require 'course_parser'
require 'net/http'
require 'uri'
require 'rexml/document'

describe CourseParser do
  let(:doc) {CourseParser.parse_xml_by_url("http://www.cbr.ru/scripts/XML_daily.asp")}

  describe '.parse_xml_by_url' do
    it 'returns parsed xml document' do
      expect(doc).to be_an_instance_of(CourseParser)
    end
  end
end