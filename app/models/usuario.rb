
class Usuario 
    attr_reader :nome, :email, :senha, :usuario
    def initialize (nome: , email: , senha:, usuario: )
      @nome = nome
      @email = email
      @senha = senha
      @usuario = usuario 
    end


end