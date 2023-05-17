class BidsController < ApplicationController
  before_action :authenticate_user!

  def create
    bid_params = params.require(:bid).permit(:amount, :batch_id)
    batch = Batch.find(bid_params[:batch_id])
    amount = bid_params[:amount].to_i

    return redirect_to batch_detail_path(batch.id), alert: t('.finished') if batch.end_at < DateTime.now
    return redirect_to batch_detail_path(batch.id), alert: t('.forbidden') if current_user.admin?

    if batch.bids.last.present?
      unless batch.bids.last.amount + batch.minimum_bid_difference <= amount
        return redirect_to batch_detail_path(batch.id), alert: t('.failed_difference')
      end

      Bid.create!(batch:, user: current_user, amount:)
      return redirect_to batch_detail_path(batch.id), notice: t('.success')
    end

    return redirect_to batch_detail_path(batch.id), alert: t('.failed_minimum') unless amount >= batch.minimum_bid

    Bid.create!(batch:, user: current_user, amount:)
    redirect_to batch_detail_path(batch.id), notice: t('.success')
  end
end
