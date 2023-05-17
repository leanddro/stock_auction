class BatchesController < AdminController
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
  end

  def approve
    batch = Batch.find(params[:id])
    if batch.create_by != current_user && batch.pending? && batch.end_at > DateTime.now
      batch.approved_by = current_user
      batch.approved!
      return redirect_to batch, notice: t('.success')
    end
    redirect_to batch, alert: t('.failed')
  end

  def add
    batch = Batch.find(params[:id])
    item = Item.find(params[:item_id])
    if item_available?(item)
      item.batch = batch
      item.unavailable!
      return redirect_to batch, notice: t('.success')
    end
    redirect_to batch, alert: t('.failed')
  end

  private

  def item_available?(item)
    return true if item.available? && item.batch_id.nil?
  end

  def batch_params
    params.require(:batch)
          .permit(:code, :start_at, :end_at, :minimum_bid, :minimum_bid_difference)
  end
end
