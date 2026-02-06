require 'tty-prompt'
require 'tty-box'
require 'tty-table'
require_relative '../app/services/usuario_services'
require_relative '../ui/tela_login'


class TelaCadastro
    def self.header
      box = TTY::Box.frame("Cadastrar Usuario.", width: 100, align: :center, padding: 1)
      puts box
    end

    def self.menu
      system("clear") || system("cls")
      header
      prompt = TTY::Prompt.new
      loop do
        opcao = prompt.select("Selecione a opç~cao de usuario abaixo.") do |menu|
          menu.choice "Pesquisar todos os Usuarios", :pesquisar_usuario
          menu.choice "Cadastrar Usuario", :cadastrar_usuario
          menu.choice "Editar Usuario", :editar_usuario
          menu.choice "Voltar.", :voltar
          menu.choice "Sair.", :sair
        end
        executa_opcao(opcao)
      end
    end

    private

    def self.executa_opcao(opcao)
      case opcao
      when :pesquisar_usuario
        pesquisar_usuario
      when :cadastrar_usuario
        cadastra_usuario
      when :editar_usuario
        editar_usuario
      when :voltar
        voltar
      when :sair
        sair
      end
    end

    def self.voltar
      TelaLogin.menu
    end

    def self.pesquisar_usuario
      system("clear") || system("cls")
      header
      @usuario_service = UsuarioService.new
      lista_usuario = @usuario_service.pesquisar_usuario()
      if lista_usuario.empty?
        puts "Nenhum Usuario encontrado."
        return
      end

      table = TTY::Table.new(['is', 'nome', 'usuario', 'email', 'senha'], 
      lista_usuario.map{|u| [u['id'], u['nome'], u['usuario'], u['email'], u['senha']]})
      puts table.render(:unicode)
    end

    def self.editar_usuario
      system("clear") || system("cls")
      header
      prompt = TTY::Prompt.new
      puts "Informe o ID do usuario e depois as informações que quer alterar."
      id = prompt.ask(message = "id: ")
      usuario = prompt.ask(message = "Usuario: ")
      nome = prompt.ask(message = "nome: ")
      email = prompt.ask(message = "email: ")
      senha = prompt.ask(message = "senha: ")
      @usuario_service = UsuarioService.new
      @usuario_service.editar_usuario(id, nome: nome, email: email, senha: senha, usuario: usuario)
    end

    def self.cadastra_usuario
      system("clear") || system("cls")
      header
      prompt = TTY::Prompt.new
      usuario = prompt.ask(message = "Usuario: ")
      nome = prompt.ask(message = "Nome: ")
      email = prompt.ask(message = "Email: ")
      senha = prompt.mask(message = "Senha: ")
      @usuario_service = UsuarioService.new
      begin
      @usuario_service.cadastra_usuario(nome: nome, email: email, senha: senha, usuario: usuario)
      prompt.ok("Usuario cadastrado com sucesso!!")
      rescue RuntimeError => e
        prompt.error(e.message)
        prompt.keypress("Pressione qualquer tecla para continuar!!")
      end
    end

    def self.sair
      system("cls") || system('clear')
      puts "Ate logo!!"
      exit
    end
end

