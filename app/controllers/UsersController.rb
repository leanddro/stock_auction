class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    set_values
  end

  private

  def set_values
    if current_user.admin?
      @batches_pending = Batch.where(status: 'pending').where.not(create_by: current_user)
    end
    @user = current_user
  end
end
