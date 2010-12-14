require 'spec_helper'

describe "options/new.html.erb" do
  before(:each) do
    assign(:option, stub_model(Option,
      :key => "MyString",
      :value => "MyText"
    ).as_new_record)
  end

  it "renders new option form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => options_path, :method => "post" do
      assert_select "input#option_key", :name => "option[key]"
      assert_select "textarea#option_value", :name => "option[value]"
    end
  end
end
