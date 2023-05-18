class PagesController < ApplicationController
  def home
    @current_batches = Batch.where(start_at: ..DateTime.now, status: ['approved'])
    @next_batches = Batch.where(start_at: DateTime.now.next_day.., status: %w[approved pending])
  end

  def batch_detail
    @batch = Batch.find(params[:id])
    @new_bid = Bid.new
    @last_bid = @batch.bids.last
    @new_comment = Comment.new
    @comments = Comment.where(batch: @batch, parent: nil)
  end

  def winners
    @batches = Batch.where(status: ['finished']).reverse_order
  end

  def search
    query = params[:query]

    @batches = Batch.where('code LIKE ?', "%#{query}%").to_a
    items = Item.where('name LIKE ?', "%#{query}%").where.not(batch_id: nil)

    for item in items
      @batches << item.batch
    end

    @batches.uniq!
  end
end
