class BatchesController < ApplicationController
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
  end

  def approve
    batch = Batch.find(params[:id])
    if batch.create_by != current_user && batch.pending?
      batch.approved!
      return redirect_to batch, notice: t('.success')
    end
    redirect_to batch, alert: t('.failed')
  end

  private

  def batch_params
    params.require(:batch)
          .permit(:code, :start_at, :end_at, :minimum_bid, :minimum_bid_difference)
  end
end
