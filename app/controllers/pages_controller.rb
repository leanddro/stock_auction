class PagesController < ApplicationController
  def home
    @current_batches = Batch.where(start_at: ..DateTime.now, status: ['approved'])
    @next_batches = Batch.where(start_at: DateTime.now.next_day(1).., status: ['approved', 'pending'])
  end

  def batch_detail
    @batch = Batch.find(params[:id])
  end
end
