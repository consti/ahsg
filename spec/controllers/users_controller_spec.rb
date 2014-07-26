require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  subject { User.make! }
  before(:each){ sign_in subject }
  describe "GET show" do
    it "returns http success" do
      get :show, id: subject
      expect(response).to be_success
    end
  end

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to be_success
    end
  end

end
