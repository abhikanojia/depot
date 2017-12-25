class Admin::ReportsController < Admin::BaseController
  def index
    @from =  from_date_param
    @to =  to_date_param
    @orders = Order.by_date(@from, @to)
  end

  private

    def filter_params
      params.permit(:from, :to)
    end

    def from_date_param
      unless filter_params.key?(:from)
        return 5.days.ago.beginning_of_day
      end
      filter_params[:from].to_time.beginning_of_day
    end

    def to_date_param
      unless filter_params.key?(:to)
        return Time.now
      end
      filter_params[:to].to_time.end_of_day
    end
end
