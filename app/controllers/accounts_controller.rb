class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  authorize_resource

  respond_to :html

  def index
    if current_usuario.admin?
      @accounts = Account.all
    elsif current_usuario.usuario?
      @accounts = Account.where(usuario_id: current_usuario.id)
    end
    respond_with(@accounts)
  end

  def show
=begin
    if current_usuario.admin?
      @pedidos = Pedido.all
      respond_to do |format|
        format.html
        format.xls
      end
    elsif current_usuario.coordinador? || current_usuario.usuario?
      @pedidos = Pedido.where(usuario_id: current_usuario.id)
    end
=end

    respond_with(@account)
  end

  def new
    @account = Account.new
    respond_with(@account)
  end

  def edit
  end

  def create
    @account = Account.new(account_params)
    @account.save
    respond_with(@account)
  end

  def update
    @account.update(account_params)
    respond_with(@account)
  end

  def destroy
    @account.destroy
    respond_with(@account)
  end

  private
    def set_account
      @account = Account.find(params[:id])
    end

    def account_params
      params.require(:account).permit(:usuario_id, :status, :balance)
    end
end
