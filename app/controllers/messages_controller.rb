class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :set_run, only: [:new, :create, :index]

  def index
    @messages = policy_scope(Message).order(updated_at: :desc)
  end

  def show
    authorize @message
  end

  def new
    @message = Message.new
    authorize @message
  end

  def create
    @message = Message.new(message_params)
    @message.run_id = @run.id
    @message.user_id = current_user.id
    authorize @message
    if @message.save
      redirect_to run_messages_path(@message)
    else
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def set_run
    @run = Run.find(params[:run_id])
  end

  def set_message
    @message = Message.find(params[:id])
  end

  def set_user
    @user = current_user
  end
end
