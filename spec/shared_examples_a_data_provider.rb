require 'spec_helper'

shared_examples "a data provider" do
  let(:data_provider) { described_class.new() }

  it { should belong_to(:user) }

  describe "#provides_data_for" do
    context "with data types provided to #data_provider_for" do
      before do
        @provides_data_for = described_class.provides_data_for
        described_class.data_provider_for :a, :b, :c
      end

      it "returns the same data types" do
        expect(data_provider.provides_data_for).to eq([:a, :b, :c])
      end

      after do
        described_class.data_provider_for *@provides_data_for
      end
    end
  end

  describe "#data_provider_for" do
    context "with data types provided" do
      before do
        @provides_data_for = described_class.provides_data_for
        described_class.data_provider_for :a, :b, :c
      end

      it "assigns data types to provides_data_for attribute" do
        expect(data_provider.provides_data_for).to eq([:a, :b, :c])
      end

      after do
        described_class.data_provider_for *@provides_data_for
      end
    end
  end

  describe "#sync" do
    it "updates synced_at stamp" do
      expect(data_provider.save).to_not eq(nil)
    end
  end
end
