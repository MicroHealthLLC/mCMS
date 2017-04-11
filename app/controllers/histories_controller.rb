class HistoriesController < ApplicationController
  before_action  :authenticate_user!
  def show
    @object = safe_type_param.constantize.find(params[:id])
    @audits = @object.audits.order('id DESC')
  end

  private

  def safe_type_param
    all_classes = ApplicationRecord.subclasses.map(&:to_s)
    type = all_classes.detect{|klass| klass == params[:type] }
    render_404 if type.nil?
  end
end
