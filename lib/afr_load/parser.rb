# encoding: utf-8

require "afr_load/tv_program"

module AfrLoad
  module Parser
    class << self
      def parse(document)
        month_lineup_doc = get_month_lineup(document)
        month_lineup_doc.map do |lineup|
          parse_month_lineup(lineup)
        end
      end

      def get_month_lineup(document)
        document.xpath("//div[@id='contents']/div").select do |contents_child|
          is_month_lineup(contents_child)
        end
      end

      def is_month_lineup(contents_child)
        return false if contents_child.attribute("id") == nil
        if contents_child.attribute("id").value =~ /[0-9]{6}/
          true
        else
          false
        end
      end

      def parse_month_lineup(contents_child)
        contents_child.xpath("//div/div[@class='gogo_item']").map do |movie_node|
          data_block = movie_node.at_xpath("div[contains(@class, 'g_data_block')]")
          year_country = data_block.at_xpath("div/span[@class='g_country_year']").text.split("◆")
          performer = data_block.xpath("div/div/div[2]/span[2]").text
          tv_program = TvProgram.new do |info|
            #<div class="gogo_item" data-oaStart="2017053113350000" data-oaEnd="2017053115400000">
            info.on_air_start = movie_node.get("data-oaStart")
            info.on_air_end = movie_node.get("data-oaEnd")
            info.on_air_date = movie_node.at_xpath("span[contains(@class, 'g_day')]").text
            info.title_ja = data_block.at_xpath("h3/span[@class='jp']").text
            info.title = data_block.at_xpath("h3/span[contains(@class, 'en')]").text
            info.released_year = year_country[0]
            info.released_country = year_country[1]
            info.movie_director = data_block.xpath("div/div/div[1]/span[2]").text
            info.leading_actor = performer.split("／")[0]
            info.supporting_actor = performer.split("／")[1]
          end
        end
      end
    end
  end
end
