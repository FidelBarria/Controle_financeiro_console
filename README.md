# 💸 Controle Financeiro (Console Ruby)

Aplicação de controle financeiro pessoal em terminal (TUI), construída com **Ruby + SQLite**, com foco em cadastro de usuários, categorias e transações.

> Projeto acadêmico/prático em evolução para se tornar um case de portfólio.

## 📌 Status do projeto

**Em desenvolvimento** — funcional para uso local, com pontos de melhoria para produção e portfólio.

## ✨ Funcionalidades atuais

- Cadastro de usuários
- Edição de usuários
- Login
- Cadastro de categorias (`RECEITA` / `DESPESA`)
- Cadastro de transações
- Listagem de transações por usuário
- Cálculo de saldos:
  - saldo de receitas
  - saldo de despesas
  - saldo mensal
  - saldo total

## 🧱 Arquitetura

O projeto está organizado por camadas:

- **UI (`ui/`)**: interação com usuário no terminal (`TTY::Prompt`, `TTY::Box`, `TTY::Table`)
- **Services (`app/services/`)**: regras de negócio e orquestração
- **Repositories (`infra/repositories/`)**: queries SQL e acesso ao banco
- **Models (`app/models/`)**: entidades de domínio
- **Infra (`infra/`)**: conexão com banco e scripts de criação de tabelas

## 🗂️ Estrutura de pastas

```bash
.
├── main.rb
├── app/
│   ├── models/
│   └── services/
├── infra/
│   ├── controle_financeiro_db.rb
│   ├── criar_tabela_categoria.rb
│   ├── criar_tabela_transacoes.rb
│   └── repositories/
├── ui/
└── db/
    └── controle_financeiro.db
```

## ⚙️ Requisitos

- Ruby 3.x
- SQLite3
- Gems:
  - `sqlite3`
  - `tty-box`
  - `tty-prompt`
  - `tty-table`
  - `tty-screen`

## 🚀 Instalação

Como o projeto ainda não possui `Gemfile`, instale as dependências manualmente:

```bash
gem install sqlite3 tty-box tty-prompt tty-table tty-screen
```

## ▶️ Execução

Na raiz do projeto:

```bash
ruby main.rb
```

## 🧭 Fluxo de uso

1. Abrir o app.
2. Ir em **Cadastrar** e criar usuário.
3. Voltar ao menu inicial e **Logar**.
4. No dashboard:
   - cadastrar categorias;
   - adicionar transações;
   - listar transações e acompanhar saldos.

## 🗄️ Banco de dados

Banco local SQLite:

- `db/controle_financeiro.db`

Tabelas previstas no código:

- `usuario`
- `categoria`
- `transacoes`
