# V360 To Do List - Backend

Este é o backend da aplicação de gerenciamento de tarefas (To-Do List) desenvolvida para o desafio técnico da V360. A API foi construída utilizando Ruby on Rails.

## Frontend

Esta API é consumida por um cliente React disponível no repositório: [To-Do-List-V360 - Frontend](https://github.com/ArturKioshi/To-Do-List-V360---Frontend)

## Tecnologias
- Ruby 3.3.4 / Rails 8.1.2
- PostgreSQL

## Instalação e Uso

- Clonar o repositório:

```
git clone url_do_repositorio
cd v360-tasks-backend
```

Este projeto utiliza o arquivo .env para gerenciar as configurações do banco de dados.

Na raiz do projeto backend, crie um arquivo chamado .env:

```
DATABASE_USER=admin
DATABASE_PASSWORD=admin
DATABASE_HOST=localhost
DATABASE_PORT=5432
DATABASE_NAME_DEVELOPMENT=v360_todo_list_development
DATABASE_NAME_TEST=v360_todo_list_test
```

- Configurar as dependências

```
bundle install
```

- Configurar o banco de dados

```
rails db:prepare
```

- Rodar o servidor

```
rails server
```

A API estará disponível em http://localhost:3000

- Endpoints da API
## Todo Lists (Listas de Tarefas)

| Método | Endpoint | Descrição |
| :--- | :--- | :--- |
| `GET` | `/api/v1/todo_lists` | Lista todas as listas de tarefas |
| `POST` | `/api/v1/todo_lists` | Cria uma nova lista |
| `GET` | `/api/v1/todo_lists/:id` | Detalhes de uma lista específica |
| `PATCH` | `/api/v1/todo_lists/:id` | Atualiza o título/descrição de uma lista |
| `DELETE` | `/api/v1/todo_lists/:id` | Remove uma lista e todos os seus itens |

## Todo Item (Tarefa)

| Método | Endpoint | Descrição |
| :--- | :--- | :--- |
| `GET` | `/api/v1/todo_lists/:list_id/todo_items` | Lista itens de uma lista específica |
| `POST` | `/api/v1/todo_lists/:list_id/todo_items` | Cria uma tarefa dentro de uma lista |
| `GET` | `/api/v1/todo_items` | Lista global de todas as tarefas do sistema |
| `GET` | `/api/v1/todo_items/:id` | Detalhes de uma tarefa específica |
| `PATCH` | `/api/v1/todo_items/:id` | Atualiza uma tarefa (ex: completar ou mudar título) |
| `DELETE` | `/api/v1/todo_items/:id` | Remove uma tarefa permanentemente |