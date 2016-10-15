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
            document = afr.get_schedule()
            afr.parse(document)
            return afr.programs
        end
        def afr_load(file_path)
            if file.blank?
                document = get_schedule()
                parse(document)
            else
                document = get_schedule_from_file(file_path)
                parse(document)
            end
        end
        def get_schedule()
            enum = Enumerator.new do |yielder|
                HTTPClient.get(AFR_LOAD_URL) do |chunk|
                    yielder << chunk.force_encoding("utf-8")
                end
            end
            Oga.parse_html(enum)
        end
        def get_schedule_from_file(file_path)
            handler = File.open(file_path)
            document = Oga.parse_html(handler)
        end
        def parse(document)
            document.xpath("//div[@id='contents']/div").each do |contents_child|
                if contents_child.attribute("id") == nil
                    next
                end
                if not contents_child.attribute("id").value =~ /[0-9]{6}/
                    next
                end
                @programs.push(Parser.parse_gogo_item(contents_child))
           end
        end
    end
end

