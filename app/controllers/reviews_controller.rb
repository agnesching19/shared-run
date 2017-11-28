class ReviewsController < ApplicationController
  before_action :set_run, only: [:new, :create]
  before_action :set_user, only: [:index, :new, :create]
  skip_before_action :authenticate_user!, only: [:index, :new, :create]

  def new
    @review = Review.new
    authorize @review
  end

  def create
    @review = Review.new(review_params)
    @review.run = @run
    @review.user = current_user
    authorize @review
    if @review.save
      redirect_to dashboard_path(current_user), notice: "Thanks for reviewing!"
      # respond_to do |format|
      #   format.js
      #   format.html {
      #     redirect_to dashboard_path(current_user), notice: "Thanks for reviewing!"
      #   }
    else
      # respond_to do |format|
      # format.html {
      redirect_to dashboard_path(current_user), alert: "You've added a review already!"
      # }
    end
  end

  # def show
  #   @review = Review.find(params[:id])
  #   authorize @review
  #   @run = Run.find(@review.run_id)
  # end

  private

  def set_run
    @run = Run.find(params[:run_id])
  end

  def set_user
    @user = current_user
  end

  def review_params
    params.require(:review).permit(:punctuality)
  end
end
