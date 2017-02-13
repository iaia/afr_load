require 'spec_helper'

describe AfrLoad do
    it 'has a version number' do
        expect(AfrLoad::VERSION).not_to be nil
    end

    context "" do
        it 'get schedule' do
            document = AfrLoad::AfrLoad.fetch_schedule()
            expect(document).not_to be nil
        end
    end

    context "parser" do
        before do
            @document = AfrLoad::AfrLoad.fetch_schedule()
        end
        it "get month lineup" do
            month_lineup = AfrLoad::Parser.get_month_lineup(@document)
            expect(month_lineup.length).not_to eq 0
        end

        it "parse month lineup" do
            month_lineup = AfrLoad::Parser.get_month_lineup(@document)
            programs = Array.new()
            month_lineup.each do |lineup|
                programs.push(AfrLoad::Parser.parse_month_lineup(lineup))
            end
            expect(programs.length).not_to eq 0
        end

        it 'can parse' do
            programs = AfrLoad::Parser.parse(@document)
            expect(programs.length).not_to eq 0
        end
    end

    context "integration" do
        it 'integration' do
            programs = AfrLoad::AfrLoad.get_schedule()
            expect(programs).not_to eq ""
            programs.each do |program|
                program.show()
            end
        end
    end
end
