require_relative 'ui/tela_login'
require_relative 'ui/tela_dashboard'
require_relative 'infra/controle_financeiro_db'
require_relative 'ui/tela_cadastro'


ControleFinanceiroDb.atualiza_banco
puts "Enter para continuar."
gets
TelaLogin.menu


