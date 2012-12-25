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
  
  def adicionar_no_carrinho
    @carrinho = localiza_carrinho
    produto = Produto.find(params[:id].to_i)
    @carrinho.adicionar_produto(produto)
  end
  #private significa que o método é acessível somente
  #quando chamados com um receptor específico
  private
     def localiza_carrinho
       session[:carrinho] ||= Carrinho.new
     end
end
