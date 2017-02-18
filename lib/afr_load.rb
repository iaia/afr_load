# encoding: utf-8

require "oga"
require "httpclient"

require "afr_load/version"
require "afr_load/parser.rb"

module AfrLoad
    class AfrLoad
        attr_reader :url, :programs, :document

        AFR_LOAD_URL = "http://www.tv-tokyo.co.jp/telecine/oa_afr_load/"

        def initialize(url = AFR_LOAD_URL)
            @programs = Array.new()
            @url = url
        end

        def get_schedule()
            @document = self.class.fetch_schedule(@url)
            get_program()
        end

        def self.get_schedule(url = AFR_LOAD_URL)
            afr = self.new(url)
            afr.get_schedule()
        end

        def get_schedule_from_file(file_handler)
            @document = Oga.parse_html(file_handler)
        end

        def get_program
            @programs = Parser.parse(@document).flatten
        end

        def self.fetch_schedule(url = AFR_LOAD_URL)
            Oga.parse_html(Enumerator.new do |yielder|
                HTTPClient.get(url) do |chunk|
                    yielder << chunk.force_encoding("utf-8")
                end
            end)
        end
    end
end
