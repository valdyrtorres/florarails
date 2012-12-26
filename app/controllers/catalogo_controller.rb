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
    begin
      produto = Produto.find(params[:id].to_i)
      rescue ActiveRecord::RecordNotFound
      logger.error("Erro:Não é possível localizar o produto #{params[:id]}")
      flash[:erro] = "O produto informado não existe. Por favor, selecione outro no nosso catálogo"
      redirect_to :action => :index
    else
      @carrinho = localiza_carrinho    
      @carrinho.adicionar_produto(produto)
    end
  end

  def esvaziar_carrinho
    session[:carrinho] = nil
    flash[:info] = "O seu carrinho agora está vazio."
    redirect_to :action => :index
  end

  def remover_do_carrinho
    produto = Produto.find(params[:id].to_i)
    @carrinho = localiza_carrinho
    @carrinho.remove_produto(produto)
    render :action => "adicionar_no_carrinho"
  end

  #Método para efetuar a busca do produto
  def procurar
    @termo = params[:busca].downcase
    @produtos = Produto.find(:all, :conditions => ["LOWER(descricao) LIKE ? or LOWER(titulo) LIKE ? and validade >=?",
           '%'+@termo+'%','%'+@termo+'%',Date.current], :order => 'validade ASC') 
    unless @produtos.size > 0
      flash.now[:info] = "Não foi encontrado nenhum produto com esse critério de busca"
    end
    @carrinho = localiza.carrinho
  end

  def lista_itens_grupo
    @produtos = Produto.lista_produto_grupo(params[:grupo])
    @grupo = Grupo.find(params[:grupo])
  end

  #private significa que o método é acessível somente
  #quando chamados com um receptor específico
  private
     def localiza_carrinho
       session[:carrinho] ||= Carrinho.new
     end
end
