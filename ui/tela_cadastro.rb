require 'tty-prompt'
require 'tty-box'
require_relative '../app/services/usuario_services'
require_relative '../ui/tela_login'


class TelaCadastro
    def self.header
      box = TTY::Box.frame("Cadastrar Usuario.", width: 150, align: :center, padding: 1)
      puts box
    end

    def self.cadastra_usuario
      system("clear") || system("cls")
      header
      prompt = TTY::Prompt.new
      nome = prompt.ask(message = "Nome: ")
      email = prompt.ask(message = "Email: ")
      senha = prompt.mask(message = "Senha: ")
      @usuario_service = UsuarioService.new
      @usuario_service.cadastra_usuario(nome: nome, email: email, senha: senha)
      TelaLogin.menu
    end
end

