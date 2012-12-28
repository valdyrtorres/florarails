#OpenURI é um wrapper para utilizar http, https e ftp.
#Um wrapper permite que um objeto cliente utilize serviços
#de outros objetos com interfaces diferentes pr meio de uma
#interface única.
reuire 'open-uri'
class ClientesController < ApplicationController

   #Em vez de utilizarmos o layout padrão, estamos definindo outro
   #layout
   layout "catalogo"

   def show
      @cliente = Cliente.find(params[:id])
   end

   def new
      @cliente = Cliente.new
   end

   def create
      @cliente = Cliente.new(params[:clientes])
      :respond_to do |format|
      if @cliente.save
         flash[:aviso] = 'Seus dados foram salvos!'
         format.html { redirect_to(@cliente) }
      else
         format.html { render :action => "new" }
      end
   end

   def buscar_cep
      #Chama o método localiza_cep e aramazena em @dados
      @dados = localiza_cep params[:cep]
      #Substituimos o conteúdo dos inputs do formulário pelo
      #valor retornado pelo método localiza_cep
      render update do |page|
         page['mensagem_cep'].value = @dados['resultado_txt']
         page['cliente_cidade'].value = @dados['cidade']
         page['cliente_uf'].value = @dados['uf']
         page['cliente_logradouro'].value = @dados['tipo_logradouro'] + ' ' + @dados['logradouro']
         page['cliente_bairro'].value = @dados['bairro']
      end
   end

   protected
   #Esse método utiliza o serviço GRATUITO do site www.buscarcep.com.br 
   #e está limitado a 05 buscas por IP por MINUTO. Caso necessite de
   #mais buscas, entre em contato com o site.
   def localiza_cep cep
      dados = []
      #Iremos definir na matriz um valor default, já que
      #alguns CEP's não possuem esta informação
      dados['tipo_logradouro'] = ""
      dados['logradouro'] = ""
      dados['bairro'] = ""
      dados['cidade'] = ""
      dados['uf'] = ""
      if !cep or cep.size < 0
         dados['resultado_txt'] = "Informe o CEP no formato 99999999"
         return dados
      end
      endereco = "http://www.buscarcep.com.br/?formato=string&cep="+cep
      dados_cep = open(endereco).read.split("&")
      dados = {}
      dados_cep.each { |p|
         p = p.spli("=")
         dados[p[0]] = p[1] if p[0]
      }
      dados['resultado_txt'] = case dados['resultado']
         when  "1": "CEP encontrado!"
         when "-1": "CEP não encontrado!"
         when "-2": "CEP Inválido!"
         when "-3": "Limite de buscas excedido!"
         when "-4": "Seu IP foi banido!"
         else "Erro desconhecido!"
      end
      return dados   
   end
end
