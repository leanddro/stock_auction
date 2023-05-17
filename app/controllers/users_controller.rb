class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    set_values
  end

  private

  def set_values
    @batches_pending = Batch.where(status: 'pending').where.not(create_by: current_user) if current_user.admin?
    @user = current_user
  end
end
