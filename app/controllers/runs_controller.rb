class RunsController < ApplicationController
  before_action :set_run, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show, :run_show]
  before_action :set_user, only: [:index]

  require "time"

  def index
    @runs = policy_scope(Run.all.order(date: :asc))
    @disable_footer = true

    # if params[:time].present?
    #   # @runs = @runs.select { |r| r.run_distance <= arr[(params[:distance].to_i)] }
    #     @runs = @runs.select { |r| r.time <= Time.parse("19:00") }
    #     # @runs = @runs.select { |r| r.time <= Time.parse(params[:time]) }
    # end

    search_run
    set_runs
  end

  def show
    authorize @run
    @disable_footer = true
    @booking = Booking.new
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
    respond_to do |format|
      format.js
      format.html {
        redirect_to runs_path
      }
    end
  end

  def search_run
     arr = [5, 10, 15]
     arr_proximity = [1,3,5]
     arr_pace = ['3:00', '3:15', '3:30', '3:45',
  '4:00','4:15','4:30', '4:45',
  '5:00', '5:15', '5:30', '5:45',
  '6:00', '6:15', '6:30', '6:45',
  '7:00']
    if params[:search].present?
      unless params[:search][:location] == ""
        proximity = arr_proximity[(params[:search][:proximity].to_f)]
        distance =  arr[(params[:search][:run_distance].to_i)] if params[:search][:run_distance]
        sociability = (params[:search][:sociability].to_i)
        @search = Search.new(search_params)
        if current_user
          @user = current_user
          @search.user_id = @user.id
          @search.save
          @last_search = @user.searches.order(created_at: :desc).first
          @runs = Run.near([@last_search.latitude, @last_search.longitude], 5)
          @runs = Run.near([@last_search.latitude, @last_search.longitude], proximity) if params[:search][:proximity]
        else
          @user = User.new
        end
        @search.user_id = @user.id
        @search.save
        @runs = Run.near([@search.latitude, @search.longitude], 3)
        @runs = Run.near([@search.latitude, @search.longitude], proximity) if params[:search][:proximity]
        # Removing runs in the past
        @runs = @runs.select { |r| r.date >= Date.today}
        # Date filtering
        @runs = @runs.select { |r| r.date.strftime("%Y-%m-%d") == params[:search][:run_date] }

        # Time filtering
        if params[:search][:run_time].present?
          unless params[:search][:run_time] == ""
            start_of_date = "Sat Jan 01 "
            time_formatted = (params[:search][:run_time]) + ":00"
            end_of_time = " UTC 2000"
            date_time_to_parse = start_of_date + time_formatted + end_of_time
            time = Time.parse(date_time_to_parse)
            thirty_mins = 30*60
            start_window = time - thirty_mins
            end_window = time + thirty_mins
            @runs = @runs.select { |r| r.time >= start_window && r.time <= end_window}
          end
        end
        # Distance filtering
        if distance == 10
          @runs = @runs.select { |r| r.run_distance >= (arr[(params[:search][:run_distance].to_i)] - 5) && r.run_distance < (arr[(params[:search][:run_distance].to_i)] + 5)  }
        elsif distance == 5
          @runs = @runs.select { |r| r.run_distance < arr[(params[:search][:run_distance].to_i)] }
        elsif distance == 15
          @runs = @runs.select { |r| r.run_distance >= arr[(params[:search][:run_distance].to_i)] }
        end

        # Sociability filtering
        if sociability == 1
          @runs = @runs.select { |r| r.user.sociability == params[:search][:sociability].to_i}
        elsif sociability == 2
          @runs = @runs.select { |r| r.user.sociability == params[:search][:sociability].to_i}
        elsif sociability == 3
          @runs = @runs.select { |r| r.user.sociability == params[:search][:sociability].to_i}
        end
        # Pace filtering
        if params[:search][:pace].present?
          unless params[:search][:pace] == ""
            start_of_date = "Sat Jan 01 "
            pace_formatted = "0" + arr_pace[(params[:search][:pace]).to_i] + ":00"
            end_of_time = " UTC 2000"
            date_time_to_parse = start_of_date + pace_formatted + end_of_time
            pace = Time.parse(date_time_to_parse)
            @runs = @runs.select { |r| r.pace == pace }
          end
        end
        # if @runs.length == 0
        #   @runs = Run.near([@last_search.latitude, @last_search.longitude], proximity * 2 )
        #   @search_widened = "No runs found - we widened your search to #{proximity * 2} km"
        # elsif @runs.length == 0
        #   @runs = Run.near([@last_search.latitude, @last_search.longitude], proximity * 3 )
        #   @search_widened = "No runs found - we widended your search to #{proximity * 3} km"
        # else
        #   @search_widened = "Sorry, we didn't find any shared runs within #{proximity *3} of you even after widening your search"
        # end
      end
    else
        @runs = @runs.select { |r| r.date >= Date.today}
      #policy_scope(Run).where.not(latitude: nil, longitude: nil).order(created_at: :desc)
    # @runs = params[:search][:location].present? ? Run.global_search(params[:search][:run_date]) : Run.all
    end
  end

  private

  def run_params
    params.require(:run).permit(:title, :time, :location, :date, :description, :run_distance, :capacity, :photo, :shared, :pace)
  end

  def search_params
    params.require(:search).permit(:location, :proximity, :run_date, :run_time, :run_distance, :sociability, :pace)
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
