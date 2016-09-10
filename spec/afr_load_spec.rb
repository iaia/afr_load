require 'spec_helper'

describe AfrLoad do
    it 'has a version number' do
        expect(AfrLoad::VERSION).not_to be nil
    end

    context "" do
        let(:afr){ AfrLoad::AfrLoad.new() }
        it 'get schedule' do
            document = afr.get_schedule()
            expect(document).not_to eq ""
        end
        it 'can parse' do
            document = afr.get_schedule()
            afr.parse(document)
            expect(afr.programs.length).not_to eq 0
            p afr.programs
        end
    end
end
