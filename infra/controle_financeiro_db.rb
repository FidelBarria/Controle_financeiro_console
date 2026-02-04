require 'sqlite3'

class ControleFinanceiroDb

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