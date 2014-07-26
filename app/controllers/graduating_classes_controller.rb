class GraduatingClassesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @graduating_classes = GraduatingClass.all
  end

  def show
    @graduating_class = GraduatingClass.find_by(year: params[:year]).decorate
    @users = @graduating_class.users
  end
end
