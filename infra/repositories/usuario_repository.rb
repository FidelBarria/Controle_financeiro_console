require 'sqlite3'
require_relative '../controle_financeiro_db'

class UsuarioRepository
    def initialize
      @db = ControleFinanceiroDb.conexao
    end

    def salvar_usuario(usuario)
      @db.execute("INSERT INTO usuario (nome, email, senha) values (?, ?, ?)", [usuario.nome, usuario.email, usuario.senha])
    end

    def logar_usuario(usuario)
     lista_usuario = @db.execute("SELECT * FROM usuario WHERE nome = ? AND senha = ?", [usuario.nome, usuario.senha])
     if lista_usuario.any? then 
      true
     end
    end

    def editar_usuario(usuario, id)
      @db.execute("UPDATE usuario SET nome = ?, email = ?, senha = ? WHERE id = ?",
        [usuario.nome, usuario.email, usuario.senha, id])
    end

    def pesquisar_usuario
      @db.execute("SELECT * FROM usuario")
    end
end