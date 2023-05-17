class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    set_values
  end

  private

  def set_values
    @batches_pending = Batch.where(status: 'pending').where.not(create_by: current_user) if current_user.admin?
    @winners = Batch.where(status: 'finished', winner: current_user) if current_user.regular?
    @user = current_user
  end
end
