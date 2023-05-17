require 'rails_helper'

RSpec.describe "Bids", type: :request do
  describe "POST /bids" do
    it 'retorna alerta quando lote vencido' do
      admin = User.create!(name: 'Admir', cpf: '054.732.630-03', email: 'admir@leilaodogalpao.com.br', password: 'password')
      user = User.create!(name: 'Leandro', cpf: '713.289.120-00', email: 'leandro@email.com', password: 'password')

      batch = nil


      batch = Batch.new(code: 'AcSx*1-mL', start_at: DateTime.now.prev_day(30), end_at: DateTime.now.prev_day(10), minimum_bid: 100, minimum_bid_difference: 10, create_by: admin)
      batch.save(validate: false)
      batch.approved!

      login_as user

      post "/bids", params: {
        bid:{
          amount: 200,
          batch_id: batch.id
        }
      }
      follow_redirect!

      expect(response.body).to include 'Lote já finalizado'
    end

    it 'retorna alerta quando lote não iniciado' do
      admin = User.create!(name: 'Leo', cpf: '354.410.250-18', email: 'leo@leilaodogalpao.com.br', password: 'password')
      user = User.create!(name: 'Leandro', cpf: '713.289.120-00', email: 'leandro@email.com', password: 'password')
      category = Category.create!(name: 'Eletrônico', description: 'Incididunt officia occaecat consequat aliquip pariatur aute culpa.')

      current_item = Item.create!(name: 'Notebook Gamer Acer Nitro 5', description: 'Intel Core i7-11800H, GeForce GTX 1650, 8GB RAM, SSD 512GB, 15.6 Full HD 144Hz IPS, Windows 11, Preto - AN515-57-740K', weight: 2300, width: 36.34, height: 2.435, depth: 25.5, category: category, create_by: admin)

      current_batch = Batch.new(code: 'AcSx*1-mL', start_at: DateTime.now.next_day(10), end_at: DateTime.now.next_day(20), minimum_bid: 100, minimum_bid_difference: 10, create_by: admin)
      current_batch.approved!
      current_item.batch = current_batch
      current_item.unavailable!

      login_as user

      post "/bids", params: {
        bid:{
          amount: 200,
          batch_id: current_batch.id
        }
      }
      follow_redirect!

      expect(response.body).to include 'Lote não iniciado'
    end

  end
end
