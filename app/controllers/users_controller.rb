class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id]).decorate
    @comment = Comment.new(commentable: @user)
  end

  def index
    @users = User.all
  end
end
