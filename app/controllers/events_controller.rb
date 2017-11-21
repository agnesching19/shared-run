class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = policy_scope(Event.all)
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
      redirect_to events_path
    else
      render :new
    end
  end

  def show
    authorize @event
  end

  def edit
    authorize @event
  end

  def update
    authorize @event
    if @event.update(event_path)
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  def destroy
    authorize @event
    @event.destroy
    redirect_to root_path
  end

  private

  def event_params
    params.require(:event).permit(:date, :time, :location, :description, :distance, :surface, :price)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
