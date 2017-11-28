class ReviewsController < ApplicationController
  before_action :set_run, only: [:new, :create]
  before_action :set_user, only: [:index, :new, :create]
  skip_before_action :authenticate_user!, only: [:index, :new, :create]

  def index
    @reviews = policy_scope(Review)
  end

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
      redirect_to run_path(@run), notice: "Thanks for reviewing!"
    else
      redirect_to run_path(@run), alert: "You've already reviewed for this user!"
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
