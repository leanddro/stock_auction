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
end

