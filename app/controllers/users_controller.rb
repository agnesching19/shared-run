class UsersController < ApplicationController
  def dashboard
    @user = User.find(params[:id])
    authorize(@user)
  end

  def run_history
    @upcoming = 0
    @past = 0
    @user.runs each do |run|
      if run.time < Time.now
        @past += 1
      else
        @upcoming += 1
    end
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
