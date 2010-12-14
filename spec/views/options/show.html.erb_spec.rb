require 'spec_helper'

describe "options/show.html.erb" do
  before(:each) do
    @option = assign(:option, stub_model(Option,
      :key => "Key",
      :value => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Key/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end
end
