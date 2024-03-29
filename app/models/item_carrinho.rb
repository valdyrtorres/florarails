class ItemCarrinho
  attr_accessible :produto, :quantidade
  attr_reader :produto, :quantidade

  def initialize(produto)
    @produto = produto
    @quantidade = 1
  end

  def aumenta_quantidade
    @quantidade +=1 
  end

  def titulo
    @produto.titulo
  end

  def codigo
    @produto.id
  end
 
  def preco
    @produto.preco * @quantidade
  end
end
