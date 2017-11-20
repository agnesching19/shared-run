class RunsController < ApplicationController
  before_action :set_run, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @runs = policy_scope(Run).where.not(latitude: nil, longitude: nil).order(created_at: :desc)
  end

  def show
    authorize @run
    @run = Run.new
  end

  @hash = Gmaps4rails.build_markers(@run) do |run, marker|
    marker.lat run.latitude
    marker.lng run.longitude
  end

  def new
    @run = Run.new
    authorize @run
  end

  def create
    @run = Run.new(run_params)
    @run.user = current_user
    authorize @run
    if @run.save
      redirect_to run_path(@run)
    else
      render :new
    end
  end

  def edit
    authorize @run
    if @run.update(run_params)
      redirect_to run_path(@run)
    else
      render :edit
    end
  end

  def destroy
    authorize @run
    @run.destroy
    redirect_to runs_path
  end

  private

  def run_params
    params.require(:run).permit(:location, :date, :description, :distance, :capacity, :photo, :shared)
  end

  def set_run
    @run = Run.find(params[:id])
  end
end
