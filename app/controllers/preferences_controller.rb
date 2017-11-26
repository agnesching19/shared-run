class PreferencesController < ApplicationController
  before_action :set_preference, only: [:edit, :update, :destroy, :update]
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_user, only: [:index, :destroy, :update]

  def index
    @preferences = policy_scope(Preference.all).order(created_at: :desc)
  end

  def new
    @preference = Preference.new
    authorize @preference
  end

  def create
    @preference = Preference.new(preference_params)
    @preference.user_id = current_user.id
    authorize @preference
    if @preference.save
      redirect_to preferences_path
    else
      render :new
    end
  end

  def edit
    authorize @preference
  end

  def update
    authorize @preference
    if @preference.update(preference_params)
      redirect_to preference_path(@preference)
    else
      render :edit
    end
  end

  private

  def preference_params
    params.require(:preference).permit(:date, :time, :location, :sociability)
  end

  def set_preference
    @preference = Preference.find(params[:id])
  end

  def set_user
    @user = current_user
  end
end
