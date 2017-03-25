require 'spec_helper'
require "pathname"

describe AfrLoad do
    FILE_PATH = Pathname.new(File.dirname(__FILE__)).join("./index2.html").to_s
    it 'has a version number' do
        expect(AfrLoad::VERSION).not_to be nil
    end

    context "integration" do
        it 'integration' do
            afr = AfrLoad::AfrLoad.new() do |info|
                info.url = FILE_PATH
            end
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
