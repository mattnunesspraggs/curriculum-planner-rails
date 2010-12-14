require "spec_helper"

describe OptionsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/options" }.should route_to(:controller => "options", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/options/new" }.should route_to(:controller => "options", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/options/1" }.should route_to(:controller => "options", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/options/1/edit" }.should route_to(:controller => "options", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/options" }.should route_to(:controller => "options", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/options/1" }.should route_to(:controller => "options", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/options/1" }.should route_to(:controller => "options", :action => "destroy", :id => "1")
    end

  end
end
