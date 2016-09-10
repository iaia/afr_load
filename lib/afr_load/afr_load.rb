# encoding: utf-8

require "oga"
require "httpclient"

module AfrLoad
    class AfrLoad
        attr_reader :programs

        AFR_LOAD_URL = "http://www.tv-tokyo.co.jp/telecine/oa_afr_load/"

        def initialize()
            @programs = Array.new()
        end
        def self.get_schedule()
            afr = self.new()
            afr.get_schedule()
            return afr.programs
        end
        def afr_load(file_path)
            if file.blank?
                document = get_schedule()
            else
                document = get_schedule_from_file(file_path)
            end
            parse(document)
        end
        def get_schedule()
            enum = Enumerator.new do |yielder|
                HTTPClient.get(AFR_LOAD_URL) do |chunk|
                    yielder << chunk.force_encoding("utf-8")
                end
            end
            document = Oga.parse_html(enum)
            parse(document)
            return document
        end
        def get_schedule_from_file(file_path)
            handler = File.open(file_path)
            document = Oga.parse_html(handler)
            parse(document)
            return document
        end
        def parse(document)
            document.xpath("//div[@id='contents']/div").each do |contents_child|
                if contents_child.attribute("id") == nil
                    next
                end
                if not contents_child.attribute("id").value =~ /[0-9]{6}/
                    next
                end
                # gogo_item
                contents_child.xpath("//div/div[@class='gogo_item']").each do |movie_node|
                    movie = Hash.new()
                    movie.store("on_air_date", movie_node.at_xpath("span[contains(@class, 'g_day')]").text)
                    data_block = movie_node.at_xpath("div[contains(@class, 'g_data_block')]")

                    movie.store("title_ja", data_block.at_xpath("h3/span[@class='jp']").text)
                    movie.store("title", data_block.at_xpath("h3/span[contains(@class, 'en')]").text)

                    year_country = data_block.at_xpath("div/span[@class='g_country_year']").text.split("◆")
                    movie.store("released_year", year_country[0])
                    movie.store("released_country", year_country[1])

                    movie.store("leading_actor", data_block.xpath("div/div/div[1]/span[2]").text)
                    movie.store("supporting_actor", data_block.xpath("div/div/div[2]/span[2]").text)
                    @programs.push(movie)
                end
            end
        end
    end
end

