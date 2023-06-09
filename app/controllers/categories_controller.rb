class CategoriesController < AdminController

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    return redirect_to categories_path if @category.save

    flash.now[:alert] = 'Erro ao cadastrar categoria'
    render 'new'
  end

  def show
    @category = Category.find(params[:id])
  end

  def toggle
    @category = Category.find(params[:id])
    @category.update(active: params[:active])

    respond_to do |format|
      format.html { redirect_to @category }
      format.json { render json: { message: 'Success' } }
    end
  end

  private

  def category_params
    params.require(:category)
          .permit(:name, :description)
  end
end
