require 'sqlite3'
require_relative '../controle_financeiro_db'

class UsuarioRepository
    def initialize
      @db = SQLite3::Database.open("db/controle_financeiro.db")
      @db.results_as_hash = true
    end

    def salvar_usuario(usuario)
      @db.execute("INSERT INTO usuario (nome, email, senha) values (?, ?, ?)", [usuario.nome, usuario.email, usuario.senha])
    end
end