require 'spec_helper'

describe AfrLoad do
    before do
        @afr = AfrLoad::AfrLoad.new()
    end

    it 'has a version number' do
        expect(AfrLoad::VERSION).not_to be nil
    end

    context "" do
        it 'get schedule' do
            document = @afr.get_schedule()
            expect(document).not_to be nil
        end

    end

    context "parser" do
        before do
            @afr = AfrLoad::AfrLoad.new()
            @afr.get_schedule()
        end
        it "get month lineup" do
            month_lineup = AfrLoad::Parser::Parser.get_month_lineup(@afr.document)
            expect(month_lineup.length).not_to eq 0
        end

        it "parse month lineup" do
            month_lineup = AfrLoad::Parser::Parser.get_month_lineup(@afr.document)
            programs = Array.new()
            month_lineup.each do |lineup|
                programs.push(AfrLoad::Parser::Parser.parse_month_lineup(lineup))
            end
            expect(programs.length).not_to eq 0
        end

        it 'can parse' do
            programs = AfrLoad::Parser::Parser.parse(@afr.document)
            expect(programs.length).not_to eq 0
        end
    end

    context "integration" do
        it 'integration' do
            programs = AfrLoad::AfrLoad.get_schedule()
            expect(programs).not_to eq ""
            p programs
        end
    end
end
