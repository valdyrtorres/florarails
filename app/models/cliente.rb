# encoding: utf-8
# O comentário acima é para aceitar caracteres com acento
#Vamos carregar a biblioteca SHA (Secure Hash #Algorithm)
require 'digest/sha2'

class Cliente < ActiveRecord::Base
  attr_accessible :bairro, :cep, :cidade, :complemento, :cpf, :email, :tipo_logradouro, :logradouro, :nome, :senha, :telefone, :uf

  #O método attr_acessor fornece uma alternativa mais curta que
  #usar ambos os métodos attr_reader e attr_writer
  attr_acessor :senha_confirmation
  #Definindo o método que deverá ser executado antes de salvar o
  #registro
  before_save :criptografa_senha
  #Validando os atributos únicos
  validates_uniqueness_of :cpf, :email, :message => 'já foi informado'
  #Validando os atributos obrigatórios
  validates_presence_of :senha, :senha_confirmation, :nome, :email, :cpf, :telefone, :message => 'campo é obrigatório'  
  #Validando se o campo senha e o campo senha_confirmation são iguais
  #Por default, o RoR irá procurar por um campo com o nome + _
  #confirmation
  validates_confirmation_of :senha
  #Validando o tamanho do campo senha
  validates_length_of :senha, :within => 6..20, :too_long => "Informe uma senha menor", 
                      :too_short => "Informe uma senha maior"
  #Utilizando expressões regulares para validar os campos 
  validates_format_of :cpf, :with => %r{^(\d{3})\.(\d{3})\.(\d{3})-(\d{2})$}i,
      :message => 'O CPF deve ser digitado no formato: 999.999.999-99'
  validates_format_of :telefone, :with => %r{^\(\d{2}\)\d{4}-\d{4}$}i,
      :message => 'O telefone deve ser digitado no formato: (99)9999-9999' 
  validates_format_of :email, :with => %r{^[A-Za-z0-9_.-]+@([A-Za-z0-9_]+\.)+[A-Za-z]{2,4}$}i,
      :message => 'O e-mail informado é inválido'

  #Método para criptografar a senha com SHA
  def criptografa_senha
     self.senha = Digest::SHA256.hexdigest(senha)
  end

end
