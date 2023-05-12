class BatchesController < ApplicationController
  def index

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

  private

  def batch_params
    params.require(:batch)
          .permit(:code, :start_at, :end_at, :minimum_bid, :minimum_bid_diference)
  end
end
