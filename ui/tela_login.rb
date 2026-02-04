
require 'tty-box'
require 'tty-prompt'
require 'tty-table'
require_relative 'tela_dashboard'
require_relative 'tela_cadastro'


class TelaLogin



    def self.header
        head = TTY::Box.frame("Controle Financeiro", width: 150, align: :center, padding: 1)
        puts head
    end

    def self.menu
        system("cls") || system('clear')
        header
        prompt = TTY::Prompt.new
        loop do 
          
          opcao = prompt.select("Escolha uma das opções a baixo.") do |menu|
            menu.choice "Logar.", :logar    
            menu.choice "Cadastrar.", :cadastrar 
            menu.choice "Sair.", :sair                          
          end  
            self.executa_opcao(opcao)
        end

    end
    private

    def self.executa_opcao(opcao)
          case opcao
            when :logar
              logar  
            when :cadastrar
              cadastrar
            when :sair
              fechar_programa        
          end
    end

    def self.logar
         TelaDashboard.header        
    end

    def self.cadastrar
          TelaCadastro.cadastra_usuario
    end

    def self.fechar_programa
            exit
    end
end