require 'tty-box'

class TelaDashboard


  def self.header(nome)
    box = TTY::Box.frame("Bem vindo #{nome} ao seu Dashboard financeiro.", width: 100, align: :center, padding: 1)
    puts box
  end

  def self.caixa_saldos
    tamanho_tela = TTY::Screen.width
    box_largura = tamanho_tela/2
    box_saldo = TTY::Box.frame("Saldo: R$ 5000", width: box_largura, align: :center, padding: 1)
    box_despesa = TTY::Box.frame("Despesa: R$ -6000", width: box_largura, align: :center, padding: 1)
    puts box_saldo 
    puts box_despesa 
    puts "\n"
  end

  def self.logar
    prompt = TTY::Prompt.new
    nome = prompt.ask("Usuario: ")
    senha = prompt.mask("Senha:")
    @usuario_service = UsuarioService.new
    if @usuario_service.logar_usuario(nome: nome, senha: senha) 
    system("cls") || system("clear")
    header(nome)
    caixa_saldos
    menu
    end
  end

  private

  def self.menu
    prompt = TTY::Prompt.new
    loop do
    opcao = prompt.select("Escolha uma das opções de dashboard:") do |menu|
      menu.choice "Lista de transações.", :lista_transacao
      menu.choice "Adicionar transação.", :adiciona_transacao
      menu.choice "Adicionar categoria.", :adiciona_categoria
    end
    end
    gets
  end

  private

  def self.executa_opcao(opcao)
    case opcao
    when :lista_transacao
      lista_transacao
    when :adiciona_transacao
      adiciona_transacao
    when :adiciona_categoria
  end

  def adiciona_transacao
    
  ends

end