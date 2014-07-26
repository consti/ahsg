class LocationsController < ApplicationController
  def index
    @locations = Location.includes(:users).all
  end

  def show
    @location = Location.includes(:users).find(params[:id]).decorate
  end
end
