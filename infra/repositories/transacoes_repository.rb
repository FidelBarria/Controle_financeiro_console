class TransacoesRepository
    def initialize
    @db = ControleFinanceiroDb.conexao
    end

    def inserir_transacao(transacao)
            @db.execute("INSERT INTO transacoes (valor, data_transacao, categoriaId, usuarioId) VALUES (?, ?, ?, ?)", 
            [transacao.valor, transacao.data, transacao.categoria_id, transacao.usuario_id])
    end

    def listar_transacoes(usuario_id)
            @db.execute("SELECT transacoes.id, categoria.nome AS nome_categoria, transacoes.valor, transacoes.data_transacao, usuario.nome FROM transacoes
                        INNER JOIN categoria ON transacoes.categoriaId = categoria.id
                        INNER JOIN usuario ON transacoes.usuarioId = usuario.id
                        where transacoes.usuarioId = ?", [usuario_id])  
    end

    def listar_transacoes_despesa_data(usuario_id, inicio_mes, final_mes)
           @db.execute("SELECT transacoes.id, categoria.nome AS nome_categoria, transacoes.valor, transacoes.data_transacao, usuario.nome FROM transacoes
                        INNER JOIN categoria ON transacoes.categoriaId = categoria.id
                        INNER JOIN usuario ON transacoes.usuarioId = usuario.id
                        where transacoes.usuarioId = ? AND valor < 0 AND DATE(data_transacao) BETWEEN ? AND ?", [usuario_id, inicio_mes.to_s, final_mes.to_s])   
    end

    def listar_transacoes_receita_data(usuario_id, inicio_mes, final_mes)
                @db.execute("SELECT transacoes.id, categoria.nome AS nome_categoria, transacoes.valor, transacoes.data_transacao, usuario.nome FROM transacoes
                        INNER JOIN categoria ON transacoes.categoriaId = categoria.id
                        INNER JOIN usuario ON transacoes.usuarioId = usuario.id
                        where transacoes.usuarioId = ? AND valor > 0 AND DATE(data_transacao) BETWEEN ? AND ?", [usuario_id, inicio_mes.to_s, final_mes.to_s])               
    end

    def listar_transacoes_positivo(usuario_id)
                @db.execute("SELECT transacoes.id, categoria.nome AS nome_categoria, transacoes.valor, transacoes.data_transacao, usuario.nome FROM transacoes
                        INNER JOIN categoria ON transacoes.categoriaId = categoria.id
                        INNER JOIN usuario ON transacoes.usuarioId = usuario.id
                        where transacoes.usuarioId = ? AND valor > 0", [usuario_id])       
    end

    def listar_transacoes_negativo(usuario_id)
                @db.execute("SELECT transacoes.id, categoria.nome AS nome_categoria, transacoes.valor, transacoes.data_transacao, usuario.nome FROM transacoes
                        INNER JOIN categoria ON transacoes.categoriaId = categoria.id
                        INNER JOIN usuario ON transacoes.usuarioId = usuario.id
                        where transacoes.usuarioId = ? AND valor < 0", [usuario_id])       
    end
end