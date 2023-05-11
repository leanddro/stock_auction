class ItemsController < AdminController

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    @categories = Category.where(active: true)
  end

  def create
    @item = Item.new item_params
    @item.create_by = current_user

    return redirect_to @item, notice: t(".success") if @item.save

    @categories = Category.where(active: true)
    flash.now[:alert] = t(".error")
    render 'new'
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item)
          .permit(:name, :description, :weight, :width, :height, :depth, :category_id )
  end
end
