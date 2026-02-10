
require 'date'
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

  def saldo_receita_usuario_data(usuario_id, inicio_mes, final_mes)
    listar_transacoes = @transacoes_repository.listar_transacoes_receita_data(usuario_id, inicio_mes, final_mes) || []
    listar_transacoes.map{|u| u["valor"].to_f}.sum
  end

  def saldo_despesa_usuario_data(usuario_id, inicio_mes, final_mes)
    listar_transacoes = @transacoes_repository.listar_transacoes_despesa_data(usuario_id, inicio_mes, final_mes) || []
    listar_transacoes.map{|u| u["valor"].to_f}.sum      
  end

  def saldo_receita_total(usuario_id)
    listar_transacoes = @transacoes_repository.listar_transacoes_positivo(usuario_id) || []
    listar_transacoes.map{|u| u["valor"].to_f}.sum    
  end

  def saldo_despesa_total(usuario_id)
    listar_transacoes = @transacoes_repository.listar_transacoes_negativo(usuario_id) || []
    listar_transacoes.map{|u| u["valor"].to_f}.sum    
  end

  def saldo_real(usuario_id)
    listar_transacoes = @transacoes_repository.listar_transacoes(usuario_id) || []
    listar_transacoes.map{|u| u["valor"].to_f}.sum        
  end
end