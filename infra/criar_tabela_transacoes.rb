require 'sqlite3'

class CriarTabelaTransacaoes
  def self.conexao
    SQLite3::Database.open("db/controle_financeiro.db").tap do |db|
      db.results_as_hash = true
      db.busy_timeout = 3000
    end
  end

  def self.cria_tabela_transacoes
    db = conexao
    db.execute <<-SQL 
      CREATE TABLE IF NOT EXISTS transacoes (
        id INTEGER PRIMARY KEY,
        valor DECIMAL,
        data_transacao date,
        categoriaId INTEGER,
        usuarioId INTEGER,
            CONSTRAINT fk_produto_categoria 
        FOREIGN KEY (categoriaId) REFERENCES categoria(id) ON DELETE CASCADE,
            CONSTRAINT fk_usuario 
        FOREIGN KEY (usuarioId) REFERENCES usuario(id) ON DELETE CASCADE
      ); 
      SQL
      puts "Banco atualizado."
  end
end