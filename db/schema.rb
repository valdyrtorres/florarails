# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121227220050) do

  create_table "clientes", :force => true do |t|
    t.string   "cep",             :limit => 8
    t.string   "nome",            :limit => 60,  :null => false
    t.string   "telefone",        :limit => 13
    t.string   "cidade",          :limit => 60
    t.string   "uf",              :limit => 2
    t.string   "tipo_logradouro", :limit => 20
    t.string   "logradouro",      :limit => 100
    t.string   "complemento",     :limit => 20
    t.string   "bairro",          :limit => 60
    t.string   "email",           :limit => 60,  :null => false
    t.string   "senha",           :limit => 100, :null => false
    t.string   "cpf",             :limit => 14,  :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "clientes", ["cpf"], :name => "index_clientes_on_cpf", :unique => true

  create_table "grupos", :force => true do |t|
    t.string   "descricao"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "produtos", :force => true do |t|
    t.string   "titulo"
    t.text     "descricao"
    t.decimal  "preco"
    t.date     "validade"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "grupo_id",            :default => 1, :null => false
    t.string   "imagem_file_name"
    t.string   "imagem_content_type"
    t.integer  "imagem_file_size"
    t.datetime "imagem_updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

end
