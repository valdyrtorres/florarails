# encoding: utf-8
# O comentário acima é para aceitar caracteres com acento
class CatalogoController < ApplicationController
  def index
    @produtos = Produto.localizar_produto_para_venda
  end
  
  def detalhes
    @produto = Produto.find(params[:id].to_i)
    rescue ActiveRecord::RecordNotFound
    flash[:info] = "O produto informado não foi encontrado. Por favor, selecione outro no nosso catálogo"
    redirect_to :action => :index
  end
end
