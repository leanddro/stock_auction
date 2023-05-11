class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  private
  def require_admin
    unless current_user.admin?
      flash[:alert] = t('forbidden')
      redirect_to root_path
    end
  end
end
