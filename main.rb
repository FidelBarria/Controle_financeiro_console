require_relative 'ui/tela_login'
require_relative 'infra/controle_financeiro_db'


ControleFinanceiroDb.atualiza_banco
puts "Enter para continuar."
gets
TelaLogin.menu


