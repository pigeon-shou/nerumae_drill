class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @learnings = @user.learnings
  end
end
