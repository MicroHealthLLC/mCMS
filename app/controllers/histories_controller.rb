class HistoriesController < ApplicationController
  before_action  :authenticate_user!
  def show
    @object = params[:type].constantize.find(params[:id])
    @audits = @object.audits.order('id DESC')
  end
end
