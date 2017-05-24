class SmsController < ProtectForgeryApplication
  before_action  :authenticate_user!
  before_action  :authorize
  def show
  end

  def send_sms
    phone_number = params[:phone_number]
    content= params[:body]
    if phone_number.present? and content.present?
      UserTexter.send_sms(phone_number, content).deliver_now
      flash[:notice] = "SMS sent to #{phone_number}"
    else
      flash[:error] = "Cannot send the sms."
    end
    redirect_to :back
  rescue
    flash[:error] = "Cannot send the sms."
    redirect_to :back
  end
end
