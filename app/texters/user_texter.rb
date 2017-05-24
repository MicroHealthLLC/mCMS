class UserTexter < Textris::Base
  default :from => ENV["TWILIO_PHONE_NUMBER_full"]

  def welcome(user)
    @user = user
    text :to => @user.phone_number
  end

  def send_sms(phone_number, content)
    @content = content
    text :to => phone_number
  end
end