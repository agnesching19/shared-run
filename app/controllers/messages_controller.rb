class MessagesController < ApplicationController
  before_action :set_message, :set_run

  def index
    @messages = policy_scope(Message).order(updated_at: :desc)
  end

  def show
    authorize @message
  end

  def new
    @message = Message.new
    authorize @message
    if @message.save
      redirect_to run_message(@message)
    else
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def set_message
    @message = Message.find(params[:id])
  end

  def set_user
    @user = current_user
  end
end
