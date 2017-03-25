# encoding: utf-8

require "oga"
require "byebug"
require "pathname"


FILE_PATH = Pathname.new(File.dirname(__FILE__)).join("./index2.html")
document = Oga.parse_html(File.open(FILE_PATH))

document.xpath("//div/div[@class='gogo_item']").map do |movie_node|
    data_block = movie_node.at_xpath("div[contains(@class, 'g_data_block')]")
    if data_block.nil?
        debugger
    else
        p data_block.at_xpath("h3/span[@class='jp']").text
    end
end


