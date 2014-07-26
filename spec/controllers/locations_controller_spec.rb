require 'rails_helper'

RSpec.describe LocationsController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to be_success
    end
  end

  describe "GET show" do
    let(:location){ Location.make! }
    it "returns http success" do
      get :show, id: location
      expect(response).to be_success
    end
  end

end
