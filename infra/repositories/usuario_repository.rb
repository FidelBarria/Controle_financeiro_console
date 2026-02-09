require 'sqlite3'
require_relative '../controle_financeiro_db'

class UsuarioRepository
    def initialize
      @db = ControleFinanceiroDb.conexao
    end

    def salvar_usuario(usuario)
      @db.execute("INSERT INTO usuario (nome, email, senha, usuario) values (?, ?, ?, ?)", [usuario.nome, usuario.email, usuario.senha, usuario.usuario])
    end

    def logar_usuario(usuario)
     @db.get_first_row("SELECT id, nome, senha FROM usuario WHERE nome = ?", [usuario.nome])
    end

    def editar_usuario(usuario, id)
      @db.execute("UPDATE usuario SET nome = ?, email = ?, senha = ?, usuario = ? WHERE id = ?",
        [usuario.nome, usuario.email, usuario.senha, usuario.usuario, id])
    end

    def pesquisar_usuario
      @db.execute("SELECT * FROM usuario")
    end

    def usuario_existe?(usuario)
      !!@db.get_first_row("SELECT 1 FROM usuario WHERE usuario = ? LIMIT 1", usuario)      
    end
end