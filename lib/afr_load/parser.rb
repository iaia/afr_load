# encoding: utf-8

module AfrLoad
    module Parser
        class Parser
            def self.parse(document)
                month_lineup = get_month_lineup(document)
                programs = Array.new()
                month_lineup.each do |lineup|
                    programs.push(parse_month_lineup(lineup))
                end
                programs
            end
            def self.get_month_lineup(document)
                (Enumerator.new do |month_lineup|
                    document.xpath("//div[@id='contents']/div").each do |contents_child|
                        month_lineup << contents_child if is_month_lineup(contents_child)
                    end
                end).to_a
            end
            def self.is_month_lineup(contents_child)
                return false if contents_child.attribute("id") == nil
                if contents_child.attribute("id").value =~ /[0-9]{6}/
                    true
                else
                    false
                end
            end
            def self.parse_month_lineup(contents_child)
                (Enumerator.new do |programs|
                    contents_child.xpath("//div/div[@class='gogo_item']").each do |movie_node|
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
                        programs << tv_program
                    end
                end).to_a
            end
        end
    end
end
