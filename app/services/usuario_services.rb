require_relative '../models/usuario'
require_relative '../../infra/repositories/usuario_repository'

class UsuarioService
    def initialize
      @usuario_repository = UsuarioRepository.new
    end

    def pesquisar_usuario
      @usuario_repository.pesquisar_usuario
    end

    def cadastra_usuario(nome: , email: , senha:, usuario:)
      if @usuario_repository.usuario_existe?(usuario)
        raise "Usuario ja cadastrado com esse usuario." 
      else
        usuario = Usuario.new(nome: nome, email: email, senha: senha, usuario: usuario)
        @usuario_repository.salvar_usuario(usuario)
      end
    end

    def editar_usuario(id, nome:, email:, senha:, usuario:)
      usuario = Usuario.new(nome: nome, email: email, senha: senha, usuario: usuario)
      @usuario_repository.editar_usuario(usuario, id)
    end

    def logar_usuario(nome:, senha:)
      usuario = Usuario.new( nome: nome, email: "", senha: senha, usuario: "")
      logado = @usuario_repository.logar_usuario(usuario)
      if logado then 
        true
      end
    end
end
