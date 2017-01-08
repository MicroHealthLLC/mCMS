class UserCasesController < ApplicationController
  before_action  :authenticate_user!
  before_action :authorize
end