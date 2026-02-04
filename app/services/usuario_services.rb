require_relative '../models/usuario'
require_relative '../../infra/repositories/usuario_repository'

class UsuarioService
    def initialize
      @usuario_repository = UsuarioRepository.new
    end

    def cadastra_usuario(nome: , email: , senha:)
      usuario = Usuario.new(
                 nome: nome,
                 email: email,
                 senha: senha
                )
      @usuario_repository.salvar_usuario(usuario)
    end
end
