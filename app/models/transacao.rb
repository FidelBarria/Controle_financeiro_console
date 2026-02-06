class Transacoes
  attr_accessor :nome, :valor, :data, :categoria, :usuario_id, :categoria_id
  def initialize(nome:, valor:, data:, categoria:, usuario_id:, categoria_id:)
    @nome = nome
    @valor = valor
    @data = data
    @categoria = categoria
    @usuario_id = usuario_id
    @categoria_id = categoria_id
  end
end