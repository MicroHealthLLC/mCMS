class UserCasesController < ApplicationController
  add_breadcrumb I18n.t(:home), :root_path
  before_action  :authenticate_user!
  before_action :authorize
  before_action :get_user_cases, only: [:index]


  private
  def get_user_cases
    @cases_for_btn = Case.visible
  end
end