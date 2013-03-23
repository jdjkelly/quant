require 'spec_helper'

describe "measurements/show" do
  before(:each) do
    @measurement = assign(:measurement, stub_model(Measurement))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
