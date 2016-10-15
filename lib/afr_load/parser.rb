# encoding: utf-8

module Parser
    def parse_gogo_item(contents_child)
        # gogo_item
        contents_child.xpath("//div/div[@class='gogo_item']").each do |movie_node|
            tv_program = TvProgram::TvProgram.new()
            tv_program.on_air_date = movie_node.at_xpath("span[contains(@class, 'g_day')]").text
            data_block = movie_node.at_xpath("div[contains(@class, 'g_data_block')]")

            tv_program.title_ja =  data_block.at_xpath("h3/span[@class='jp']").text
            tv_program.title =  data_block.at_xpath("h3/span[contains(@class, 'en')]").text 

            year_country = data_block.at_xpath("div/span[@class='g_country_year']").text.split("◆")
            tv_program.released_year = year_country[0]
            tv_program.released_country = year_country[1]

            tv_program.leading_actor = data_block.xpath("div/div/div[1]/span[2]").text
            tv_program.supporting_actor = data_block.xpath("div/div/div[2]/span[2]").text
        end
    end
end
