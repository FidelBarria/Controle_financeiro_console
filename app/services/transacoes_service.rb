
class TransacoesServices
  def initialize
    @transacoes_repository = TransacoesRepository.new
  end
  
  def inserir_transacao(valor:, data:, categoria_id:, usuario_id:)
    transacoes = Transacoes.new(
      valor: valor,
      data: data,
      usuario_id: usuario_id,
      categoria_id: categoria_id
    )
    @transacoes_repository.inserir_transacao(transacoes)
  end

  def listar_transacoes(usuario_id)
        @transacoes_repository.listar_transacoes(usuario_id)
  end

  def saldo_transacoes_usuario_id(usuario_id)
    listar_transacoes = @transacoes_repository.listar_transacoes(usuario_id) || []
    listar_transacoes.map{|u| u["valor"].to_f}.select{|h| h.positive?}.sum
  end

  def saldo_despesa_usuario_id(usuario_id)
    listar_transacoes = @transacoes_repository.listar_transacoes(usuario_id) || []
    listar_transacoes.map{|u| u["valor"].to_f}.select{|h| h.negative?}.sum      
  end
end