require 'tty-box'
require 'date'

class TelaDashboard


  def self.header(nome)
    box = TTY::Box.frame("Bem vindo #{@nome} ao seu Dashboard financeiro.", width: 100, align: :center, padding: 1)
    puts box
  end

  def self.caixa_saldos
    tamanho_tela = TTY::Screen.width
    box_largura = tamanho_tela/2
    hoje = Date.today
    data_inicial = Date.new(hoje.year, hoje.month, 1)
    data_final = Date.new(hoje.year, hoje.month, -1)
    box_receita_total = TTY::Box.frame("Receita Total: R$ #{@saldo_receita}", width: box_largura, align: :center, padding: 1)
    box_despesa_total = TTY::Box.frame("Despesa Total: R$ #{@saldo_despesa}", width: box_largura, align: :center, padding: 1)
    box_saldo_mes = TTY::Box.frame("Saldo Total do mês #{data_inicial} a #{data_final}: R$ #{@saldo_total_mes}", width: box_largura, align: :center, padding: 1)
    box_despesa_mes = TTY::Box.frame("Despesa Total do mês #{data_inicial} a #{data_final}: R$ #{@saldo_despesa_mes}", width: box_largura, align: :center, padding: 1)
    box_saldo_total = TTY::Box.frame("Saldo Real: R$ #{@saldo_total}", width: box_largura, align: :center, padding: 1)
    puts box_saldo_mes 
    puts box_despesa_mes 
    puts box_receita_total
    puts box_despesa_total
    puts box_saldo_total
    puts "\n"
  end

  def self.logar
    prompt = TTY::Prompt.new
    @nome = prompt.ask("Usuario: ")
    senha = prompt.mask("Senha:")
    @usuario_service = UsuarioService.new
    usuario_logado = @usuario_service.logar_usuario(nome: @nome, senha: senha)
    if usuario_logado
    system("cls") || system("clear")
    @id_usuario_logado = usuario_logado.id
    somar_saldo_mes
    somar_despesas_mes
    somar_receita
    somar_despesa
    saldo_total
    header(@nome)
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
      menu.choice "Votar.", :voltar
    end
      executa_opcao(opcao)
    end
  end

  private

  def self.executa_opcao(opcao)
    case opcao
    when :lista_transacao
      lista_transacao
    when :adiciona_transacao
      adiciona_transacao
    when :adiciona_categoria
      adiciona_categoria
    when :voltar
      voltar
    end
  end

  def self.lista_transacao
    system("cls") || system("clear")
    header(@nome)
    caixa_saldos
      @transacao_service = TransacoesServices.new
      lista_transacao = @transacao_service.listar_transacoes(@id_usuario_logado)
      table = TTY::Table.new(['Id', 'categoria', 'valor', 'data', 'usuario'], 
        lista_transacao.map{|u| [u["id"], u['nome_categoria'].to_s, u['valor'].to_i, u['data_transacao'], u['nome']]})
        puts table.render(:unicode)
    somar_saldo_mes
    somar_despesas_mes
    somar_receita
    somar_despesa
    saldo_total
  end

  def self.adiciona_transacao
    prompt = TTY::Prompt.new
    @categoria_service = CategoriaService.new
    puts "Informe valor, data e categoria: "
    lista_categoria = @categoria_service.listar_categoria
    id_categoria = prompt.select("Selecione a despesa ou receita:") do |menu|
            lista_categoria.each do |lista|
                menu.choice lista["nome"], lista["id"]
            end
    end
    valor = prompt.ask("valor: ").to_f
    data = prompt.select("data: ") do |menu|
            hoje = Date.today
            data_inicial = Date.new(hoje.year, hoje.month, 1)
            data_final = Date.new(hoje.year, hoje.month, -1)
            while data_inicial < data_final
                menu.choice data_inicial
                data_inicial+=1
            end
    end
    tipo = lista_categoria.find{|t| t["id"] == id_categoria}
    if tipo["tipo"] == "DESPESA"
        valor = -valor
    end
    @transacao_service = TransacoesServices.new
    @transacao_service.inserir_transacao(valor: valor, data: data, categoria_id: id_categoria, usuario_id: @id_usuario_logado)
    system("cls") || system("clear")
    somar_saldo_mes
    somar_despesas_mes
    somar_receita
    somar_despesa
    saldo_total
    header(@nome)
    caixa_saldos
    menu
  end

  def self.adiciona_categoria
    prompt = TTY::Prompt.new
    puts "Informe nome e tipo da categoria para adicionar."
    nome_categoria = prompt.ask("Nome Categoria: ")
    tipo_categoria = prompt.select("Selecione o tipo de Categoria:") do |menu|
            menu.choice "RECEITA", "RECEITA"
            menu.choice "DESPESA", "DESPESA"
    end
    @categoria_service = CategoriaService.new
    @categoria_service.inserir_categoria(nome: nome_categoria, tipo: tipo_categoria)
    system("cls") || system("clear")
    somar_saldo_mes
    somar_despesas_mes
    somar_receita
    somar_despesa
    saldo_total
    header(@nome)
    caixa_saldos
    menu
  end

  def self.somar_saldo_mes
    hoje = Date.today
    inicio_mes = Date.new(hoje.year, hoje.month, 1)
    final_mes = Date.new(hoje.year, hoje.month, -1)
    @transacao_service = TransacoesServices.new
    @saldo_total_mes = @transacao_service.saldo_receita_usuario_data(@id_usuario_logado, inicio_mes, final_mes)
  end

  def self.somar_despesas_mes
    hoje = Date.today
    inicio_mes = Date.new(hoje.year, hoje.month, 1)
    final_mes = Date.new(hoje.year, hoje.month, -1)
    @transacao_service = TransacoesServices.new
    @saldo_despesa_mes = @transacao_service.saldo_despesa_usuario_data(@id_usuario_logado, inicio_mes, final_mes)
  end

  def self.somar_despesa
    @transacao_service = TransacoesServices.new
    @saldo_despesa = @transacao_service.saldo_despesa_total(@id_usuario_logado) 
  end

  def self.somar_receita
    @transacao_service = TransacoesServices.new
    @saldo_receita = @transacao_service.saldo_receita_total(@id_usuario_logado) 
  end

  def self.saldo_total
    @transacao_service = TransacoesServices.new
    @saldo_total = @transacao_service.saldo_real(@id_usuario_logado)     
  end

  def self.voltar
    TelaLogin.menu
  end

end