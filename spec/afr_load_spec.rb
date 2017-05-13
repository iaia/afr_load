require 'spec_helper'
require "pathname"

describe AfrLoad do
  FILE_PATH = Pathname.new(File.dirname(__FILE__)).join("./index2.html").to_s
  FILE_PATH4 = Pathname.new(File.dirname(__FILE__)).join("./index4.html").to_s
  it 'has a version number' do
    expect(AfrLoad::VERSION).not_to be nil
  end

  context "index2" do
    it 'index2' do
      afr = AfrLoad::AfrLoad.new() do |info|
        info.url = FILE_PATH
      end
      afr.get_schedule
      afr.get_program
    end
  end

  context "index4" do
    it 'index4' do
      afr = AfrLoad::AfrLoad.new() do |info|
        info.url = FILE_PATH4
      end
      afr.get_schedule
      afr.get_program
    end
  end

  context "integration2" do
    it 'integration2' do
      programs = AfrLoad::AfrLoad.get_schedule()
      expect(programs).not_to eq ""
      programs.each do |program|
        program.show()
      end
    end
  end

end
