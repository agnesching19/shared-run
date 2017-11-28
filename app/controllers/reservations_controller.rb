class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :destroy]
  before_action :set_event, only: [:new, :create]
  before_action :set_user, only: [:index]

  def index
    @reservations = policy_scope(Reservation.all)
  end

  def new
    @reservation = Reservation.new
    authorize @reservation
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.event_id = @event.id
    @reservation.user = current_user
    authorize @reservation
    if @reservation.save
      redirect_to event_path(@event), notice: "Event has been scheduled!"
    else
      redirect_to event_path(@event), alert: "Event has already been scheduled!"
    end
  end

  def destroy
    authorize @reservation
    @reservation.destroy
    respond_to do |format|
      format.js
      format.html {
        redirect_to event_path(@event)
      }
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:event, :user)
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_user
    @user = current_user
  end
end
