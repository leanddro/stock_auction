require 'rails_helper'

describe 'Usuário faze busca com' do
  it 'código do lote' do
    admin = User.create!(name: 'Leo', cpf: '354.410.250-18', email: 'leo@leilaodogalpao.com.br', password: 'password')
    user = User.create!(name: 'Leandro', cpf: '713.289.120-00', email: 'leandro@email.com', password: 'password')

    category = Category.create!(name: 'Eletrônico', description: 'Incididunt officia occaecat consequat aliquip pariatur aute culpa.')

    current_item = Item.create!(name: 'Notebook Gamer Acer Nitro 5', description: 'Intel Core i7-11800H, GeForce GTX 1650, 8GB RAM, SSD 512GB, 15.6 Full HD 144Hz IPS, Windows 11, Preto - AN515-57-740K', weight: 2300, width: 36.34, height: 2.435, depth: 25.5, category: category, create_by: admin)
    current_batch = nil
    travel_to 1.month.ago do
      current_batch = Batch.new(code: 'AcSx*1-mL', start_at: DateTime.now.next_day, end_at: DateTime.now.next_day(20), minimum_bid: 100, minimum_bid_difference: 10, create_by: admin)
      current_batch.approved!
    end
    current_item.batch = current_batch
    current_item.unavailable!

    login_as user
    visit root_path

    fill_in 'Buscar', with: 'AcSx'
    click_on 'Buscar'

    expect(page).to have_content 'AcSx*1-mL'
  end
end

