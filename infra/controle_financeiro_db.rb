require 'sqlite3'

class ControleFinanceiroDb

  def self.conexao
    @db ||= SQLite3::Database.new("db/controle_financeiro.db").tap do |db|
          db.results_as_hash = true
          db.busy_timeout = 3000 # 🔥 importante
    end
  end

  def self.atualiza_banco
  db = SQLite3::Database.open ("db/controle_financeiro.db")
  db.results_as_hash = true

  db.execute <<-SQL 
    CREATE TABLE IF NOT EXISTS usuario (
      id INTEGER PRIMARY KEY,
      nome TEXT,
      email TEXT,
      senha TEXT
    );
  SQL
  db.close
    puts "Banco atualizado."
  end

end