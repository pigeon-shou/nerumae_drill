class LearningsController < ApplicationController
  before_action :set_learning, only: [:show, :edit, :update, :destroy,]
  before_action :authenticate_user!
  before_action :move_to_index, only: [:show, :update, :edit, :destroy]
  def index
    @learnings = current_user.learnings.order(created_at: :desc)
  end

  def new
    @learning = Learning.new
  end

  def create
    @learning = Learning.new(learning_params)
    if @learning.save
      Review.create(
      learning_id: @learning.id,
      review_type_id: 2,
      scheduled_at: 1.day.from_now
    )

    Review.create(
      learning_id: @learning.id,
      review_type_id: 3,
      scheduled_at: 3.days.from_now
    )

    Review.create(
      learning_id: @learning.id,
      review_type_id: 4,
      scheduled_at: 7.days.from_now
    )
    redirect_to root_path
    
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @learning.update(learning_params)
      redirect_to user_path(current_user)
    else
      render :edit, status: :unprocessable_entity   
    end
  end

  def destroy
    @learning.destroy
    redirect_to user_path(current_user)
  end

  private

  def move_to_index
    redirect_to root_path unless current_user == @learning.user
  end

  def set_learning
    @learning =current_user.learnings.find(params[:id])
  end 

  def learning_params
    params.require(:learning).permit(:content, :keyword).merge(user_id: current_user.id)
  end
end
