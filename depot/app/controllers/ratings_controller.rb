class RatingsController < ApplicationController
  def update
    @ratings = Rating.find_by_and_update_by_or_create(find_params, rating_params)
    respond_to do |format|
      if @ratings
        msg = { status: 200, message: "Success!" }
      else
        msg = { status: 400, message: "Error Occured while saving ratings."}
      end
      format.json  { render :json => msg }
    end
  end

  private

    def find_params
      { user_id: current_user.id, product_id: params[:id] }
    end

    def rating_params
      params.require(:ratings).permit(:score).merge(find_params)
    end
end
