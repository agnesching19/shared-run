# class Users::SessionsController < Devise::SessionsController
#   before_action :configure_sign_in_params, only: [:create]
#   respond_to :html, :json

#   # GET /resource/sign_in
#   def new
#     super
#   end

#   # POST /resource/sign_in
#   def create
#     respond_to do |format|
#       if @user.save
#         format.html do
#           redirect_to '/'
#         end
#         format.json { render json: @user.to_json }
#       else
#         format.html { render 'new'} ## Specify the format in which you are rendering "new" page
#         format.json { render json: @user.errors } ## You might want to specify a json format as well
#       end
#     end
#   end

#   # DELETE /resource/sign_out
#   def destroy
#     super
#   end

#   # protected

#   # If you have extra params to permit, append them to the sanitizer.
#   def configure_sign_in_params
#     devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
#   end
# end
