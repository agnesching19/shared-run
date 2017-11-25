class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :destroy]
  before_action :set_run, only: [:new, :create]
  before_action :set_user, only: [:index]

  def index
    @bookings = policy_scope(Booking)
    # authorize @booking
    # @run = Run.find(@booking.run_id)
    # @participant = User.find(@booking.user_id)
    # @host = User.find(@run.user_id)
  end

  def new
    @booking = Booking.new
    authorize @booking
  end

  def create
    @booking = Booking.new
    @booking.run = @run
    @booking.user = current_user
    authorize @booking
    if @booking.save
      redirect_to run_path(@run)
    else
      render :new
    end
  end

  def destroy
    authorize @booking
    @booking.destroy
    redirect_to run_path(@run)
  end

  private

  def booking_params
    params.require(:booking).permit(:run)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_run
    @run = Run.find(params[:run_id])
  end

  def set_user
    @user = current_user
  end
end
