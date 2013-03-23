require 'spec_helper'

describe "measurements/new" do
  before(:each) do
    assign(:measurement, stub_model(Measurement).as_new_record)
  end

  it "renders new measurement form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", measurements_path, "post" do
    end
  end
end
