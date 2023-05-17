# frozen_string_literal: true

class BatchesController < AdminController
  before_action :set_batch, only: %i(approve finish add cancel)

  def index
    @batches = Batch.all
  end

  def new
    @batch = Batch.new
  end

  def create
    @batch = Batch.new batch_params
    @batch.create_by = current_user

    return redirect_to @batch if @batch.save

    flash.now[:alert] = t('.not_registered')
    render 'new'
  end

  def show
    @batch = Batch.find(params[:id])
    @items = Item.available
    @last_bid = @batch.bids.last
  end

  def approve
    if @batch.create_by != current_user && @batch.pending? && @batch.end_at > DateTime.now
      @batch.approved_by = current_user
      @batch.approved!
      return redirect_to @batch, notice: t('.success')
    end
    redirect_to @batch, alert: t('.failed')
  end

  def finish
    return redirect_to @batch, alert: t('.erro_status') unless @batch.approved?
    return redirect_to @batch, alert: t('.erro_date') if @batch.end_at > DateTime.now
    return redirect_to @batch, notice: t('.not_bids') unless @batch.bids.present?

    @batch.finished!
    @batch.items.each(&:sealed!)
    @batch.winner_id = @batch.bids.last.user_id
    @batch.save!
    redirect_to @batch, notice: t('.success')
  end

  def cancel
    return redirect_to @batch, alert: t('.have_bids') if @batch.bids.present?
    @batch.canceled!
    redirect_to @batch, notice: t('.success')
  end

  def add
    item = Item.find(params[:item_id])
    if item_available?(item)
      item.batch = @batch
      item.unavailable!
      return redirect_to @batch, notice: t('.success')
    end
    redirect_to @batch, alert: t('.failed')
  end

  private

  def set_batch
    @batch = Batch.find(params[:id])
  end

  def item_available?(item)
    return true if item.available? && item.batch_id.nil?
  end

  def batch_params
    params.require(:batch)
          .permit(:code, :start_at, :end_at, :minimum_bid, :minimum_bid_difference)
  end
end
