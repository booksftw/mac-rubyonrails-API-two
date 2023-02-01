class CategoriesController < ApplicationController
    before_action :set_category, only: [:destroy, :update]

    # GET /categories
    def index
        @categories = Category.all

        render json: @categories
    end

    # POST /categories   
    def create
        @category = Category.create("name": category_params["name"])

        if @category.save
            # render json: @category, status: :created, location: @category
            render json: @category, status: :created
        else
            render json: @category.errors, status: :unprocessable_entity
          end
    end

    def update
        @category.update("name": category_params['name'])
        render json: @category
    end

    def destroy
        @category.destroy
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name)
    end
end
