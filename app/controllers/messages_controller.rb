class MessagesController < ApplicationController
  before_action :set_run, only: [:index, :create, :destroy]
  before_action :set_user, only: [:show]
  before_action :set_message, only: [:destroy]
  skip_after_action :verify_policy_scoped, only: [:index, :create, :show, :destroy]

  def index
    @message = Message.new
    @messages = Message.where(run: @run)
    authorize @messages
    authorize @message
  end

  def create
    @message = Message.new(message_params)
    @message.run = @run
    @message.user = current_user

    authorize @message
    @message.save
    redirect_to run_messages_path(@run)
    # if @message.save
    #   respond_to do |format|
    #     format.html { redirect_to run_messages_path(@message) }
    #     format.js
    #   end
    # else
    #   respond_to do |format|
    #     format.html { render "messages/show" }
    #     format.js
    #   end
    # end
  end

  def show
    authorize @user.messages
  end

  def destroy
    # set_message
    authorize @message
    @message.destroy
    redirect_to run_messages_path(@run)
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
