# README

Esta documentação está voltada para ensinar como rodar o programa localmente

## Passos:

* Clone o repositório
    `git clone https://github.com/ThalissonMelo/brands.git`

* Instale o mysql se ainda não possuir
    `sudo apt-get install mysql-server`
    `sudo apt-get install libmysqlclient-dev`

* Insira no `config/database.yml` a senha do mysql no seu computador pessoal
    
    `

      adapter: mysql2

      encoding: utf8

      pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

      username: root

      password: ************

      host: localhost

    ` 

* Após mudar e salvar rode o comando `bundle install`

* Depois faça as migrações do banco
    
    `rails db:create`
    `rails db:migrate`
    
    * Para dropar o banco de dados use
        `rails db:drop`

* Por fim rode o comando `rails server` ou `rails s`

## Endpoints

* `localhost:3000/users`
    * POST: Cria um usuário com as seguintes informações:

        `
        {
            "name": "Teste",
            "email": "teste@teste.com",
            "password": "123456"
        }
        `
    * GET: Mostra todos os usuários criados

* `localhost:3000/users/:id`
    * GET: Mostra o usuário com id específicado
    * PUT: Possibilita edição do usuário no mesmo formato do post de criação
    * DELETE: Possibilita a deleção de um usuário


* `localhost:3000/users/:id/follow`
    * POST: Para seguir uma marca basta mandar o id da mesma para este endpoint em um post da seguinte forma:
        
        `
        {
            "brand_id": 3
        }
        `
    * DELETE: Para deixar de seguir uma marca basta utilizar esse endpoint com um DELETE e o seguinte body json
        
        `
        {
            "brand_id": 3
        }
        `

        Obs.: O id da marca é tratado como um número inteiro, por isso, no post, o número inteiro não deve ter aspas.

* `localhost:3000/users/:id/brands`
    * GET: Mostra as marcas que um usuário segue

* `localhost:3000/users/:id/invite`
    * POST: Manda um convite de amizade para um usuário com o json no seguinte formato

        `
        {
            "user_id": 3
        }
        `

        O Id que for mandado no json é o id do usuário que se deseja convidar

* `localhost:3000/users/:id/invites`
    * GET: Retorna um json com todos os convites recebidos pelo usuários

* `localhost:3000/users/:id/accept_friendship`
    * POST: Neste endpoint é possível aceitar um convite de amizade recebido, basta mandar um json com o id do usuário que convidou, da seguinte forma:

        `
        {
            "user_id": 3
        }
        `

        Todos os usuários tem um lista com os id's dos usuários que o mandaram um convite de amizade, basta mandar um post com o id de algum desses usuários da lista para aceitar a amizade.

        A partir desse momento os usuários passam a estar na lista de amigos um do outro.


* `localhost:3000/users/:id/friends`
    * GET: Retorna um json com todos os amigos do usuário

* `localhost:3000/brands`
    * POST: Cria uma marca com as seguintes informações:

        `
        {
            "name": "Marca"
        }
        `
    * GET: Mostra todos as marcas criados

* `localhost:3000/brands/:id`
    * GET: Mostra a marca com id específicado
    * PUT: Possibilita edição da marca no mesmo formato do post de criação
    * DELETE: Possibilita a deleção de uma marca

* `localhost:3000/brands/:brand_id/products`
    * POST: Cria um produto com as seguintes informações:

        `
        {
            "name": "Produto",
            "brand_id: 1
        }
        `
    * GET: Mostra todos os produtos criados

* `localhost:3000/brands/:brand_id/products/:id`
    * GET: Mostra o produto com id específicado
    * PUT: Possibilita edição do produto no mesmo formato do post de criação
    * DELETE: Possibilita a deleção de um produto


## Testes

* Para rodar os testes basta rodar o comando `rspec .`
