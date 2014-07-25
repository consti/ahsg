class GraduatingClassesController < ApplicationController
  before_filter :authenticate_user!

  def show
    @graduating_class = GraduatingClass.find(params[:id]).decorate
    @users = @graduating_class.users
  end
end
