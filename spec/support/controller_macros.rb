module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @admin = FactoryGirl.create(:admin)
      sign_in @admin
    end
  end

  def login_case_manager
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryGirl.create(:case_manager)
      User.current= @user
      sign_in @user
    end
  end

  def login_client
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryGirl.create(:client)
      User.current= @user
      sign_in @user
    end
  end
end