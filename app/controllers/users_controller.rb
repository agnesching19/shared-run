class UsersController < ApplicationController

  def create
    @user = User.new(user_params)

    if @user.save
      # UserMailer.creation_confirmation(@user).deliver_now
      redirect_to root_path
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

  def status
    @next_run = @user.runs.order(date: :desc).first
    @days_to_go = (@next_run.date - Date.today + 1).to_i
    if @days_to_go < 0
      @status = "It's been #{-@days_to_go} days since your last run!"
    else
      @status = "#{@days_to_go} days until your next run!"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :photo, :sociability, :location, :pace, :bio)
  end
end
