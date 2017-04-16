class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  before_action :maintenance, if: :maintenance_now?

  def maintenance
    redirect_to '/maintenance.html'
  end

  def maintenance_now?
    start_date = Time.new(2015,1,23,11,00)
    end_date = Time.new(2015,2,2,12,00)
    start_date.past? and end_date.future?
  end
end
