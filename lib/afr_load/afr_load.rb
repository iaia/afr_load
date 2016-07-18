# encoding: utf-8
require 'oga'
require 'httpclient'
Encoding.default_internal = "UTF-8"

module AfrLoad
    class AfrLoad
        AFR_LOAD_URL = "http://www.tv-tokyo.co.jp/telecine/oa_afr_load/"
        @programs = Array.new()
        def initialize()
        end

        def get_schedule(file_path = "")
            if file_path == "" 
                enum = Enumerator.new do |yielder|
                    HTTPClient.get(AFR_LOAD_URL) do |chunk|
                        yielder << chunk.force_encoding("utf-8")
                    end
                end
                @document = Oga.parse_html(enum)
            else
                puts file_path
                handler = File.open(file_path)
                @document = Oga.parse_html(handler)
            end
        end
        def test
            movies_node = @document.xpath("//div[@id='contents']/div/table/tbody/tr/td/div/table/tbody")
            movie_list = Array.new()
            movies_node.each do |tbody|
                movie = Hash.new()
                #p "############ movie"
                tds = tbody.xpath("tr")[1].xpath("td/p")
                result = text_plastic(tds[0].text)
                result = result.split("\n").compact.reject(&:empty?)
                movie.store("日付", result[0])
                movie.store("時間", result[1])
                movie.store("HD", result[2])
                movie.store("邦題", result[-2])
                movie.store("原題", result[-1])
                result = text_plastic(tds[1].text)
                result = result.split("\n").compact.reject(&:empty?)
                movie.store("公開時期", result[0].split("　")[0])
                movie.store("製作国", result[0].split("　")[1])
                result = text_plastic(tds[2].text)
                result = result.split("\n").compact.reject(&:empty?)
                movie.store("監督", result[0].gsub("（監督） ", ""))
                movie.store("主演", result[1].gsub("（出演） ", ""))
                movie.store("助演", result[2])
                movie_list.push(movie)
            end
        end
        def text_plastic(text)
            result = ""
            text.each_line do |line|
                line = line.gsub("  ", "")
                result += line.gsub("             ", "")
            end
            return result
        end
    end
end
