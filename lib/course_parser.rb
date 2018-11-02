require 'net/http'
require 'uri'
require 'rexml/document'

class CourseParser
  attr_reader :course

  def self.parse_xml_by_url(url)
    uri = URI.parse(url)

    response = Net::HTTP.get_response(uri)

    doc = REXML::Document.new(response.body).elements['ValCurs']
    new(doc)
  end

  def initialize(doc)
    @course = get_course(doc)
  end

  private

  def get_course(doc)
    doc.each_element_with_attribute( 'ID', 'R01235' ) do |e|
      e.elements['Value']
    end
  end
end