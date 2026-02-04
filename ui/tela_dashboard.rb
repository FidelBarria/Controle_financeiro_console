require 'tty-box'

class TelaDashboard
  def self.header
    box = TTY::Box.frame("Dashboard: ", width: 50, align: :center, padding: 1)
    puts box
  end

  def self.logar
    prompt = TTY::Prompt.new
    nome = prompt.ask("Usuario: ")
    senha = prompt.mask("Senha:")
    @usuario_service = UsuarioService.new
    @usuario_service.logar_usuario(nome: nome, senha: senha)
  end

  def self.menu
    system("cls") || system("clear")
    header
    puts "logado"
    gets
  end

end