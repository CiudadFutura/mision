class Api::V1::ProductsController < ApplicationController
  respond_to :json

  def index
    if !(params[:categoria_id].present?)
        @products = Producto.destacados
    elsif params[:categoria_id] != Categoria::TODAS
        if params[:subcategoria_id].present?
            @products = Producto.bySubcategoria(params[:categoria_id], params[:subcategoria_id])
        else
            @products = Producto.byCategoria(params[:categoria_id])
        end
    else
        @products = Producto.all.order(:orden, :nombre)
    end

    @products = @products.disponibles.order(:orden, :nombre) if current_usuario.nil? || !current_usuario.admin?

    respond_with(@products)
  end

end
