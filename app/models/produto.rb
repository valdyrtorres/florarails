class Produto < ActiveRecord::Base
  attr_accessible :descricao, :preco, :titulo, :validade, :grupo_id
end
