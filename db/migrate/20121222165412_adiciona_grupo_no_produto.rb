class AdicionaGrupoNoProduto < ActiveRecord::Migration
  def up
     add_column :produtos, :grupo_id, :integer, 
     :null => false, 
     :default => 1, 
     :options => "CONSTRAINT flo_fk_pro_gru REFERENCES grupos(id)"
  end

  def down
     remove_column :produtos, :grupo_id
  end
end
