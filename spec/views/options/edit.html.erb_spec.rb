require 'spec_helper'

describe "options/edit.html.erb" do
  before(:each) do
    @option = assign(:option, stub_model(Option,
      :new_record? => false,
      :key => "MyString",
      :value => "MyText"
    ))
  end

  it "renders the edit option form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => option_path(@option), :method => "post" do
      assert_select "input#option_key", :name => "option[key]"
      assert_select "textarea#option_value", :name => "option[value]"
    end
  end
end
