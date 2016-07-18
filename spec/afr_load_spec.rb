require 'spec_helper'

describe AfrLoad do
    it 'has a version number' do
        expect(AfrLoad::VERSION).not_to be nil
    end

    it 'does something useful' do
        afr = AfrLoad::AfrLoad.new()
        #afr.get_schedule()
        #afr.test

        afr.get_schedule("/Users/iaia/work/src/ruby/gems/afr_load/lib/afr_load/afr_load.html")
        afr.test

        expect(afr).not_to be nil
    end
end
