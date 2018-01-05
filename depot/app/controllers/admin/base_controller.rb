class Admin::BaseController < ApplicationController
  before_action :ensure_user_is_admin

  protected
    def ensure_user_is_admin
      unless current_admin?
        redirect_to store_index_url, notice: 'Wrong link.'
      end
    end
end
