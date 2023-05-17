require 'rails_helper'

describe 'Usuário faze lances' do
  it 'quando logado' do
    admin = User.create!(name: 'Leo', cpf: '354.410.250-18', email: 'leo@leilaodogalpao.com.br', password: 'password')
    user = User.create!(name: 'Leandro', cpf: '713.289.120-00', email: 'leandro@email.com', password: 'password')
    category = Category.create!(name: 'Eletrônico', description: 'Incididunt officia occaecat consequat aliquip pariatur aute culpa.')

    current_item = Item.create!(name: 'Notebook Gamer Acer Nitro 5', description: 'Intel Core i7-11800H, GeForce GTX 1650, 8GB RAM, SSD 512GB, 15.6 Full HD 144Hz IPS, Windows 11, Preto - AN515-57-740K', weight: 2300, width: 36.34, height: 2.435, depth: 25.5, category: category, create_by: admin)

    current_batch = Batch.new(code: 'AcSx*1-mL', start_at: DateTime.now.prev_day(50), end_at: DateTime.now.next_day, minimum_bid: 100, minimum_bid_difference: 10, create_by: admin)
    current_batch.save(validate: false)
    current_batch.approved!
    current_item.batch = current_batch
    current_item.unavailable!

    login_as user
    visit root_path

    find("a[href='/lotes/#{current_batch.id}']").click

    fill_in 'Valor', with: 100
    click_on 'Fazer lance'

    expect(page).to have_content 'O lance foi feito com sucesso'
  end

  it 'quando não logado' do
    user = User.create!(name: 'Leandro', cpf: '713.289.120-00', email: 'leandro@email.com', password: 'password')
    category = Category.create!(name: 'Eletrônico', description: 'Incididunt officia occaecat consequat aliquip pariatur aute culpa.')

    current_item = Item.create!(name: 'Notebook Gamer Acer Nitro 5', description: 'Intel Core i7-11800H, GeForce GTX 1650, 8GB RAM, SSD 512GB, 15.6 Full HD 144Hz IPS, Windows 11, Preto - AN515-57-740K', weight: 2300, width: 36.34, height: 2.435, depth: 25.5, category: category, create_by: user)
    current_batch = Batch.new(code: 'AcSx*1-mL', start_at: DateTime.now.prev_day(50), end_at: DateTime.now.next_day, minimum_bid: 100, minimum_bid_difference: 10, create_by: user)
    current_batch.save(validate: false)
    current_batch.approved!
    current_item.batch = current_batch
    current_item.unavailable!

    visit root_path

    find("a[href='/lotes/#{current_batch.id}']").click

    fill_in 'Valor', with: 100
    click_on 'Fazer lance'

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se'
  end

  it 'quando logado como admin' do
    user = User.create!(name: 'Leo', cpf: '354.410.250-18', email: 'leo@leilaodogalpao.com.br', password: 'password')
    category = Category.create!(name: 'Eletrônico', description: 'Incididunt officia occaecat consequat aliquip pariatur aute culpa.')

    current_item = Item.create!(name: 'Notebook Gamer Acer Nitro 5', description: 'Intel Core i7-11800H, GeForce GTX 1650, 8GB RAM, SSD 512GB, 15.6 Full HD 144Hz IPS, Windows 11, Preto - AN515-57-740K', weight: 2300, width: 36.34, height: 2.435, depth: 25.5, category: category, create_by: user)
    current_batch = Batch.new(code: 'AcSx*1-mL', start_at: DateTime.now.prev_day(50), end_at: DateTime.now.next_day, minimum_bid: 100, minimum_bid_difference: 10, create_by: user)
    current_batch.save(validate: false)
    current_batch.approved!
    current_item.batch = current_batch
    current_item.unavailable!

    login_as user
    visit root_path

    find("a[href='/lotes/#{current_batch.id}']").click

    fill_in 'Valor', with: 100
    click_on 'Fazer lance'

    expect(page).to have_content 'Usuários administradores não podem participar do leilão'
  end

  it 'quando lance menor que diferença minima' do
    admin = User.create!(name: 'Leo', cpf: '354.410.250-18', email: 'leo@leilaodogalpao.com.br', password: 'password')
    user = User.create!(name: 'Leandro', cpf: '713.289.120-00', email: 'leandro@email.com', password: 'password')
    joao = User.create!(name: 'João', cpf: '495.820.520-90', email: 'joao@email.com', password: 'password')

    category = Category.create!(name: 'Eletrônico', description: 'Incididunt officia occaecat consequat aliquip pariatur aute culpa.')

    current_item = Item.create!(name: 'Notebook Gamer Acer Nitro 5', description: 'Intel Core i7-11800H, GeForce GTX 1650, 8GB RAM, SSD 512GB, 15.6 Full HD 144Hz IPS, Windows 11, Preto - AN515-57-740K', weight: 2300, width: 36.34, height: 2.435, depth: 25.5, category: category, create_by: admin)
    current_batch = Batch.new(code: 'AcSx*1-mL', start_at: DateTime.now.prev_day(50), end_at: DateTime.now.next_day, minimum_bid: 100, minimum_bid_difference: 10, create_by: admin)
    current_batch.save(validate: false)
    current_batch.approved!
    current_item.batch = current_batch
    current_item.unavailable!
    Bid.create!(batch: current_batch, user: joao, amount: 100)

    login_as user
    visit root_path

    find("a[href='/lotes/#{current_batch.id}']").click

    fill_in 'Valor', with: 100
    click_on 'Fazer lance'

    expect(page).to have_content 'O lance tem que ser maior que o ultimo lance mais a diferença minima'
  end

  it 'quando o lance e maior que anterior com diferença minima' do
    admin = User.create!(name: 'Leo', cpf: '354.410.250-18', email: 'leo@leilaodogalpao.com.br', password: 'password')
    user = User.create!(name: 'Leandro', cpf: '713.289.120-00', email: 'leandro@email.com', password: 'password')
    joao = User.create!(name: 'João', cpf: '495.820.520-90', email: 'joao@email.com', password: 'password')

    category = Category.create!(name: 'Eletrônico', description: 'Incididunt officia occaecat consequat aliquip pariatur aute culpa.')

    current_item = Item.create!(name: 'Notebook Gamer Acer Nitro 5', description: 'Intel Core i7-11800H, GeForce GTX 1650, 8GB RAM, SSD 512GB, 15.6 Full HD 144Hz IPS, Windows 11, Preto - AN515-57-740K', weight: 2300, width: 36.34, height: 2.435, depth: 25.5, category: category, create_by: admin)
    current_batch = Batch.new(code: 'AcSx*1-mL', start_at: DateTime.now.prev_day(50), end_at: DateTime.now.next_day, minimum_bid: 100, minimum_bid_difference: 10, create_by: admin)
    current_batch.save(validate: false)
    current_batch.approved!
    current_item.batch = current_batch
    current_item.unavailable!
    Bid.create!(batch: current_batch, user: joao, amount: 100)

    login_as user
    visit root_path

    find("a[href='/lotes/#{current_batch.id}']").click

    fill_in 'Valor', with: 120
    click_on 'Fazer lance'

    expect(page).to have_content 'O lance foi feito com sucesso'
    expect(page).to have_content 'Ultimo lance: R$ 120,00'
  end

end

