require 'spec_helper'

describe "measurements/index" do
  before(:each) do
    assign(:measurements, [
      stub_model(Measurement),
      stub_model(Measurement)
    ])
  end

  it "renders a list of measurements" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
