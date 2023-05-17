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
  end
end
