class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def update
    @review = current_user.reviews.find(params[:id])

    case @review.review_type_id

    when 1
      @review.update(
        review_type_id: 2,
        scheduled_at: 1.day.from_now
      )

    when 2
      @review.update(
        review_type_id: 3,
        scheduled_at: 3.days.from_now
      )

    when 3
      @review.update(
        review_type_id: 4,
        scheduled_at: 7.days.from_now
      )

    when 4
      @review.update(
        review_type_id: 5,
        scheduled_at: Time.current
      )

    end

    head :ok
  end
end