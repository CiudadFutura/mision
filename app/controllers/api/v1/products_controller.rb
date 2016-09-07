class Api::V1::ProductsController < ApplicationController
  respond_to :json

  CATAGORIA_TODAS = 'Todas'

  # GET /users.json
  def index
    if !(params[:categoria_id].present?)

        logger.debug "PRIMER"

        @products = Producto.where("highlight = :destacado", destacado: true).order(:orden)
    elsif params[:categoria_id] != CATAGORIA_TODAS

        logger.debug "SEGUNDO"

        if params[:subcategoria_id].present?
            @products = Producto.joins(:categorias)
                            .where(
                                "categorias_productos.categoria_id = :sub_id AND categorias.parent_id = :id",
                                id: params[:categoria_id],
                                sub_id: params[:subcategoria_id]
                            )
                            .order(:orden, :nombre)
        else
            @products = Producto.joins(:categorias)
                            .where(
                                "categorias.id = :id OR categorias.parent_id = :id",
                                id: params[:categoria_id]
                            )
                            .order(:orden, :nombre)
        end
    else
        logger.debug "ELSE"

        @products = Producto.all.order(:orden, :nombre)
    end

    @products = @products.disponibles.order(:orden, :nombre) if current_usuario.nil? || !current_usuario.admin?

    respond_with(@products)
  end

end
