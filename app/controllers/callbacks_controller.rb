class CallbacksController < Devise::OmniauthCallbacksController
  def github
    user_deleted = User.user_deleted?(request.env["omniauth.auth"])
    if user_deleted
      flash[:error] = 'Cannot create user because it is already deleted'
      redirect_to root_path
    else
      @user = User.from_omniauth(request.env["omniauth.auth"])
      sign_in_and_redirect @user
    end

  end

  def office365
    logger.warn 'OFFICE check'
    user_deleted = User.user_deleted?(request.env["omniauth.auth"])
    if user_deleted
      flash[:error] = 'Cannot create user because it is already deleted'
      redirect_to root_path
    else
      # session["omniauth.state"] = params['state']
      @user = User.from_omniauth(request.env["omniauth.auth"])
      logger.warn 'OFFICE CREATE OR UPDATE USER'
      sign_in_and_redirect @user
    end
  end

  def facebook
    user_deleted = User.user_deleted?(request.env["omniauth.auth"])
    if user_deleted
      flash[:error] = 'Cannot create user because it is already deleted'
      redirect_to root_path
    else
      @user = User.from_omniauth(request.env["omniauth.auth"])
      sign_in_and_redirect @user
    end
  end

  def twitter
    user_deleted = User.user_deleted?(request.env["omniauth.auth"])
    if user_deleted
      flash[:error] = 'Cannot create user because it is already deleted'
      redirect_to root_path
    else
      @user = User.from_omniauth(request.env["omniauth.auth"])
      sign_in_and_redirect @user
    end
  end

 def google_oauth2
   user_deleted = User.user_deleted?(request.env["omniauth.auth"])
   if user_deleted
     flash[:error] = 'Cannot create user because it is already deleted'
     redirect_to root_path
   else
     @user = User.from_omniauth(request.env["omniauth.auth"])
     sign_in_and_redirect @user
   end
  end
end
