# encoding: utf-8

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
                    tv_program = TvProgram::TvProgram.new(
                        on_air_date: movie_node.at_xpath("span[contains(@class, 'g_day')]").text,
                        title_ja: data_block.at_xpath("h3/span[@class='jp']").text,
                        title: data_block.at_xpath("h3/span[contains(@class, 'en')]").text ,
                        released_year: year_country[0],
                        released_country: year_country[1],
                        leading_actor: data_block.xpath("div/div/div[1]/span[2]").text,
                        supporting_actor: data_block.xpath("div/div/div[2]/span[2]").text
                    )
                end
            end
        end
    end
end
