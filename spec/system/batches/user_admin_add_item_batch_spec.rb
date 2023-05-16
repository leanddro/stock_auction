require 'rails_helper'

describe 'Usuário administrador adiciona itens ao lote' do
  it 'exibe item que podem ser adicionado' do
    user = User.create!(name: 'Admir', cpf: '054.732.630-03', email: 'admir@leilaodogalpao.com.br', password: 'password')
    category = Category.create!(name: 'Eletrônico', description: 'Incididunt officia occaecat consequat aliquip pariatur aute culpa.')
    item = Item.create!(name: 'Notebook Gamer Acer Nitro 5', description: 'Intel Core i7-11800H, GeForce GTX 1650, 8GB RAM, SSD 512GB, 15.6 Full HD 144Hz IPS, Windows 11, Preto - AN515-57-740K', weight: 2300, width: 363.4, height: 24.35, depth: 255, category: category, create_by: user)

    item.photo.attach(io: File.open(Rails.root.join('spec/support/img/Notebook Gamer Acer Nitro 5.png')), filename: 'Notebook Gamer Acer Nitro 5.png', content_type: "image/png")
    item.save!
    batch = Batch.create!(code: 'AcSx*1-mL', start_at: DateTime.now.next_day(10), end_at: DateTime.now.next_day(20), minimum_bid: 100, minimum_bid_difference: 10, create_by: user)

    login_as user

    visit root_path
    click_on 'Lotes'
    find("a[href='/batches/#{batch.id}']").click

    expect(page).to have_content 'Notebook Gamer Acer Nitro 5'
  end

  it 'adiciona item a lote' do
    user = User.create!(name: 'Admir', cpf: '054.732.630-03', email: 'admir@leilaodogalpao.com.br', password: 'password')
    category = Category.create!(name: 'Eletrônico', description: 'Incididunt officia occaecat consequat aliquip pariatur aute culpa.')
    item = Item.create!(name: 'Notebook Gamer Acer Nitro 5', description: 'Intel Core i7-11800H, GeForce GTX 1650, 8GB RAM, SSD 512GB, 15.6 Full HD 144Hz IPS, Windows 11, Preto - AN515-57-740K', weight: 2300, width: 363.4, height: 24.35, depth: 255, category: category, create_by: user)

    item.photo.attach(io: File.open(Rails.root.join('spec/support/img/Notebook Gamer Acer Nitro 5.png')), filename: 'Notebook Gamer Acer Nitro 5.png', content_type: "image/png")
    item.save!
    batch = Batch.create!(code: 'AcSx*1-mL', start_at: DateTime.now.next_day(10), end_at: DateTime.now.next_day(20), minimum_bid: 100, minimum_bid_difference: 10, create_by: user)

    login_as user

    visit root_path
    click_on 'Lotes'
    find("a[href='/batches/#{batch.id}']").click

    within '#add_items' do
      find("a[href='/batches/#{batch.id}/item/#{item.id}']").click
    end
    within '#add_items' do
      expect(page).not_to have_content 'Notebook Gamer Acer Nitro 5'
    end
    expect(Item.first.batch_id).to eq batch.id
  end
end
