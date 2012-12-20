class GruposController < ApplicationController
  def index
     @grupos = Grupo.find(:all)
  end

  def show
     @grupo = Grupo.find(params[:id])
  end

  def new
     @grupo = Grupo.new
  end

  def create
     @grupo = Grupo.new(params[:grupo])
     if @grupo.save 
        flash[:aviso] = 'Grupo salvo com sucesso!'
     else
        flash[:erro] = 'Erro ao salvar o grupo'
     end
     redirect_to(@grupo)
  end

  def edit
     @grupo = Grupo.find(params[:id])
  end

  def update
     @grupo = Grupo.find(params[:id])
     if @grupo.update_attributes(params[:grupo])
        flash[:aviso] = "Grupo atualizado com sucesso."
        redirect_to(@grupo)
     end
  end

  def destroy
     @grupo = Grupo.find(params[:id])
     @grupo.destroy
     flash[:info] = "Grupo excluido com sucesso"
     redirect_to(grupos_path)
  end
end
