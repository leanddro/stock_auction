# Stock Auction

<p align="center">
  <img src="http://img.shields.io/static/v1?label=Ruby&message=3.2.1&color=red&style=for-the-badge&logo=ruby"/>
  <img src="http://img.shields.io/static/v1?label=Ruby%20On%20Rails%20&message=7.0.4.3&color=red&style=for-the-badge&logo=ruby"/>
  <img src="http://img.shields.io/static/v1?label=TESTES&message=%3E100&color=GREEN&style=for-the-badge"/>
	<img src="http://img.shields.io/static/v1?label=STATUS&message=EM%20DESENVOLVIMENTO&color=RED&style=for-the-badge"/>
</p>

### Tópicos

:diamond_shape_with_a_dot_inside: [Descrição do projeto](#descrição-do-projeto)

:diamond_shape_with_a_dot_inside: [Modelo ER](#modelo-er)

:diamond_shape_with_a_dot_inside: [Funcionalidades](#funcionalidades)

:diamond_shape_with_a_dot_inside: [Pré-requisitos](#pré-requisitos)

:diamond_shape_with_a_dot_inside: [Como rodar a aplicação](#como-rodar-a-aplicação)

## Descrição do projeto

<p align="justify">
  E uma aplicação web em Ruby on Rails com funcionalidade de conectar o publico com itens que estão defasados ou com pequenas avarias, assim podendo ser comercializado novamente pelo meio escolhido de leilão. Este e um projeto que faz da primeira etapa de treinamento do TreinaDev.
</p>

## Modelo ER
## Funcionalidades

:white_check_mark: Cadastro de usuários dos tipos(Admin, Regular)

:white_check_mark: Gerenciamento de categorias de produtos(itens)

:white_check_mark: Cadastro de produtos(itens) disponíveis para leilão

:white_check_mark: Detalhes de produtos(itens)

:white_check_mark: Adicionar imagem ao produto

:white_check_mark: Iniciar novo lote com informações de data e lances

:white_check_mark: Adicionar produtos(itens) em lotes

:white_check_mark: Muda status do lote de pendente para aprovado

:white_check_mark: Usuário(regular) logado faz lances em lotes disponíveis

:white_check_mark: Acompanhamento de lances recebidos nos lotes

:white_check_mark: Finalizar o leilão quando a lances quando não cancelar

:white_check_mark: Dúvidas/comentários e respostas sobre um lote

## Pré-requisitos

:warning: [Ruby: versão 3.2.1](https://www.ruby-lang.org/en/downloads/)

:warning: [Ruby on Rails: versão 7.0.4.3](https://rubygems.org/gems/rails/versions/7.0.4.3)

:warning: [Node](https://nodejs.org/en/download/)

:warning: [Yarn](https://yarnpkg.com/getting-started/install)

:warning: [SQLite](https://www.sqlite.org/download.html)

## Como rodar a aplicação

No terminal, clone o projeto:

```sh
git clone https://github.com/leanddro/stock_auction
```

Entre na pasta do projeto:

```sh
cd stock_auction
```

Comando para configuração inicial

```sh
./bin/setup
```
Rodando aplicação

```sh
./bin/dev
```
Acesse a aplicação em seu navegador através do endereço http://localhost:3000.
Para fazer login use os dados abaixo.
| nome    | E-mail                      | password | Tipo          |
| ------- | --------------------------- | -------- | ------------- |
| Admir   | admir@leilaodogalpao.com.br | password | Administrador |
| Ana     | ana@leilaodogalpao.com.br   | password | Administrador |
| Leandro | leandro@email.com           | password | Regular       |
| João    | joao@email.com              | password | Regular       |

## Como rodar os testes

Toda aplicação tem testes automatizados que podem ser executado rodando o comando abaixo

```sh
rspec
```
Para ver a cobertura de teste e só abrir o arquivo index ou executar um http server na pasta coverage.

## TODO

:white_square_button: Bloqueio de CPF

:white_square_button: Lote favorito

:white_square_button: Buscar por produto
