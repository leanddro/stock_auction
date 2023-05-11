require 'rails_helper'

describe 'Usuário admin ver pagina de detalhes do item' do
  it 'com sucesso' do
    user = User.create!(name: 'Admir', cpf: '054.732.630-03', email: 'admir@leilaodogalpao.com.br', password: 'password')
    category = Category.create!(name: 'Eletrônico', description: 'Incididunt officia occaecat consequat aliquip pariatur aute culpa.')
    item = Item.create!(name: 'Notebook Gamer Acer Nitro 5', description: 'Intel Core i7-11800H, GeForce GTX 1650, 8GB RAM, SSD 512GB, 15.6 Full HD 144Hz IPS, Windows 11, Preto - AN515-57-740K', weight: 2300, width: 363.4, height: 24.35, depth: 255, category: category, create_by: user)

    login_as user
    visit root_path

    within 'nav' do
      click_on 'Itens'
    end
    find("a[href='/items/#{item.id}']").click

    expect(current_path).to eq item_path(item.id)
    expect(page).to have_content 'Notebook Gamer Acer Nitro 5'
    expect(page).to have_content 'Intel Core i7-11800H, GeForce GTX 1650, 8GB RAM, SSD 512GB, 15.6 Full HD 144Hz IPS, Windows 11, Preto - AN515-57-740K'
    expect(page).to have_content '- 363.4(L) x 255.0(P) x 24.35(A) cm'
  end

  it 'com sucesso com imagem' do
    user = User.create!(name: 'Admir', cpf: '054.732.630-03', email: 'admir@leilaodogalpao.com.br', password: 'password')
    category = Category.create!(name: 'Eletrônico', description: 'Incididunt officia occaecat consequat aliquip pariatur aute culpa.')
    item = Item.create!(name: 'Notebook Gamer Acer Nitro 5', description: 'Intel Core i7-11800H, GeForce GTX 1650, 8GB RAM, SSD 512GB, 15.6 Full HD 144Hz IPS, Windows 11, Preto - AN515-57-740K', weight: 2300, width: 363.4, height: 24.35, depth: 255, category: category, create_by: user)

    item.photo.attach(io: File.open(Rails.root.join('spec/support/img/Notebook Gamer Acer Nitro 5.png')), filename: 'Notebook Gamer Acer Nitro 5.png', content_type: "image/png")
    item.save!

    login_as user
    visit root_path

    within 'nav' do
      click_on 'Itens'
    end
    find("a[href='/items/#{item.id}']").click

    img = URI.encode_uri_component 'Notebook Gamer Acer Nitro 5.png'

    expect(page).to have_css "img[src*='#{img}']"
    expect(current_path).to eq item_path(item.id)
    expect(page).to have_content 'Notebook Gamer Acer Nitro 5'
    expect(page).to have_content 'Intel Core i7-11800H, GeForce GTX 1650, 8GB RAM, SSD 512GB, 15.6 Full HD 144Hz IPS, Windows 11, Preto - AN515-57-740K'
    expect(page).to have_content '- 363.4(L) x 255.0(P) x 24.35(A) cm'
  end
end

