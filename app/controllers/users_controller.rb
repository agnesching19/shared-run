class UsersController < ApplicationController

  def create
    @user = User.new(user_params)

    if @user.save
      # UserMailer.creation_confirmation(@user).deliver_now
      redirect_to runs_path
    else
      render :new
    end
  end

  def dashboard
    @user = User.find(params[:id])
    authorize(@user)
  end

  def book
    bookings = []
    @booked_runs = params[:run]
    bookings << @booked_runs
    @run.capacity -= 1
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :photo, :sociability, :location, :pace, :bio)
  end
end
