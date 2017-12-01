class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :update]
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_user, only: [:index, :destroy, :update]

  def index
    @events = policy_scope(Event.all).order(date: :asc)
    search_event
    set_events
  end

  def new
    @event = Event.new
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    authorize @event
    if @event.save
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  def show
    authorize @event
    @disable_footer = true
  end

  def edit
    authorize @event
  end

  def update
    authorize @event
    if @event.update(event_params)
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  def destroy
    authorize @event
    @event.destroy
    redirect_to events_path
  end

    def search_event
       arr = [5, 10, 15]
       arr_proximity = [1,3,5]
       arr_pace = ['3:00', '3:15', '3:30', '3:45',
    '4:00','4:15','4:30', '4:45',
    '5:00', '5:15', '5:30', '5:45',
    '6:00', '6:15', '6:30', '6:45',
    '7:00']
      if params[:event_search].present?
        unless params[:event_search][:location] == ""
          proximity = arr_proximity[(params[:event_search][:proximity].to_f)]
          distance =  arr[(params[:event_search][:run_distance].to_i)] if params[:event_search][:run_distance]
          @event_search = EventSearch.new(event_search_params)
          if current_user
            @user = current_user
            @event_search.user_id = @user.id
            @event_search.save
            @last_event_search = @user.event_searches.order(created_at: :desc).first
            @events = Event.near([@last_event_search.latitude, @last_event_search.longitude], 3)
            @events = Event.near([@last_event_search.latitude, @last_event_search.longitude], proximity) if params[:event_search][:proximity].to_f
          else
            @user = User.new
          end

          @event_search.user_id = @user.id
          @event_search.save
          @events = Event.near([@event_search.latitude, @event_search.longitude], 3)
          @events = Event.near([@event_search.latitude, @event_search.longitude], proximity) if params[:event_search][:proximity].to_f
          # Removing events in the past
          @events = @events.select { |r| r.date >= Date.today}

          # Distance filtering
          if distance == 10
            @events = @events.select { |r| r.run_distance >= (arr[(params[:event_search][:run_distance].to_i)] - 5) && r.run_distance < (arr[(params[:event_search][:run_distance].to_i)] + 5)  }
          elsif distance == 5
            @events = @events.select { |r| r.run_distance < arr[(params[:event_search][:run_distance].to_i)] }
          elsif distance == 15
            @events = @events.select { |r| r.run_distance >= arr[(params[:event_search][:run_distance].to_i)] }
          end
          # if @events.length == 0
          #   @events = event.near([@last_search.latitude, @last_search.longitude], proximity * 2 )
          #   @search_widened = "No events found - we widened your search to #{proximity * 2} km"
          # elsif @events.length == 0
          #   @events = event.near([@last_search.latitude, @last_search.longitude], proximity * 3 )
          #   @search_widened = "No events found - we widended your search to #{proximity * 3} km"
          # else
          #   @search_widened = "Sorry, we didn't find any shared events within #{proximity *3} of you even after widening your search"
          # end
        end
      else
          @events = @events.select { |r| r.date >= Date.today}
        #policy_scope(event).where.not(latitude: nil, longitude: nil).order(created_at: :desc)
      # @events = params[:event_search][:location].present? ? event.global_search(params[:event_search][:event_date]) : event.all
      end
    end

  private

  def event_params
    params.require(:event).permit(:date, :time, :location, :description, :run_distance, :surface, :price)
  end

  def event_search_params
    params.require(:event_search).permit(:location, :proximity, :run_date, :run_distance)
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def set_events
    @coordinates = @events.map do |event|
      if event.latitude && event.longitude
        {
          lat: event.latitude,
          lng: event.longitude,
          # infowindow: render_to_string(partial: "events/infowindow", locals: {event: event}),
        }
      end
    end
  end
end
