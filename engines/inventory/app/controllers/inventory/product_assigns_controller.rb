module Inventory
  class ProductAssignsController < ProtectForgeryApplication
    add_breadcrumb "Inventory - Product assignments", :product_assigns_path
    before_action :set_product_assign, only: [:show, :edit, :update, :destroy]
    before_action :authorize

    # GET /product_assigns
    def index
      @product_assigns = ProductAssign.visible
    end

    # GET /product_assigns/1
    def show
    end

    # GET /product_assigns/new
    def new
      @product_assign = ProductAssign.new(params.permit(:user_id, :product_id))
    end

    # GET /product_assigns/1/edit
    def edit
    end

    # POST /product_assigns
    def create
      @product_assign = ProductAssign.new(product_assign_params)

      if @product_assign.save
        redirect_to @product_assign, notice: 'Product assign was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /product_assigns/1
    def update
      if @product_assign.update(product_assign_params)
        redirect_to product_assigns_url, notice: 'Product assign was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /product_assigns/1
    def destroy
      @product_assign.destroy
      redirect_to product_assigns_url, notice: 'Product assign was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_product_assign
        @product_assign = ProductAssign.find(params[:id])
        add_breadcrumb @product_assign, @product_assign
      rescue ActiveRecord::RecordNotFound
        render_404
      end

      # Only allow a trusted parameter "white list" through.
      def product_assign_params
        params.require(:product_assign).permit(ProductAssign.safe_attributes)
      end
  end
end
