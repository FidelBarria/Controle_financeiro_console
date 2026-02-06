require 'sqlite3'

class ControleFinanceiroDb
  def self.conexao
    SQLite3::Database.open("db/controle_financeiro.db").tap do |db|
      db.results_as_hash = true
      db.busy_timeout = 3000
    end
  end

  def self.atualiza_banco
    db = conexao
    db.execute <<-SQL 
      CREATE TABLE IF NOT EXISTS usuario (
        id INTEGER PRIMARY KEY,
        nome TEXT,
        email TEXT,
        senha TEXT
      ); 
      SQL
      puts "Banco atualizado."
  end

  def self.alterar_usuario
        db = conexao
        db.execute <<-SQL
                  ALTER TABLE IF NOT EXISTS usuario ADD usuario TEXT
        SQL
  end

end