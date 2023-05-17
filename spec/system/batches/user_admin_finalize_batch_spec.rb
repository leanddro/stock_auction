require 'rails_helper'

describe 'Usuário admin finaliza lote' do
  it 'com data de fim passada' do
    admin = User.create!(name: 'Leo', cpf: '354.410.250-18', email: 'leo@leilaodogalpao.com.br', password: 'password')
    user = User.create!(name: 'Leandro', cpf: '713.289.120-00', email: 'leandro@email.com', password: 'password')
    category = Category.create!(name: 'Eletrônico', description: 'Incididunt officia occaecat consequat aliquip pariatur aute culpa.')

    item = Item.create!(name: 'Notebook Gamer Acer Nitro 5', description: 'Intel Core i7-11800H, GeForce GTX 1650, 8GB RAM, SSD 512GB, 15.6 Full HD 144Hz IPS, Windows 11, Preto - AN515-57-740K', weight: 2300, width: 36.34, height: 2.435, depth: 25.5, category: category, create_by: admin)
    batch = nil
    travel_to DateTime.now.prev_month do
      batch = Batch.new(code: 'AcSx*1-mL', start_at: DateTime.now.next_day, end_at: DateTime.now.next_day(10), minimum_bid: 100, minimum_bid_difference: 10, create_by: admin)
      batch.approved!
    end

    item.batch = batch
    item.unavailable!

    Bid.create!(batch:, user:, amount: 100)

    login_as admin
    visit root_path
    click_on 'Lotes'

    within '#finalizing' do
      find("a[href='/batches/#{batch.id}']").click
    end

    click_on 'Finalizar'

    expect(page).to have_content 'Ganhador: Leandro'
    expect(page).to have_content 'Lote finalizado com sucesso'
  end

  it 'com data de fim maior que atual' do
    admin = User.create!(name: 'Leo', cpf: '354.410.250-18', email: 'leo@leilaodogalpao.com.br', password: 'password')
    user = User.create!(name: 'Leandro', cpf: '713.289.120-00', email: 'leandro@email.com', password: 'password')
    category = Category.create!(name: 'Eletrônico', description: 'Incididunt officia occaecat consequat aliquip pariatur aute culpa.')

    item = Item.create!(name: 'Notebook Gamer Acer Nitro 5', description: 'Intel Core i7-11800H, GeForce GTX 1650, 8GB RAM, SSD 512GB, 15.6 Full HD 144Hz IPS, Windows 11, Preto - AN515-57-740K', weight: 2300, width: 36.34, height: 2.435, depth: 25.5, category: category, create_by: admin)

    batch = Batch.new(code: 'AcSx*1-mL', start_at: DateTime.now.next_day, end_at: DateTime.now.next_day(20), minimum_bid: 100, minimum_bid_difference: 10, create_by: admin)

    batch.approved!
    item.batch = batch
    item.unavailable!

    Bid.create!(batch:, user:, amount: 100)

    login_as admin
    visit "batches/#{batch.id}"

    click_on 'Finalizar'

    expect(page).to have_content 'Data atual menor que a data de fim, nesse caso só pode ser cancelado'
  end
end
