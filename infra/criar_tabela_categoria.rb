require 'sqlite3'

class CriaTabelaCategoria
  def self.conexao
    SQLite3::Database.open("db/controle_financeiro.db").tap do |db|
      db.results_as_hash = true
      db.busy_timeout = 3000
    end
  end

  def self.cria_categoria
    db = conexao
    db.execute <<-SQL 
      CREATE TABLE IF NOT EXISTS categoria (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        tipo TEXT
      ); 
      SQL
      puts "Banco atualizado."
  end
end