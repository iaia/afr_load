# encoding: utf-8

require "oga"
require "httpclient"

require "bundler"
Bundler.require(:default, :development)
require "afr_load/version"
require "afr_load/parser.rb"

module AfrLoad
  class AfrLoad
    AFR_LOAD_URL = "http://www.tv-tokyo.co.jp/telecine/oa_afr_load/"

    attr_accessor :url 
    attr_reader :programs, :document

    def initialize()
      @url = AFR_LOAD_URL
      @programs = Array.new()
      yield(self) if block_given?
    end

    def self.get_schedule()
      afr = self.new()
      afr.get_schedule()
      afr.get_program()
    end

    def get_schedule()
      if @url.start_with?("http")
        body = HTTPClient.get(@url).body.force_encoding("utf-8")
      else
        body = File.open(@url).read
      end
      @document = Oga.parse_html(body)
    end

    def get_program
      @programs = Parser.parse(@document).flatten
    end
  end
end
