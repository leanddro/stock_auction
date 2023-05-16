require 'rails_helper'

RSpec.describe "Batches" do
  describe "patch /batches/:id/approve" do
    it 'retorna alerta de erro quando usuário criado tenta aprovar' do
      user = User.create!(name: 'Admir', cpf: '054.732.630-03', email: 'admir@leilaodogalpao.com.br', password: 'password')
      batch = Batch.create!(code: 'AcSx*1-mL', start_at: DateTime.now.next_day(10), end_at: DateTime.now.next_day(20), minimum_bid: 100, minimum_bid_difference: 10, create_by: user)

      login_as user

      patch "/batches/#{batch.id}/approve"
      follow_redirect!

      expect(response.body).to include 'Não foi possível aprovar lote'
    end

    it 'retorna alerta de erro quando lote não esta mais pendente' do
      user = User.create!(name: 'Admir', cpf: '054.732.630-03', email: 'admir@leilaodogalpao.com.br', password: 'password')
      leo = User.create!(name: 'Leo', cpf: '718.167.630-04', email: 'leo@leilaodogalpao.com.br', password: 'password')
      batch = Batch.create!(code: 'AcSx*1-mL', start_at: DateTime.now.next_day(10), end_at: DateTime.now.next_day(20), minimum_bid: 100, minimum_bid_difference: 10, create_by: user)
      batch.approved!

      login_as leo

      patch "/batches/#{batch.id}/approve"
      follow_redirect!

      expect(response.body).to include 'Não foi possível aprovar lote'
    end

    it 'retorna alerta de sucesso' do
      user = User.create!(name: 'Admir', cpf: '054.732.630-03', email: 'admir@leilaodogalpao.com.br', password: 'password')
      leo = User.create!(name: 'Leo', cpf: '718.167.630-04', email: 'leo@leilaodogalpao.com.br', password: 'password')
      batch = Batch.create!(code: 'AcSx*1-mL', start_at: DateTime.now.next_day(10), end_at: DateTime.now.next_day(20), minimum_bid: 100, minimum_bid_difference: 10, create_by: user)

      login_as leo

      patch "/batches/#{batch.id}/approve"
      follow_redirect!

      expect(response.body).to include 'Lote aprovado com sucesso'
    end
  end

  describe 'post /batches/:id/item/:item_id' do
    it 'adiciona item com sucesso' do
      user = User.create!(name: 'Admir', cpf: '054.732.630-03', email: 'admir@leilaodogalpao.com.br', password: 'password')
      category = Category.create!(name: 'Eletrônico', description: 'Incididunt officia occaecat consequat aliquip pariatur aute culpa.')
      item = Item.create!(name: 'Notebook Gamer Acer Nitro 5', description: 'Intel Core i7-11800H, GeForce GTX 1650, 8GB RAM, SSD 512GB, 15.6 Full HD 144Hz IPS, Windows 11, Preto - AN515-57-740K', weight: 2300, width: 363.4, height: 24.35, depth: 255, category: category, create_by: user)

      item.photo.attach(io: File.open(Rails.root.join('spec/support/img/Notebook Gamer Acer Nitro 5.png')), filename: 'Notebook Gamer Acer Nitro 5.png', content_type: "image/png")
      item.save!
      batch = Batch.create!(code: 'AcSx*1-mL', start_at: DateTime.now.next_day(10), end_at: DateTime.now.next_day(20), minimum_bid: 100, minimum_bid_difference: 10, create_by: user)

      login_as user

      post "/batches/#{batch.id}/item/#{item.id}"

      follow_redirect!

      expect(response.body).to include 'Item adicionado com sucesso!'
    end

    it 'adiciona item com sucesso' do
      user = User.create!(name: 'Admir', cpf: '054.732.630-03', email: 'admir@leilaodogalpao.com.br', password: 'password')
      category = Category.create!(name: 'Eletrônico', description: 'Incididunt officia occaecat consequat aliquip pariatur aute culpa.')
      item = Item.create!(name: 'Notebook Gamer Acer Nitro 5', description: 'Intel Core i7-11800H, GeForce GTX 1650, 8GB RAM, SSD 512GB, 15.6 Full HD 144Hz IPS, Windows 11, Preto - AN515-57-740K', weight: 2300, width: 363.4, height: 24.35, depth: 255, category: category, create_by: user)

      item.photo.attach(io: File.open(Rails.root.join('spec/support/img/Notebook Gamer Acer Nitro 5.png')), filename: 'Notebook Gamer Acer Nitro 5.png', content_type: "image/png")
      item.unavailable!
      batch = Batch.create!(code: 'AcSx*1-mL', start_at: DateTime.now.next_day(10), end_at: DateTime.now.next_day(20), minimum_bid: 100, minimum_bid_difference: 10, create_by: user)

      login_as user

      post "/batches/#{batch.id}/item/#{item.id}"

      follow_redirect!

      expect(response.body).to include 'Erro ao tentar adicionar item'
    end
  end
end

