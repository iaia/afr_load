# encoding: utf-8

require "oga"
require "httpclient"

module AfrLoad
    class AfrLoad
        attr_reader :programs, :document

        AFR_LOAD_URL = "http://www.tv-tokyo.co.jp/telecine/oa_afr_load/"

        def initialize()
            @programs = Array.new()
        end

        def self.get_schedule()
            afr = self.new()
            document = afr.get_schedule()
            @programs = Parser::Parser.parse(document)
            @programs
        end

        def get_schedule()
            @document = Oga.parse_html(Enumerator.new do |yielder|
                HTTPClient.get(AFR_LOAD_URL) do |chunk|
                    yielder << chunk.force_encoding("utf-8")
                end
            end)
        end

        def get_schedule_from_file(file_path)
            handler = File.open(file_path)
            document = Oga.parse_html(handler)
        end
    end
end
