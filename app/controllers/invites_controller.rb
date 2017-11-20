class InvitesController < ApplicationController
  before_action :set_invite, only: [:show, :edit, :update, :destroy]
  before_action :set_run, only: [:new, :create]
  before_action :set_user, only: [:index]

  def index
    @invites = policy_scope(Invite).all
  end

  def new
    @invite = Invite.new
    authorize @invite
  end

  def create
    @invite = Invite.new(invite_params)
    @invite.user = current_user
    @invite.run = @run
    authorize @invite
    if @invite.save
      redirect_to invites_path
    else
      render :new
    end
  end

  def show
    authorize @invite
    @run = Run.find(@Invite.run_id)
    @receiver = User.find(@invite.user_id)
    @inviter = User.find(@run.user_id)
  end

  def edit
   authorize @invite
  end

  def update
    authorize @invite
    if @invite.update(invite_path)
      redirect_to invite_path(@invite)
    else
      render :edit
    end
  end

  def destroy
    authorize @invite
    @invite.destroy
    redirect_to root_path
  end

  private

  def invite_params
    params.require(:invite).permit(:status)
  end

  def set_invite
    @invite = Invite.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def set_run
    @run = Run.find(params[:id])
  end
end
