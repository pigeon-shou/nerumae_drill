class LearningsController < ApplicationController
  before_action :authenticate_user!
  # before_action :move_to_index, only: [:edit, :update, :destroy]
  def index
    @learnings = current_user.learnings.order(created_at: :desc)
  end

  def new
    @learning = Learning.new
  end

  def create
    @learning = Learning.new(learning_params)
    if @learning.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def learning_params
    params.require(:learning).permit(:content, :keyword).merge(user_id: current_user.id)
  end
end
