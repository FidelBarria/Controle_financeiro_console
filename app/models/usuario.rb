
class Usuario 
    attr_reader :nome, :email, :senha
    def initialize (nome:, email:, senha:)
      @nome = nome
      @email = email
      @senha = senha
    end


end