class ReviewsController < ApplicationController
  before_action :set_run, only: [:new, :create, :index]
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @reviews = policy_scope(@run.reviews).order(created_at: :desc)
  end

  def new
    @review = Review.new
    authorize @review
  end

  def create
    @review = Review.new(review_params)
    @review.run_id = @run.id
    @review.user_id = current_user.id
    authorize @review
    if @review.save
      redirect_to run_path(@run)
    else
      render :new
    end
  end

  def show
    @review = Review.find(params[:id])
    authorize @review
    @run = Run.find(@review.run_id)
  end

  def edit
    @review = Review.find(params[:id])
    authorize @review
  end

  def update
    @review = Review.find(params[:id])
    authorize @review
    @review.update(review_params)
    redirect_to review_path(@review)
  end

  def destroy
    @review = Review.find(params[:id])
    authorize @review
    @review.destroy
  end

  private

  def set_run
    @run = Run.find(params[:run_id])
  end

  def review_params
    params.require(:review).permit(:punctuality)
  end
end
