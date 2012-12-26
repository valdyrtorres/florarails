# encoding: utf-8
# O comentário acima é para aceitar caracteres com acento
class Produto < ActiveRecord::Base
  attr_accessible :descricao, :preco, :titulo, :validade, :imagem, :grupo_id
  
  belongs_to :grupo
  
  def self.localizar_produto_para_venda
    #find(:all, :order => "titulo",:conditions => ['validade >= ?', Date.current])
    find(:all, :order => "titulo")
  end

  def self.lista_produto_grupo(grupo)
     find(:all, :order => "titulo",
        :conditions => ['validade >= ? and grupo_id = ?', Date.current, grupo])
  end
  
  def to_param
    require 'iconv'
    texto = Iconv.iconv("ASCII//IGNORE//TRANSLIT","UTF-8",titulo).join.gsub(/[\s]+/i,
    '_').gsub(/[^a-z0-9\_]+/i,'').downcase
    "#{id}-#{titulo}"
  end
  
  #Configurações do PaperClip
  has_attached_file :imagem,
  :styles => {:grande => "800x600>",
              :media => "200x150>",
              :pequena => "80x60>",
              :thumb => "40x30>"},
  :path => "public/system/:class/:id/:filename",
  :url => "/system/:class/:id/:basename.:extension",
  :default_url => "/system/imagens/semfoto.jpg"
  #Nos parâmetros path e URL estamos definindo que as imagens estarão 
  #no diretório app/assets/images
  #e que será criado um diretório como o nome da classe (no nosso
  #exemplo produtos) e o respectivo id.
  #Já o default_url irá definir uma imagem que será exibida por default
  #caso ela seja apagada, por exemplo.
  validates_attachment_presence :imagem,
  :message => 'Imagem deve ser informada'
  validates_attachment_content_type :imagem,
  :content_type => ['image/jpeg', 'image/png','image/gif','image/pjpeg'],
  :message => 'Tipo da imagem inválido'
  #Validações do Modelo
  validates_presence_of :titulo, :descricao
  validates_numericality_of :preco
  validate :preco_deve_ser_no_minimo_um_centavo
  validates_uniqueness_of :titulo
  #Método protected indica que o acesso é apenas a objetos da
  #classe e subclasses
  
  protected
  def preco_deve_ser_no_minimo_um_centavo
    errors.add(:preco, 'deve ser no mínimo 0.01') if preco.nil? || preco < 0.01
  end
end
