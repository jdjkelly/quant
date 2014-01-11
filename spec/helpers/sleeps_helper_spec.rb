require 'spec_helper'

describe SleepsHelper do
  let(:sleep) { Fabricate(:sleep) }

  describe '.formatted_duration' do
    it 'displays duration in hours' do
      expect(formatted_duration(sleep)).to eq("24.0 hours")
    end

    it 'uses singular in the case of a 1 hour duration' do
      sleep.end = sleep.start + 1.hour
      expect(formatted_duration(sleep)).to eq("1.0 hour")
    end
  end
end
