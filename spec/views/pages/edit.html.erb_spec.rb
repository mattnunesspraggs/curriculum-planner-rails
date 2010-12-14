require 'spec_helper'

describe "pages/edit.html.erb" do
  before(:each) do
    @page = assign(:page, stub_model(Page,
      :new_record? => false,
      :title => "MyString",
      :author => nil,
      :slug => "MyString",
      :content => "MyText",
      :tags => "MyString"
    ))
  end

  it "renders the edit page form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => page_path(@page), :method => "post" do
      assert_select "input#page_title", :name => "page[title]"
      assert_select "input#page_author", :name => "page[author]"
      assert_select "input#page_slug", :name => "page[slug]"
      assert_select "textarea#page_content", :name => "page[content]"
      assert_select "input#page_tags", :name => "page[tags]"
    end
  end
end
