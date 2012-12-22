class DadosIniciais < ActiveRecord::Migration
  #Este método irá adicionar alguns registros na
  #tabela de Grupos.
  def up
     #Se tiver algum registro, vamos apagar tudo antes
     #de inserir os dados iniciais
     Grupo.delete_all 
     Grupo.create(:descricao => 'Cestas');
     Grupo.create(:descricao => 'Bouquets');
     Grupo.create(:descricao => 'Arranjos');
  end

  def down
     Grupo.delete_all 
  end
end
