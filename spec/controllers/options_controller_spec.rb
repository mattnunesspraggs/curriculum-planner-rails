require 'spec_helper'

describe OptionsController do

  def mock_option(stubs={})
    (@mock_option ||= mock_model(Option).as_null_object).tap do |option|
      option.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all options as @options" do
      Option.stub(:all) { [mock_option] }
      get :index
      assigns(:options).should eq([mock_option])
    end
  end

  describe "GET show" do
    it "assigns the requested option as @option" do
      Option.stub(:find).with("37") { mock_option }
      get :show, :id => "37"
      assigns(:option).should be(mock_option)
    end
  end

  describe "GET new" do
    it "assigns a new option as @option" do
      Option.stub(:new) { mock_option }
      get :new
      assigns(:option).should be(mock_option)
    end
  end

  describe "GET edit" do
    it "assigns the requested option as @option" do
      Option.stub(:find).with("37") { mock_option }
      get :edit, :id => "37"
      assigns(:option).should be(mock_option)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created option as @option" do
        Option.stub(:new).with({'these' => 'params'}) { mock_option(:save => true) }
        post :create, :option => {'these' => 'params'}
        assigns(:option).should be(mock_option)
      end

      it "redirects to the created option" do
        Option.stub(:new) { mock_option(:save => true) }
        post :create, :option => {}
        response.should redirect_to(option_url(mock_option))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved option as @option" do
        Option.stub(:new).with({'these' => 'params'}) { mock_option(:save => false) }
        post :create, :option => {'these' => 'params'}
        assigns(:option).should be(mock_option)
      end

      it "re-renders the 'new' template" do
        Option.stub(:new) { mock_option(:save => false) }
        post :create, :option => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested option" do
        Option.should_receive(:find).with("37") { mock_option }
        mock_option.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :option => {'these' => 'params'}
      end

      it "assigns the requested option as @option" do
        Option.stub(:find) { mock_option(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:option).should be(mock_option)
      end

      it "redirects to the option" do
        Option.stub(:find) { mock_option(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(option_url(mock_option))
      end
    end

    describe "with invalid params" do
      it "assigns the option as @option" do
        Option.stub(:find) { mock_option(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:option).should be(mock_option)
      end

      it "re-renders the 'edit' template" do
        Option.stub(:find) { mock_option(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested option" do
      Option.should_receive(:find).with("37") { mock_option }
      mock_option.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the options list" do
      Option.stub(:find) { mock_option }
      delete :destroy, :id => "1"
      response.should redirect_to(options_url)
    end
  end

end
