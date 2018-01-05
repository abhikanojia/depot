class Admin::ReportsController < Admin::BaseController
  DEFAULT_START = 5
  def index
    @start_date = start_date_param
    @end_date = end_date_param
    @orders = Order.by_date(@start_date, @end_date)
  end

  private

    def start_date_param
      unless params[:from].present?
        return DEFAULT_START.days.ago.beginning_of_day
      end
      params[:from].to_time.beginning_of_day
    end

    def end_date_param
      unless params[:to].present?
        return Time.now
      end
      params[:to].to_time.end_of_day
    end
end
