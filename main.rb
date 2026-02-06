require_relative 'ui/tela_login'
require_relative 'ui/tela_dashboard'
require_relative 'infra/controle_financeiro_db'
require_relative 'ui/tela_cadastro'
require_relative 'infra/criar_tabela_categoria'
require_relative 'infra/criar_tabela_transacoes'


#ControleFinanceiroDb.atualiza_banco
#ControleFinanceiroDb.alterar_usuario
#CriaTabelaCategoria.cria_categoria
CriarTabelaTransacaoes.cria_tabela_transacoes
puts "Enter para continuar."
gets
TelaLogin.menu


