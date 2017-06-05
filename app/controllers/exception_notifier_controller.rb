class ExceptionNotifierController < ApplicationController
  def index
    @exceptions = ExceptionNotifier.where('created_at > ?', 7.days.ago).order('created_at DESC')
  end

  def show
    @exception = ExceptionNotifier.find params[:id]
  end
end
