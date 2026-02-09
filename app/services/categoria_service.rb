class CategoriaService
  def initialize
    @categoria_repository = CategoriaRepository.new
  end

  def inserir_categoria(nome:, tipo:)
    categoria = Categoria.new(
      nome: nome,
      tipo: tipo
    )
    @categoria_repository.inserir_categoria(categoria)
  end

  def listar_categoria
        @categoria_repository.listar_categoria
  end
end