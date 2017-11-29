class MessagesController < ApplicationController
  before_action :set_run, only: [:index, :create, :destroy]
  before_action :set_user, only: [:show, :read]
  before_action :set_message, only: [:destroy, :read]
  skip_after_action :verify_policy_scoped, only: [:index, :create, :show, :destroy, :read]

  def index
    @message = Message.new
    @messages = Message.where(run: @run)
    authorize @messages
    authorize @message
    @disable_footer = true
  end

  def create
    @messages = Message.where(run: @run)

    @message = Message.new(message_params)
    @message.run = @run
    @message.user = current_user

    authorize @message
    # @message.save
    # redirect_to run_messages_path(@run)
    if @message.save
      respond_to do |format|
        format.html { redirect_to run_messages_path(@run) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render "messages/index" }
        format.js
      end
    end
  end

  def show
    authorize @user.messages
    @disable_footer = true
  end

  def destroy
    # set_message
    authorize @message
    @message.destroy
    redirect_to run_messages_path(@run)
  end

  def read
    authorize @message
    if @message.user != @user
      if @message.created_at > @user.last_sign_in_at
        @message.read = true
      end
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
