
class Usuario 
    attr_reader :id, :nome, :email, :senha, :usuario
    def initialize (id:, nome: , email: , senha:, usuario: )
      @id = id
      @nome = nome
      @email = email
      @senha = senha
      @usuario = usuario 
    end


end