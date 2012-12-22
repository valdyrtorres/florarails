class Produto < ActiveRecord::Base
  attr_accessible :descricao, :preco, :titulo, :validade
end
