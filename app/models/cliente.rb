class Cliente < ActiveRecord::Base
  attr_accessible :bairro, :cep, :cidade, :complemento, :cpf, :email, :logradouro, :nome, :senha, :telefone, :uf
end
