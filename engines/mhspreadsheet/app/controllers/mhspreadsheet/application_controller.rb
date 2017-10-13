module Mhspreadsheet
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :set_user
    def set_user
      if user_signed_in?
        if session[:employee_id]
          User.current = User.find session[:employee_id]
        else
          User.current = current_user
        end
      end
    end
  end
end
