require 'rails_helper'

describe 'Usuário vê lista de lotes na tela inicial' do

  it 'com sucesso' do

    user = User.create!(name: 'Admir', cpf: '054.732.630-03', email: 'admir@leilaodogalpao.com.br', password: 'password')

    travel_to 2.day.ago do
      batch = Batch.create!(code: 'AcSx*1-mL', start_at: DateTime.now.next_day, end_at: DateTime.now.next_day(20), minimum_bid: 100, minimum_bid_difference: 10, create_by: user)
      batch.approved!
    end

    next_batch = Batch.create!(code: 'GcSx*1-as', start_at: DateTime.now.next_day(10), end_at: DateTime.now.next_day(30), minimum_bid: 200, minimum_bid_difference: 20, create_by: user)

    visit root_path

    within '#current_batches' do
      expect(page).to have_content 'AcSx*1-m'
      expect(page).to have_content 'Lance mínimo inicial: R$ 100,00'
    end

    within '#next_batches' do
      expect(page).to have_content 'GcSx*1-as'
      expect(page).to have_content 'Lance mínimo inicial: R$ 200,00'
    end

  end

  it 'com sucesso e acessa um lote' do

    user = User.create!(name: 'Admir', cpf: '054.732.630-03', email: 'admir@leilaodogalpao.com.br', password: 'password')
    category = Category.create!(name: 'Eletrônico', description: 'Incididunt officia occaecat consequat aliquip pariatur aute culpa.')

    current_item = Item.create!(name: 'Notebook Gamer Acer Nitro 5', description: 'Intel Core i7-11800H, GeForce GTX 1650, 8GB RAM, SSD 512GB, 15.6 Full HD 144Hz IPS, Windows 11, Preto - AN515-57-740K', weight: 2300, width: 36.34, height: 2.435, depth: 25.5, category: category, create_by: user)
    batch = nil
    travel_to 2.day.ago do
      batch = Batch.create!(code: 'AcSx*1-mL', start_at: DateTime.now.next_day, end_at: DateTime.now.next_day(20), minimum_bid: 100, minimum_bid_difference: 10, create_by: user)
      batch.approved!
    end
    current_item.batch = batch
    current_item.unavailable!

    visit root_path

    find("a[href='/lotes/#{batch.id}']").click

    expect(page).to have_content 'AcSx*1-mL'
    expect(page).to have_content 'Lance mínimo inicial: R$ 100,00'

    within '#items' do
      expect(page).to have_content 'Notebook Gamer Acer Nitro 5'
      expect(page).to have_content '- 36.34(L) x 25.5(P) x 2.435(A) cm'
    end
  end
end
