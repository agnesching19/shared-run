class RunsController < ApplicationController
  before_action :set_run, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_user, only: [:index]

  def index
    @runs = policy_scope(Run).where.not(latitude: nil, longitude: nil).order(created_at: :desc)
    search_run
    set_runs
  end

  def show
    authorize @run
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
  end

  def update
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

  def search_run
    if params[:search].present?
      unless params[:search][:location] == ""
        proximity = params[:search][:proximity].to_f
        @search = Search.new(search_params)
        @search.user_id = current_user.id
        @search.save
        @last_search = @user.searches.order(created_at: :desc).first
        @runs = Run.near([@last_search.latitude, @last_search.longitude], proximity)
        if @runs.length == 0
          @runs = Run.near([@last_search.latitude, @last_search.longitude], proximity * 2 )
          @search_widened = "No runs found we widended your search to #{proximity * 2} km"
        elsif @runs.length == 0
          @runs = Run.near([@last_search.latitude, @last_search.longitude], proximity * 3 )
          @search_widened = "No runs found we widended your search to #{proximity * 3} km"
        else
          @search_widened = "Sorry even after widening your search we didnt find any shared runs within #{proximity *3} of you"
        end
      end
    else
          @runs = Run.all
          #policy_scope(Run).where.not(latitude: nil, longitude: nil).order(created_at: :desc)
    # @runs = params[:search][:location].present? ? Run.global_search(params[:search][:run_date]) : Run.all

    end
  end

  private

  def run_params
    params.require(:run).permit(:title, :time, :location, :date, :description, :run_distance, :capacity, :photo, :shared)
  end

  def search_params
    params.require(:search).permit(:location, :proximity, :run_date)
  end

  def set_run
    @run = Run.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def set_runs
     @coordinates = @runs.map do |run|
      if run.latitude && run.longitude
        {
          lat: run.latitude,
          lng: run.longitude,
          infowindow: render_to_string(partial: "runs/infowindow", locals: {run: run}),
        }
      end
    end
  end
end
