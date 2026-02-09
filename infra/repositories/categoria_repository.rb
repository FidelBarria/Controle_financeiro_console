class CategoriaRepository
  def initialize
    @db = ControleFinanceiroDb.conexao
  end

  def inserir_categoria(categoria)
        @db.execute("INSERT INTO categoria (nome, tipo) VALUES (?, ?)", [categoria.nome, categoria.tipo])
  end

  def listar_categoria
        @db.execute("SELECT * FROM categoria")
  end
end