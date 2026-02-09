class Transacoes
  attr_accessor :valor, :data, :categoria, :usuario_id, :categoria_id
  def initialize( valor:, data:, usuario_id:, categoria_id:)
    @valor = valor
    @data = data
    @usuario_id = usuario_id
    @categoria_id = categoria_id
  end
end