module Inventory
  class ProductsController < ProtectForgeryApplication
    before_action :set_product, only: [:show, :edit, :update, :destroy]
    before_action :require_admin

    # GET /products
    def index
      @products = Product.all
    end

    # GET /products/1
    def show
      @product_assigns = @product.product_assigns
    end

    # GET /products/new
    def new
      @product = Product.new
    end

    # GET /products/1/edit
    def edit
      @product_assigns = @product.product_assigns
    end

    # POST /products
    def create
      @product = Product.new(product_params)

      if @product.save
        redirect_to @product, notice: 'Product was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /products/1
    def update
      if @product.update(product_params)
        redirect_to products_url, notice: 'Product was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /products/1
    def destroy
      if  @product.destroy
        redirect_to products_url, notice: 'Product was successfully destroyed.'
      else
        flash[:error] = @product.errors.full_messages.join('<br/>')
        redirect_to edit_product_url(@product)
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(Product.safe_attributes)
    end
  end
end
