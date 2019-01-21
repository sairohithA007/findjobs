class Users::RegistrationsController < Devise::RegistrationsController
 before_action :configure_sign_up_params, only: [:create]
 #before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
   def new
    @user = User.new
   end

  # POST /resource
   def create
     @roles = Role.all
     @user = User.new(configure_sign_up_params)
     if @user.role_id == nil
          @user.role_id = 1
        end
     if @user.save
       redirect_to "/posts"
     end   
     puts @user.errors.messages
     
   end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
   def update
   if @user.update(params.require(:user).permit(:name, :phone, :address, :image))
     super
   end
   end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
     params.require(:user).permit(:name, :phone, :address, :email, :password, :password_confirmation, :role_id, :image)
   end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  
  
  
end
