class Grupo < ActiveRecord::Base
  attr_accessible :descricao
  default_scope :order => 'descricao ASC'
end
