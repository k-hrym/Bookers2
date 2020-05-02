# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
   before_action :configure_sign_up_params, only: [:create,:new]
   before_action :configure_account_update_params, only: [:update,:edit]

  # GET /resource/sign_up
   def new
    if user_signed_in?
     @user = User.new
    else
     redirect_to user_path(current_user)
    end
   end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  def edit
    @user = current_user
  end

  # PUT /resource
  def update
      @user = current_user
    if @user.update(user_params)
      flash[:success] = "You have updated user successfully."
      redirect_to books_path
    else
      render :edit
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

   protected

  # If you have extra params to permit, append them to the sanitizer.
   def configure_sign_up_params
     devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:email])
   end

  # If you have extra params to permit, append them to the sanitizer.
   def configure_account_update_params
     devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduction, :profile_image])
   end

  # The path used after sign up.
   def after_sign_up_path_for(resource)
     user_path(current_user)
   end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end


  # The path used after sign up for inactive accounts.
   def after_inactive_sign_up_path_for(resource)
    redirect_to user_path(current_user)
   end
end